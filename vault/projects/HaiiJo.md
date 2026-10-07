---
title: "HaiiJo"
description: "A climbing app built for analytic and obsessed climbers"
subtitle: "Rock climbing app"
order: 5
draft: false
icon: "rcg.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "macos"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "Rust"
    url: "https://www.rust-lang.org/"
  - name: "Axum"
    url: "https://github.com/tokio-rs/axum"
  - name: "Bloc"
    url: "https://pub.dev/packages/bloc"
  - name: "FlutterModular"
    url: "https://pub.dev/packages/flutter_modular"
  - name: "fl_chart"
    url: "https://pub.dev/packages/fl_chart"
  - name: "SQLite"
    url: "https://pub.dev/packages/sqflite"
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

HaiiJo is a climbing app built for analytic and obsessed climbers. It started life as Rock Climbers Guide (RCG): an all-in-one climbing notebook that records every session, times every hangboard set, and turns it all into numbers you can actually train with.

> [!NOTE] The name
> HaiiJo is a mix of my partner's name and my own.

## Download

HaiiJo is available on the [App Store](https://apps.apple.com/app/id6544806250).

## How it works

### Set up in a minute

The first launch asks for the basics that matter to climbers: height, ape index, weight, age, years climbing, units and a light or dark theme. It comes preloaded with 21 exercises, from max pull-ups to 20 mm half-crimp repeaters, so there's something to train on straight away. A short tutorial walks through the app and can be skipped.

### Record a session as you climb

Start a session, choose indoor or outdoor, and log climbs as you go:

- **Type:** boulder, sport, lead or trad.
- **Grade,** in whichever system you climb: Font (3–9c+), V-scale (VB–V18) or YDS (5.4–5.16a).
- **Sent or attempt,** and how many times.
- **The details:** perceived difficulty, hold types (crimps, jugs, pinches, slopers) and wall angle (vertical, overhanging, slab).

While you climb, a rest timer runs between attempts and live stats show your total, success rate and average rest, with a chart of your grades across the session. Undo and redo cover the inevitable mis-tap. When you're done, rate how hard the session felt (RPE) and it's saved. Forgot to record? Add a past session afterwards.

### Train with built-in timers

Exercises use one of four timers:

| Timer | Built for | You set |
|---|---|---|
| **Tabata** | Repeaters, intervals | Prepare, work, reps, rest between reps, sets, rest between sets |
| **Workout** | Classic sets and reps | Prepare, reps, sets, rest between sets |
| **Max** | Max hangs, max pull-ups | Duration, reps, added weight or body weight |
| **Climb** | Board and circuit sessions, e.g. 4×4s | Climb type, number of climbs, grade range, rest |

The runner counts you in with a start sound, and you can pause, skip or adjust reps and sets on the fly. After each set, log the added weight, your body weight, RPE and notes. Exercises can be grouped into workouts and run back to back.

### See your progress

- **Sessions,** as a list or a calendar, grouped by day or week, with weekly totals: sessions, climbs, average grade, success rate, time, calories and training load.
- **Records:** highest grade, total sessions and climbing age, an activity heatmap, and a **grade pyramid** you can filter by sends or attempts over a week, month, year or all time.
- **Exercise records,** charting reps and weight over time for every exercise.
- **Body weight,** logged in kg or lbs. Calories are estimated from your weight, session time and climbs.

### Your data stays yours

Everything lives on your device. There's no account and no tracking. Export everything as JSON to keep a backup or move phones, and paste it back to import. Deleted sessions go to a recovery bin, so one wrong swipe doesn't erase a day at the crag.

## What's next

- **Climbing Wrapped:** a monthly or yearly recap of sessions, hours, boulders and routes, ready to share.
- **Injury tracking:** range of motion and discomfort over time, to understand recovery.
- **Training plans:** multi-week programs with strength, power, endurance and deload weeks, plus start and end assessments.
- **Climber in the loop:** an AI coach that reads your training data and suggests what to work on next, and how to avoid injury.
- **Sync:** an optional account backed by the HaiiJo API.

## Under the hood

The app is [[Flutter]] with BLoC and flutter_modular, storing data on the device in SQLite. Charts are drawn with fl_chart.

The backend, still in progress, is a [[Rust]] API built on Axum and Postgres, with Argon2 password hashing and JWT authentication. The Rust models are the single source of truth: the same crate generates the app's Dart models, so the app and the API can't drift apart.

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
