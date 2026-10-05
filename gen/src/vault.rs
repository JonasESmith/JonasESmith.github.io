//! Vault loading: `profile.md`, `projects/*.md`, `skills/*.md` (YAML frontmatter + markdown body).

use anyhow::{anyhow, bail, Context, Result};
use chrono::NaiveDate;
use serde::de::DeserializeOwned;
use serde::Deserialize;
use std::fs;
use std::path::Path;

#[derive(Deserialize)]
pub struct Profile {
    pub name: String,
    pub handle: String,
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
    pub title: String,
    pub description: Option<String>,
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
}

#[derive(Deserialize)]
pub struct Tech {
    pub name: String,
    pub url: Option<String>,
}

#[derive(Deserialize)]
pub struct Skill {
    pub name: String,
    #[serde(default)]
    pub order: i32,
    #[serde(default)]
    pub draft: bool,
    pub start: NaiveDate,
    pub end: Option<NaiveDate>,
    #[serde(default)]
    #[allow(dead_code)] // schema: not shown in the Flutter layout yet
    pub sub_skills: Vec<String>,
    #[serde(skip)]
    pub body: String,
}

pub struct Site {
    pub profile: Profile,
    pub projects: Vec<Project>,
    pub skills: Vec<Skill>,
}

impl Site {
    pub fn project_by_title(&self, title: &str) -> Option<&Project> {
        self.projects.iter().find(|p| p.title.eq_ignore_ascii_case(title.trim()))
    }
}

/// URL slug. Matches the Flutter site's scheme (`/project/Rock-Climber-Guide`) so old links keep working.
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

    let mut projects: Vec<Project> = parse_dir(&dir.join("projects"))?
        .into_iter()
        .filter(|p: &Project| drafts || !p.draft)
        .collect();
    projects.sort_by_key(|p| p.order);
    for p in &mut projects {
        p.slug = slug(&p.title);
    }

    let mut skills: Vec<Skill> =
        parse_dir(&dir.join("skills"))?.into_iter().filter(|s: &Skill| drafts || !s.draft).collect();
    skills.sort_by_key(|s| s.order);

    Ok(Site { profile, projects, skills })
}

trait HasBody {
    fn set_body(&mut self, body: String);
}
impl HasBody for Project {
    fn set_body(&mut self, body: String) {
        self.body = body;
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
            out.push(item);
        }
    }
    Ok(out)
}

fn parse_file<T: DeserializeOwned>(path: &Path) -> Result<T> {
    let text = fs::read_to_string(path).with_context(|| format!("reading {}", path.display()))?;
    let (fm, _) = split_frontmatter(&text).ok_or_else(|| anyhow!("{}: missing frontmatter", path.display()))?;
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
