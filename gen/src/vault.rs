//! Vault loading: `profile.md` plus one folder per entry in `SECTIONS` (YAML frontmatter + markdown body).

use anyhow::{bail, Context, Result};
use chrono::NaiveDate;
use serde::de::DeserializeOwned;
use serde::Deserialize;
use std::fs;
use std::path::Path;

/// Which page template a section's notes render with (and which frontmatter they take).
#[derive(Clone, Copy, PartialEq)]
pub enum Layout {
    Project,
    Skill,
}

pub struct Section {
    /// Folder under the vault.
    pub dir: &'static str,
    /// Home page heading; `None` keeps the section off the home page (reachable via `[[links]]` only).
    pub heading: Option<&'static str>,
    /// URL prefix: pages live at `/{url}/{slug}/`.
    pub url: &'static str,
    pub layout: Layout,
}

/// Home page order. `work` and `hobbies` share URL prefixes with `projects` and `skills`, so a
/// note keeps its URL when it moves between them.
pub const SECTIONS: &[Section] = &[
    Section { dir: "work", heading: Some("Work"), url: "project", layout: Layout::Project },
    Section { dir: "projects", heading: Some("Notable Projects"), url: "project", layout: Layout::Project },
    Section { dir: "hobbies", heading: Some("Hobbies"), url: "skill", layout: Layout::Skill },
    Section { dir: "skills", heading: Some("Skills"), url: "skill", layout: Layout::Skill },
    Section { dir: "details", heading: None, url: "details", layout: Layout::Project },
];

#[derive(Deserialize)]
pub struct Profile {
    pub name: String,
    pub handle: String,
    /// One-line role under the handle on the home card ("Full-stack software engineer").
    pub role: Option<String>,
    pub birth_date: NaiveDate,
    pub avatar: String,
    pub email: String,
    #[serde(default)]
    pub links: Vec<String>,
    #[serde(skip)]
    pub body: String,
}

#[derive(Deserialize)]
pub struct Project {
    /// Defaults to the file name, so a `details/` note needs no frontmatter.
    #[serde(default)]
    pub title: String,
    pub description: Option<String>,
    /// Short tag shown after the title on the home page ("Social media platform").
    pub subtitle: Option<String>,
    #[serde(default)]
    pub order: i32,
    #[serde(default)]
    pub draft: bool,
    pub url: Option<String>,
    pub icon: Option<String>,
    #[allow(dead_code)] // schema: not shown in the Flutter layout yet
    pub start: Option<NaiveDate>,
    #[allow(dead_code)]
    pub end: Option<NaiveDate>,
    #[serde(default)]
    pub platforms: Vec<String>,
    #[serde(default)]
    pub technologies: Vec<Tech>,
    #[serde(default)]
    pub gallery: Vec<String>,
    #[serde(skip)]
    pub body: String,
    #[serde(skip)]
    pub slug: String,
    /// Index into `SECTIONS`.
    #[serde(skip)]
    pub section: usize,
}

#[derive(Deserialize)]
pub struct Tech {
    pub name: String,
    pub url: Option<String>,
}

#[derive(Deserialize)]
pub struct Skill {
    pub name: String,
    /// Short tag shown after the name on the home page.
    pub subtitle: Option<String>,
    #[serde(default)]
    pub order: i32,
    #[serde(default)]
    pub draft: bool,
    pub start: NaiveDate,
    pub end: Option<NaiveDate>,
    #[serde(default)]
    pub sub_skills: Vec<SubSkill>,
    #[serde(skip)]
    pub body: String,
    #[serde(skip)]
    pub slug: String,
    /// Index into `SECTIONS`.
    #[serde(skip)]
    pub section: usize,
}

/// `- Bloc` or `- { name: Bloc, note: State management }`.
#[derive(Deserialize)]
#[serde(untagged)]
pub enum SubSkill {
    Name(String),
    Full { name: String, note: Option<String> },
}

impl SubSkill {
    pub fn name(&self) -> &str {
        match self {
            SubSkill::Name(n) | SubSkill::Full { name: n, .. } => n,
        }
    }
    pub fn note(&self) -> Option<&str> {
        match self {
            SubSkill::Name(_) => None,
            SubSkill::Full { note, .. } => note.as_deref(),
        }
    }
}

impl Project {
    pub fn url(&self) -> String {
        format!("/{}/{}/", SECTIONS[self.section].url, self.slug)
    }
}

impl Skill {
    pub fn url(&self) -> String {
        format!("/{}/{}/", SECTIONS[self.section].url, self.slug)
    }
}

/// Every section's notes, sorted by section then `order`.
pub struct Site {
    pub profile: Profile,
    pub projects: Vec<Project>,
    pub skills: Vec<Skill>,
}

