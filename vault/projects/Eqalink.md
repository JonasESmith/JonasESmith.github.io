---
title: "Eqalink"
description: "Security First Social Media Platform"
order: 3
draft: false
url: "https://www.eqalink.com"
icon: "eqalink_logo.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
  - "ipad"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "Bloc"
    url: "https://pub.dev/packages/bloc"
  - name: "Firebase"
    url: "https://firebase.google.com/"
  - name: "Freezed"
    url: "https://pub.dev/packages/freezed"
  - name: "FlutterModular"
    url: "https://pub.dev/packages/flutter_modular"
  - name: "oLLAMA"
gallery:
  - "eqalink_01.png"
  - "eqalink_02.png"
  - "eqalink_03.png"
  - "eqalink_04.png"
  - "eqalink_05.png"
  - "eqalink_06.png"
  - "eqalink_07.png"
  - "eqalink_08.png"
---

Eqalink is a social media startup that prioritizes user control and security from the ground up. Its main goal is to reduce the overall impact of social media on your daily life. Instead of an algorithm built to keep you scrolling, Eqalink focuses on connecting you with local groups most relevant to your interests and needs.

> [!NOTE] The mission
> Bringing the power of social media back to its users, for their control.

## Core principles

### Your groups, not an algorithm

There is no recommendation engine deciding what you see. The home feed only shows posts from groups you've joined, newest first. Nothing is ranked for engagement, and nothing is injected from accounts you don't follow.

### Small and local by design

Groups are meant to be communities, not audiences. A group holds 100 members by default, and groups and people carry a city and zip code, so it's easy to find the climbing gym, golf league or photography club down the street.

### You decide who sees what

- **Profiles** can be private, hiding you from search and member lists.
- **Groups** can be private, and owners choose exactly which parts are visible: posts, rules, media, events, members and the description, plus who is allowed to post.
- **Posts** have their own switches: allow comments, show comments, show view counts, or keep it as a draft.
- **Blocking** removes someone from your comments, member lists and search.

### Creators get paid, not advertisers

There are no ads. Instead, group owners can turn on paid subscriptions and set their own monthly price. Payments go through Stripe Connect straight to the owner, who keeps **80%** of every subscription. Owners can also sell individual content folders, paid for by card or in-app coins.

Price changes are consent-based. A new price only takes effect at the next billing date, members are notified, and anyone who doesn't agree is cancelled at the end of the period instead of being charged more.

### Moderation with private AI

Groups are reviewed by LLAMA 3 running through [Ollama](https://ollama.com) on our own hardware, so user content is never sent to a third-party AI service. The model reads a group's description and posts and returns a structured verdict:

```json
{
  "is_age_restrictive": false,
  "positivity_score": 92,
  "language_score": "pg"
}
```

Ratings use a familiar film-style scale (PG through X), so age-restricted groups can be gated behind age verification. Members can also flag any post; each report keeps a snapshot of the post and the reason, ready for review.

### Leaving is easy

Deleting your account really deletes it: your posts and their media, profile photo, events, connections, notifications, comments and conversations are removed. Groups you own are handed to another member instead of disappearing with you.

## How it's built

- **One codebase, five platforms.** [[Flutter]] with `flutter_adaptive_scaffold`, so the same app adapts its layout across Android, iOS, iPad, macOS and the web.
- **Feature modules.** [flutter_modular](https://github.com/Flutterando/modular) handles dependency injection and routing; each feature (feed, groups, profile, flagging…) is its own module with its own bloc, models and repository.
- **Predictable state.** BLoC throughout, with `hydrated_bloc` so the app resumes exactly where you left off. Models are immutable `freezed` classes.
- **A shared backend package.** All data access lives in one Dart package, used by the app, the admin tools and the AI manager alike.
- **[Firebase](https://firebase.google.com/docs/firestore/quotas) for rapid MVP scaling.** Firestore, Storage and Cloud Functions, which handle Stripe, Apple receipts, scheduled price-change checks and notifications.
- **[[Rust]] experiments.** Image compression through `flutter_rust_bridge`, and a small Firestore admin CLI.

## Metrics

- Built with client from basic drawings, iterated over many designs.
- Uses LLAMA3 to rate groups and their posts for language, positivity, and age-appropriateness.
- No advertisement system — uses a monetization model for premium groups with user-set subscription prices.
- Designed and deployed for Android, iOS, iPad, MacOS, and Web.
- Built the app from 0 to 500 users.
