---
title: "Better Fantasy System"
description: "A highly customizable table top simulator for players and GMs"
order: 6
draft: false
icon: "dagger.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
  - "macos"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "Rust"
    url: "https://www.rust-lang.org/"
  - name: "Rust API"
  - name: "Postgres"
  - name: "Actix"
  - name: "SQL"
  - name: "Diesel ORM"
  - name: "oLLAMA"
gallery:
  - "bfs_player.png"
  - "bfs_items.png"
  - "bfs_item_page.png"
  - "bfs_notes_page.png"
---

## BFS Idea

I run a DND campaign and wanted to create a crafting system similar to [Path of Exile (POE)](https://www.pathofexile.com/) — consumable currencies that augment items. I applied this to DND crafts like +1 dex, str, int, wis, along with a broader set of abilities.

A DM creates a campaign and assigns users. Users create characters, add/remove items, and spend currencies on those items. Based on a weighted system and item tier, specific crafting outcomes are generated.

## Tech Stack

Front end in Flutter (macOS, web, mobile). Backend in Rust using Actix, Diesel, and Postgres. Rust's type and enum system handles complex weapon interactions, and Actix hosts both the Flutter web app and markdown files.

## Future Features

* **Dedicated Server** — rebuilding the API for easier end-user setup.
* **Markdown Editor** — shared campaign notes between users and the DM.
* **Map Builder** — interactive maps with a long-term goal of a combat tracker.
