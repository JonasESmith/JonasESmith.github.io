//! Build-time syntax highlighting: a small tokenizer emitting one-letter span classes
//! (`c` comment, `k` keyword, `s` string, `n` number, `t` type, `f` function, `a` attribute/macro).
//! Colours come from the a11y-light / a11y-dark palettes the Flutter site used (see site.css).
//! Unknown languages still get comments, strings and numbers.

use crate::page::esc;

struct Lang {
    line_comments: &'static [&'static str],
    block_comment: Option<(&'static str, &'static str)>,
    keywords: &'static [&'static str],
    /// `#[...]` (Rust) / `@name` (Dart, Python, TS) attributes.
    attrs: bool,
}

const RUST: Lang = Lang {
    line_comments: &["//"],
    block_comment: Some(("/*", "*/")),
    keywords: &[
        "as", "async", "await", "break", "const", "continue", "crate", "dyn", "else", "enum", "extern", "false", "fn",
        "for", "if", "impl", "in", "let", "loop", "match", "mod", "move", "mut", "pub", "ref", "return", "self", "Self",
        "static", "struct", "super", "trait", "true", "type", "unsafe", "use", "where", "while",
    ],
    attrs: true,
};
const SHELL: Lang = Lang {
    line_comments: &["#"],
    block_comment: None,
    keywords: &[
        "if", "then", "else", "elif", "fi", "for", "in", "do", "done", "while", "case", "esac", "function", "return",
        "export", "local", "cd", "echo", "cargo", "git", "just", "sudo",
    ],
    attrs: false,
};
const JS: Lang = Lang {
    line_comments: &["//"],
    block_comment: Some(("/*", "*/")),
    keywords: &[
        "async", "await", "break", "case", "catch", "class", "const", "continue", "default", "else", "export", "extends",
        "false", "finally", "for", "from", "function", "if", "import", "in", "interface", "let", "new", "null", "of",
        "return", "static", "switch", "this", "throw", "true", "try", "type", "typeof", "undefined", "var", "while",
    ],
    attrs: true,
};
const DART: Lang = Lang {
    line_comments: &["//"],
    block_comment: Some(("/*", "*/")),
    keywords: &[
        "abstract", "async", "await", "break", "case", "class", "const", "continue", "else", "enum", "extends", "false",
        "final", "for", "if", "implements", "import", "in", "late", "new", "null", "required", "return", "static",
        "super", "switch", "this", "true", "var", "void", "while", "with",
    ],
    attrs: true,
};
const PYTHON: Lang = Lang {
    line_comments: &["#"],
    block_comment: None,
    keywords: &[
        "and", "as", "async", "await", "break", "class", "continue", "def", "elif", "else", "except", "False", "finally",
        "for", "from", "if", "import", "in", "is", "lambda", "None", "not", "or", "pass", "raise", "return", "True",
        "try", "while", "with", "yield",
    ],
    attrs: true,
};
const GENERIC: Lang = Lang { line_comments: &["//", "#"], block_comment: Some(("/*", "*/")), keywords: &[], attrs: false };

fn lang(name: &str) -> &'static Lang {
    match name.to_ascii_lowercase().as_str() {
        "rust" | "rs" => &RUST,
        "bash" | "sh" | "shell" | "zsh" | "console" => &SHELL,
        "js" | "javascript" | "ts" | "typescript" | "jsx" | "tsx" => &JS,
        "dart" => &DART,
        "python" | "py" => &PYTHON,
        _ => &GENERIC,
    }
}

pub fn highlight(code: &str, lang_name: &str) -> String {
    let l = lang(lang_name);
    let mut out = String::with_capacity(code.len() * 2);
    let span = |out: &mut String, class: &str, text: &str| {
        out.push_str("<span class=\"");
        out.push_str(class);
        out.push_str("\">");
        out.push_str(&esc(text));
        out.push_str("</span>");
    };
    let bytes = code.as_bytes();
    let mut i = 0;
    while i < code.len() {
        let rest = &code[i..];
        // Comments
        if let Some(lc) = l.line_comments.iter().find(|lc| rest.starts_with(**lc)) {
            // `#` only starts a comment at line start or after whitespace (avoids `#[attr]`, `$#`).
            if *lc != "#" || i == 0 || bytes[i - 1].is_ascii_whitespace() {
                if !(l.attrs && rest.starts_with("#[")) {
                    let end = rest.find('\n').unwrap_or(rest.len());
                    span(&mut out, "c", &rest[..end]);
                    i += end;
                    continue;
                }
            }
        }
        if let Some((open, close)) = l.block_comment {
            if rest.starts_with(open) {
                let end = rest[open.len()..].find(close).map_or(rest.len(), |e| e + open.len() + close.len());
                span(&mut out, "c", &rest[..end]);
                i += end;
                continue;
            }
        }
        let c = rest.chars().next().unwrap();
        // Attributes / decorators
        if l.attrs && (rest.starts_with("#[") || rest.starts_with("#![")) {
            let end = rest.find(']').map_or(rest.len(), |e| e + 1);
            span(&mut out, "a", &rest[..end]);
            i += end;
            continue;
        }
        if l.attrs && c == '@' {
            let end = 1 + rest[1..].find(|ch: char| !(ch.is_alphanumeric() || ch == '_')).unwrap_or(rest.len() - 1);
            span(&mut out, "a", &rest[..end]);
            i += end;
            continue;
        }
        // Strings (no multi-line raw string support; good enough for snippets)
        if c == '"' || c == '\'' || c == '`' {
            // Rust lifetimes / char literals: treat `'a` (no closing quote soon) as plain text.
            let close = rest[1..]
                .char_indices()
                .scan(false, |escaped, (j, ch)| {
                    let hit = !*escaped && ch == c;
                    *escaped = !*escaped && ch == '\\';
                    Some((j, hit, ch))
                })
                .take_while(|(_, _, ch)| *ch != '\n' || c == '`')
                .find(|(_, hit, _)| *hit)
                .map(|(j, _, _)| j + 2);
            if let Some(end) = close {
                if !(c == '\'' && end > 4 && std::ptr::eq(l, &RUST)) {
                    span(&mut out, "s", &rest[..end]);
                    i += end;
                    continue;
                }
            }
        }
        // Numbers
        if c.is_ascii_digit() && (i == 0 || !(bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_')) {
            let end = rest.find(|ch: char| !(ch.is_ascii_alphanumeric() || ch == '.' || ch == '_')).unwrap_or(rest.len());
            span(&mut out, "n", &rest[..end]);
            i += end;
            continue;
        }
        // Identifiers
        if c.is_alphabetic() || c == '_' {
            let end = rest.find(|ch: char| !(ch.is_alphanumeric() || ch == '_')).unwrap_or(rest.len());
            let word = &rest[..end];
            let next = rest[end..].chars().next();
            let class = if l.keywords.contains(&word) {
                Some("k")
            } else if next == Some('!') && std::ptr::eq(l, &RUST) {
                Some("a")
            } else if next == Some('(') {
                Some("f")
            } else if word.chars().next().is_some_and(char::is_uppercase) && word.chars().any(char::is_lowercase) {
                Some("t")
            } else {
                None
            };
            match class {
                Some(cl) => span(&mut out, cl, word),
                None => out.push_str(&esc(word)),
            }
            i += end;
            continue;
        }
        out.push_str(&esc(&rest[..c.len_utf8()]));
        i += c.len_utf8();
    }
    out
}
