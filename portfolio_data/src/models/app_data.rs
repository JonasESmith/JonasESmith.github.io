use schemars::JsonSchema;
use serde::*;

///
///
#[derive(Deserialize, Serialize, JsonSchema)]
pub struct AppData {
    pub nav_width: i32,
    pub nav_index: i32,
    pub profile: Profile,
    pub urls: Vec<String>,
    pub skills: Vec<Skill>,
    pub projects: Vec<Project>,
    pub theme_is_collapsed: bool,
    pub work: Vec<WorkExperience>,
    pub show_mouse_follower: bool,
    /// 0.05 -> 0.5
    pub mouse_follower_opacity: f32,
    /// where did our user leave off last time?
    pub is_about_me_open: bool,
    pub last_url: Option<String>,
    pub visited: Option<Vec<String>>,
    pub is_search_open: bool,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct Project {
    pub title: String,
    pub end_msse: i64,
    pub start_msse: i64,
    /// our content in the form of markdown
    pub content: String,
    pub url: Option<String>,
    pub description: String,
    pub lessons: Vec<String>,
    pub color: (i32, i32, i32),
    pub icon_asset_path: String,
    pub img_urls: Option<Vec<ImageUrl>>,
    pub technologies: Vec<Technology>,
    pub completion_type: CompletionType,
    pub platforms: Option<Vec<PlatForms>>,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct ImageUrl {
    pub url: String,
    pub thumb_nail: String,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub enum PlatForms {
    IOs { url: Option<String> },
    Web { url: Option<String> },
    IPad { url: Option<String> },
    MacOs { url: Option<String> },
    Linux { url: Option<String> },
    Watch { url: Option<String> },
    Windows { url: Option<String> },
    Android { url: Option<String> },
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub enum CompletionType {
    Active,
    Innactive,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct Technology {
    pub label: String,
    pub url: Option<String>,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct WorkExperience {
    pub title: String,
    pub end_msse: i64,
    pub start_msse: i64,
    pub content: String,
    pub url: Option<String>,
    pub lessons: Vec<String>,
    pub company_name: String,
    pub icon_asset_path: String,
    pub technologies: Vec<String>,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct Profile {
    pub name: String,
    pub email: String,
    pub birth_date: i64,
    pub links: Vec<String>,
    pub image_path: String,
    pub description: String,
    pub phone_number: String,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub struct Skill {
    pub name: String,
    pub content: String,
    pub url: Option<String>,
    pub experience: Experience,
    pub tags: Option<Vec<String>>,
    pub end_msse: Option<String>,
    pub start_msse: Option<String>,
    pub skills: Option<Vec<Skill>>,
    /// this will link directly to our project that uses this skill!
    pub project_ids: Option<Vec<String>>,
}

#[derive(Deserialize, Serialize, JsonSchema)]
pub enum Experience {
    Learning,
    Experienced,
    Professional,
}
