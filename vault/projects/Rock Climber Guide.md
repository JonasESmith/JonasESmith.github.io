---
title: "Rock Climber Guide"
description: "Climbers bible"
order: 3
draft: false
icon: "rcg.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "Rust"
    url: "https://www.rust-lang.org/"
  - name: "Rust API"
  - name: "Bloc"
    url: "https://pub.dev/packages/bloc"
  - name: "FlutterModular"
    url: "https://pub.dev/packages/flutter_modular"
gallery:
  - "rcg_sessions_running_light.png"
  - "rcg_sessions_page.png"
  - "rcg_session_running.png"
  - "rcg_log_climb.png"
  - "rcg_repeater_setup.png"
  - "rcg_tabata_running.png"
  - "rcg_records_page.png"
  - "rcg_new_exercise.png"
  - "rcg_workouts.png"
  - "rcg_app_mac.png"
---

Rock Climbers Guide (RCG) is a want-to-be all-in-one climbers bible. Features include logging training sessions (climbs, workouts), calories, and injuries.

## Features

* **Storage** — on-device only for now, with plans for a cross-platform API version.
* **Training sessions** — log climbs across bouldering, trad, lead, and top rope with grade and perceived difficulty.
* **Calories** — set weight goals, track intake and burn, monitor long-term trends.
* **Injuries** — track range of motion and discomfort over time to understand recovery.

### Future Features

* Finish API using a Rust headless server for cross-platform premium access.
* AI coach using LLAMA3 70B to analyze training data and infer injury-prevention strategies.

```rust
pub struct Climb {
    pub id: String,
    pub climb_type: ClimbType,
    pub hold_types: Vec<HoldTypes>,
    pub technique: ClimbTechnique,
    pub perceived_difficulty: i32,
    pub is_ascent: i32,
    pub msse: String,
}

pub enum ClimbTechnique {
    #[default]
    General, Vert, OverHanging, Slab,
}
```