impl Site {
    /// URL for a wikilink target: a project-layout title, else a skill name (case-insensitive).
    pub fn link(&self, target: &str) -> Option<String> {
        let t = target.trim();
        self.projects
            .iter()
            .find(|p| p.title.eq_ignore_ascii_case(t))
            .map(Project::url)
            .or_else(|| self.skills.iter().find(|s| s.name.eq_ignore_ascii_case(t)).map(Skill::url))
    }
}

/// URL slug. Matches the Flutter site's scheme (`/project/Pakmo`) so old links keep working.
pub fn slug(title: &str) -> String {
    title
        .trim()
        .chars()
        .filter_map(|c| match c {
            ' ' => Some('-'),
            c if c.is_ascii_alphanumeric() || c == '-' || c == '_' => Some(c),
            _ => None,
        })
        .collect()
}

pub fn load(dir: &Path, drafts: bool) -> Result<Site> {
    if !dir.is_dir() {
        bail!("vault not found at {}", dir.display());
    }
    let mut profile: Profile = parse_file(&dir.join("profile.md"))?;
    profile.body = body_of(&dir.join("profile.md"))?;

    let (mut projects, mut skills) = (Vec::new(), Vec::new());
    for (i, sec) in SECTIONS.iter().enumerate() {
        let sec_dir = dir.join(sec.dir);
        match sec.layout {
            Layout::Project => {
                let mut items: Vec<Project> =
                    parse_dir(&sec_dir)?.into_iter().filter(|p: &Project| drafts || !p.draft).collect();
                items.sort_by_key(|p| p.order);
                for p in &mut items {
                    p.slug = slug(&p.title);
                    p.section = i;
                }
                projects.extend(items);
            }
            Layout::Skill => {
                let mut items: Vec<Skill> =
                    parse_dir(&sec_dir)?.into_iter().filter(|s: &Skill| drafts || !s.draft).collect();
                items.sort_by_key(|s| s.order);
                for s in &mut items {
                    s.slug = slug(&s.name);
                    s.section = i;
                }
                skills.extend(items);
            }
        }
    }

    // Sections share URL prefixes, so two notes could claim the same page.
    let mut seen = std::collections::HashSet::new();
    for url in projects.iter().map(Project::url).chain(skills.iter().map(Skill::url)) {
        if !seen.insert(url.clone()) {
            bail!("two vault notes map to the same page {url}");
        }
    }

    Ok(Site { profile, projects, skills })
}

trait HasBody {
    fn set_body(&mut self, body: String);
    /// Called with the file stem, for notes whose frontmatter leaves the title out.
    fn default_title(&mut self, _stem: &str) {}
}
impl HasBody for Project {
    fn set_body(&mut self, body: String) {
        self.body = body;
    }
    fn default_title(&mut self, stem: &str) {
        if self.title.trim().is_empty() {
            self.title = stem.to_string();
        }
    }
}
impl HasBody for Skill {
    fn set_body(&mut self, body: String) {
        self.body = body;
    }
}

fn parse_dir<T: DeserializeOwned + HasBody>(dir: &Path) -> Result<Vec<T>> {
    let mut out = Vec::new();
    if !dir.is_dir() {
        return Ok(out);
    }
    for entry in fs::read_dir(dir)? {
        let path = entry?.path();
        if path.extension().is_some_and(|e| e == "md") {
            let mut item: T = parse_file(&path)?;
            item.set_body(body_of(&path)?);
            item.default_title(&path.file_stem().unwrap_or_default().to_string_lossy());
            out.push(item);
        }
    }
    Ok(out)
}

fn parse_file<T: DeserializeOwned>(path: &Path) -> Result<T> {
    let text = fs::read_to_string(path).with_context(|| format!("reading {}", path.display()))?;
    // No frontmatter parses as an empty map: fine for a `details/` note, while required
    // fields (a skill's `start`) still fail below with the file named.
    let fm = split_frontmatter(&text).map_or("{}", |(fm, _)| fm);
    serde_yaml::from_str(fm).with_context(|| format!("{}: bad frontmatter", path.display()))
}

fn body_of(path: &Path) -> Result<String> {
    let text = fs::read_to_string(path)?;
    Ok(split_frontmatter(&text).map(|(_, b)| b).unwrap_or(&text).to_string())
}

fn split_frontmatter(text: &str) -> Option<(&str, &str)> {
    let rest = text.strip_prefix("---\n")?;
    let end = rest.find("\n---")?;
    let body = rest[end + 4..].trim_start_matches(|c| c != '\n').trim_start_matches('\n');
    Some((&rest[..end], body))
}
