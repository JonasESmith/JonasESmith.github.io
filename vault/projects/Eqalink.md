---
title: "Eqalink"
description: "Security First Social Media Platform"
order: 1
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
  - name: "Rust"
    url: "https://www.rust-lang.org/"
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

Eqalink is a social media startup that prioritizes user control and security from the ground up. Its main goal is to reduce the overall impact of social media on your daily life. Instead of encouraging endless scrolling, Eqalink focuses on connecting you with local groups most relevant to your interests and needs.

# Metrics

* Built with client from basic drawings, iterated over many designs.
* Uses LLAMA3 to create customized descriptions and summaries of groups, posts, and users.
* No advertisement system — uses a monetization model for premium groups with user-set subscription prices.
* Designed and deployed for Android, iOS, iPad, MacOS, and Web.
* Built the app from 0 to 500 users.

### Development

* Used [flutter_modular](https://github.com/Flutterando/modular) for dependency injection and clean routing.
* [Firebase](https://firebase.google.com/docs/firestore/quotas) backend for rapid MVP scaling.
* Integrated Stripe, App Pay, and Android Pay for premium subscriptions.
* AI summaries via an oLLAMA instance of LLAMA3 analyzing posts, users, and groups for appropriateness.

#### Key Packages

* bloc / hydrated_bloc / flutter_bloc
* flutter_modular
* freezed
* flutter_adaptive_scaffold
