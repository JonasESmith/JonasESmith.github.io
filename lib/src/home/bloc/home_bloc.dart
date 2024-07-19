import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/projects/projects.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.uninitialized()) {
    on<_Reset>(_reset);
    on<_Started>(_started);
    on<_UpdateModel>(_updateModel);
  }

  void _updateModel(
    _UpdateModel event,
    Emitter<HomeState> emit,
  ) {
    emit(
      HomeState.loaded(
        data: event.data,
      ),
    );
  }

  void _reset(
    _Reset event,
    Emitter<HomeState> emit,
  ) {
    add(const HomeEvent.started(reset: true));
  }

  void _started(
    _Started event,
    Emitter<HomeState> emit,
  ) {
    if (Modular.to.path == "/") {
      ProjectsPage.route();
    }

    var model = state.whenOrNull(
          loaded: (AppData model) => model,
        ) ??
        initAppState();

    if (event.reset != null && event.reset == true) {
      model = initAppState();
    }

    return emit(
      HomeState.loaded(
        data: model,
      ),
    );
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    final data = AppData.fromJson(json['data'] as Map<String, dynamic>);
    return HomeState.loaded(data: data);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.maybeWhen(
      loaded: (data) => {'data': data.toJson()},
      orElse: () => null,
    );
  }

  AppData initAppState() {
    log("WE ARE INSTANITLIZING OUR THING");

    var path = "assets";

    if (!kDebugMode) {
      path = "projects/assets/images";
    }

    return AppData(
      isAboutMeOpen: false,
      isSearchOpen: false,
      visited: [],
      themeIsCollapsed: false,
      showMouseFollower: true,
      mouseFollowerOpacity: 0.12,
      skills: [
        Skill(
          startMsse: DateTime(2018, 2).millisecondsSinceEpoch.toString(),
          url: "$path/images/flutter_logo.png",
          name: "Flutter",
          content: """
Flutter is an amazing front-end framework that now supports pretty much all platforms. It allows for development across a wide range of devices: mobile (iOS and Android), desktop (Linux, Windows, and macOS), wearables (Apple Watch and other smart watches), and even embedded systems. This versatility has empowered me to create responsive and adaptable applications ( Examples :  [This website!](/project/portfolio), [RCG](rock-climber-guide), [Better Fantasy System](/project/better-fantasy-system), [Eqalink](/project/eqalink) , essentially turning me into four developers in one.


Working with Dart and Flutter has been a pleasure, especially when it comes to designing systems. The framework's flexibility and power have opened up new possibilities in my development journey, enabling me to tackle projects that span multiple platforms with ease and efficiency. It's truly remarkable how Flutter has streamlined the process of creating cross-platform applications, making it possible to reach a broader audience with a single codebase.
""",
          experience: Experience.EXPERIENCED,
          skills: const [
            Skill(
              name: "Bloc",
              content: "State management",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Flutter_modular",
              content: "di/dp, navigation, modular file structure",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Firebase",
              content: "amazing systems for deployment, data, and automation",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Freezed",
              content: "code generation",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "build_runner",
              content: "code generation",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "sqflite",
              content: "a local storage system using sqlite3",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "sql",
              content: "quering data",
              experience: Experience.EXPERIENCED,
            ),
          ],
        ),
        Skill(
          name: "Rust",
          url: "$path/rust.png",
          startMsse: DateTime(2023, 5).millisecondsSinceEpoch.toString(),
          content: """
Rust has made me feel much more powerful as a developer. It has allowed me to take complex ideas and develop them into reality with relative ease. My best example of this is my [Better Fantasy System](/project/better-fantasy-system).

This project started as a simple console application that allowed me to enter commands and create new items, users, and a basic management system for them. However, I soon wanted to add a system for crafting. So, I created structs with complex interactions between different types of items—swords, staves, bows, flasks, and more. I was very happy with this progress, but I craved something more.

I decided that I wanted a UI for this system, so I began to write a simple interface to interact with the database using Flutter. But my ambition didn't stop there. I learned how to host my Rust application as a headless server and created an API so that my player clients could access it as well.

All of this stemmed from a simple idea of a custom crafting system. Because of how robust Rust is, I now have a full-fledged, full-stack app for tracking my players' items, maps, and more. It's amazing to see how a small idea can grow into something so comprehensive and functional.
""",
          experience: Experience.EXPERIENCED,
          skills: const [
            Skill(
              name: "ActixWeb",
              content: "Server development package, allowing for api, web hosting, etc.",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Clap",
              content: "Amazing utils for developing terminal applications",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Tokio",
              content: "Async Programming",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Serde",
              content: "<3",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Diesel",
              content: "Data ORM",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Postgres",
              content: "Database",
              experience: Experience.EXPERIENCED,
            ),
          ],
        ),
        Skill(
          startMsse: DateTime(2017, 1).millisecondsSinceEpoch.toString(),
          name: "UI/UX Design",
          url: "$path/design.png",
          content: """
I have always enjoyed creating software that is intuitive, beautiful, and empowering for its users. My journey in software development began with Javascript, HTML, and CSS. From there, I expanded my skills to include C#, Flutter, and various other frameworks and technologies. My most recent exploration has been with Rust.

Throughout my career, I've built applications using a wide array of tools: Flutter, React, CSS, HTML, Python, C#, Windows Forms, and even BASIC. I've also dabbled in React Native. This diverse experience has given me a broad perspective on software development.

Ultimately, I've found myself moving towards Flutter. It feels the most empowering and allows me to develop both MVPs and production-ready code with the greatest confidence. Flutter's versatility and efficiency have made it my go-to framework for bringing ideas to life quickly and effectively.
""",
          experience: Experience.EXPERIENCED,
        ),
        Skill(
          name: "Python",
          startMsse: DateTime(2018, 5).millisecondsSinceEpoch.toString(),
          url: "$path/python.png",
          content: """
Python is such a fun language, it allows for quick iteration, and is often my starting point for getting an mvp off of the gorund before I move into a more efficient language. Python is often where I start or where I go for more experimental projects, however in production I have used this often for automation scripts, reporting, fraud detection, and web scraping with [pakmo](/project/pakmo). 
""",
          experience: Experience.EXPERIENCED,
          skills: const [
            Skill(
              name: "Pandas",
              content: "Server development package, allowing for api, web hosting, etc.",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "numpy",
              content: "Amazing utils for developing terminal applications",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "requests",
              content: "Async Programming",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "flask",
              content: "<3",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "plotly",
              content: "Data ORM",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "beautifulSoup",
              content: "Database",
              experience: Experience.EXPERIENCED,
            ),
          ],
        ),
        Skill(
          startMsse: DateTime(2014, 1).millisecondsSinceEpoch.toString(),
          endMsse: DateTime(2019, 1).millisecondsSinceEpoch.toString(),
          name: ".Net",
          url: "$path/net.png",
          content:
              "Worked with C# building out applicaitons for things as simple as mileage calculation forms, to building out personal assitances applications that use voice to text, Research Projects like Nurikabe, and navigating the users applicaitons.",
          experience: Experience.EXPERIENCED,
          skills: const [
            Skill(
              name: "OOP",
              content: "State management",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "UI Design",
              content: "di/dp, navigation, modular file structure",
              experience: Experience.EXPERIENCED,
            ),
            Skill(
              name: "Algorithms",
              content:
                  "Developed highly efficient algorithms to do branch searchs of possible games of a japanese game called Nurikabe for a research assistance role",
              experience: Experience.EXPERIENCED,
            ),
          ],
        ),
        Skill(
          startMsse: DateTime(2012, 1).millisecondsSinceEpoch.toString(),
          name: "Pencil Drawing",
          url: "$path/pencil.png",
          content:
              "I have been drawing since I was a kid, but as an adult it helps me visualize projects, and gives me an amazing creative outlet. I love drawing portraits, and have gotten into curvi-linear perspective drawings. This is often where my beginning ideas start, simple sketchs on paper, and I will refine from there going into more and more detail until I move into software, or into reality with my wood working!",
          experience: Experience.EXPERIENCED,
        ),
        Skill(
          startMsse: DateTime(2020, 1).millisecondsSinceEpoch.toString(),
          name: "Wood Working",
          url: "$path/chisel.png",
          content:
              "Started making rock climbing holds for my climbing wall at home, and from this simple start begin creating furniture, and from here began making cabnentry, and many other wood working style skills.",
          experience: Experience.EXPERIENCED,
        ),
      ],
      profile: Profile(
        birthDate: DateTime(1995, 12, 03).millisecondsSinceEpoch,
        description: """
Hi there, I'm Jonas!

I'm passionate about building useful tools and fun side projects. With several years of experience in startups and small businesses, I've shipped applications across various platforms including desktop, web, mobile, and even smart watches. My expertise lies in creating reusable and easy-to-maintain code using languages such as Dart, Rust, Python, C#, and the associated packages with these. 

Over the past 6 years, I've successfully completed numerous projects, ranging from [Eqalink](/project/eqalink) to [Rock Climbers Guide](/project/rock-climber-guide). I'm particularly proud of [Eqalink](/project/eqalink), which I took from an idea with a client to a full fledge social media platform. 

My main passions in life are:

1. Connecting with people on a deep level: I enjoy really connecting and trying to see who people are. 
2. Building things I care about: Whether it's developing a solution to a common problem ( [Eqalink](/project/eqalink), [Pakmo](/project/pakmo), [RCG](/project/rock-climbers-guide) ) or creating something just for fun ( [better-fantasy-system](/project/eqalink ), I find great satisfaction in bringing ideas to life through code.
3. Enjoying the outdoors: I'm an avid rock climber and hiker. When I'm not coding, you'll often find me exploring new trails or challenging myself on a climbing route.

I'm always eager to learn new technologies and take on exciting challenges that push my skills to the next level.
""",
        name: "Jonas E. Smith",
        email: "pictofoster@gmail.com",
        imagePath: "$path/profile.jpeg",
        links: [
          "https://github.com/JonasESmith",
          "https://www.instagram.com/jonas.e.smith/",
          "https://www.linkedin.com/in/jonas-smith-006716176/",
        ],
        phoneNumber: "1-417-437-1924",
      ),
      navIndex: 0,
      navWidth: 300,
      projects: [
        Project(
          color: [
            CupertinoColors.activeGreen.red,
            CupertinoColors.activeGreen.green,
            CupertinoColors.activeGreen.blue,
          ],
          url: "https://www.eqalink.com",
          imgUrls: [
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/01.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/02.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/03.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/04.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/05.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/06.png",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/07.jpeg",
            ),
            ImageUrl(
              thumbNail: "",
              url: "$path/eqalink/08.jpeg",
            ),
          ],
          completionType: CompletionType.ACTIVE,
          platforms: const [
            PlatForms(iOs: IOs()),
            PlatForms(android: Android()),
            PlatForms(web: Web()),
            PlatForms(iPad: IPad()),
          ],
          title: "Eqalink",
          content: """
Eqalink is a social media startup that prioritizes user control and security from the ground up. Its main goal is to reduce the overall impact of social media on your daily life. Instead of encouraging endless scrolling, Eqalink focuses on connecting you with local groups that are most relevant to your interests and needs. The platform emphasizes meaningful interactions within your community rather than promoting excessive screen time.

#  Metrics

* Social Media Startup, built with client from basic drawings, and iterated over many different designs. 
* Use a LLAMA3 to create customized descriptions and summaries of groups, posts, and users.
* Eqalink is built off the idea to not sell user data, so we moved forwards with a no advertisement system, instead we use a monetization model so that users can create premium groups, that they can set the price to and users can subscribe to these groups. for mobile we use the [in_app_purchases](https://github.com/flutter/packages/tree/main/packages/in_app_purchase/in_app_purchase) and for web we use [stripe]().
* Designed and deployed for Android, iOS, iPad, MacOS, and Web
* Built the app from 0 to 500 users. 
* Built out for iOS, iPadOS, Android, And Web. 
* Front end and Backend tests automated with `./build.sh` 
	* why note use github actions?
		* For clients needs it was better to test and deploy using local systems

### Development

* Build with mobile/web in mind so clean navigation and efficient load times were necessary. I used [flutter_modular](https://github.com/Flutterando/modular), to better deal with large scalable structures this enabled dependency injection, and clean routing structures. 
* The client decided on using [Firebase](https://firebase.google.com/docs/firestore/quotas) for a faster ability to scale quickly and get MVP up and running.
* User created Content
	* Designed User Interfaces, Integrated Firebase Backend, and built Eqalink from a few napkin drawings starting point.
	* Create user experience to create groups, posts, events, and child users.
	* Create premium content for private groups that can be access through a subscription.
	* Integrated Stripe, and App/Android pay. 
* AI Summary
	* The ai summary is built upon an oLLAMA instance of the LLAMA3 model, we pass in all pertinent information in regards to posts, users, and groups, and will generate a summary of the appropriateness of said data. We look at things like the assumed gender, political leanings, and age rating. 

#### Key Development Packages

> We use many different leading packages so that we can increase the speed of development and allow for a more modular and scalable application.

* bloc
* hydrated_bloc
* flutter_bloc
* flutter_modular
* freezed
* provider
### UI/UX Design

> Weather we like it or not the better an app feels the better it is to use

* I designed all UI/UX with input from the client. 
* Worked with Psychologists to remove unwanted "dopamine" hits.
	* by integrating features to reduce the number of unneeded notifications, 
	* Limiting the number of "pop-ups" and indicators to reduce stress
	* Using more neutral colors
* Built with mobile and web from the start, to create an adaptive UI that will work across all platforms with a very limited number of customized code. 

#### Key Design Packages
 
 [flutter_adaptive_scaffold](https://github.com/flutter/packages/tree/main/packages/flutter_adaptive_scaffold) was a key package used to help build out our widgets in a manner that will allow for reusable code and making sure that we can build once and deploy across all platforms (mobile small and large, desktop, etc).



""",
          endMsse: -1,
          lessons: [],
          description: "Secuirty First Social Media Platform",
          iconAssetPath: "$path/eqalink_logo.png",
          startMsse: DateTime(
            2023,
            6,
          ).millisecondsSinceEpoch,
          technologies: [
            const Technology(label: "Flutter", url: "https://flutter.dev/"),
            const Technology(label: "Rust", url: "https://www.rust-lang.org/"),
            const Technology(label: "Bloc", url: "https://pub.dev/packages/bloc"),
            const Technology(label: "Firebase", url: "https://firebase.google.com/"),
            const Technology(label: "Freezed", url: "https://pub.dev/packages/freezed"),
            const Technology(label: "FlutterModular", url: "https://pub.dev/packages/flutter_modular"),
            const Technology(label: "oLLAMA"),
          ],
        ),
        Project(
          color: [
            CupertinoColors.activeGreen.red,
            CupertinoColors.activeGreen.green,
            CupertinoColors.activeGreen.blue,
          ],
          completionType: CompletionType.ACTIVE,
          platforms: const [
            PlatForms(iOs: IOs()),
            PlatForms(android: Android()),
            PlatForms(web: Web()),
            PlatForms(macOs: MacOs()),
          ],
          title: "Portfolio",
          content: """
I wanted to create a simple, yet beautiful adaptive site to show the many things I like to work on, this uses rust to build the app data, and general object construction as I like the feel of rust structs much better, so I created a simple rust project at the root of the 

> Why use rust? 

I have found rust to be a complete game changer to my productivity and ability to write error free code, using packages like [flutter_rust_bridge](https://cjycode.com/flutter_rust_bridge/) and some custom bash scripts I can make generating models much faster bellow is an example workflow for my model generation.


``` rust 
/// basic appData outline
#[derive(Deserialize, Serialize, JsonSchema)]
pub struct AppData {
	     pub nav_width: i32,
	     pub nav_index: i32,
	     pub profile: Profile,
	     pub urls: Vec<String>,
	     pub skills: Vec<Skill>,
	     pub projects: Vec<Project>,
	     pub work: Vec<WorkExperience>,
}
```

``` rust
/// main.rs file, takes our appData, and will build our dart models using freezed
fn main() {
	     /// using quicktype wrapper to generate rust -> dart
	     let mut codegen = CodegenContext::new(Some(&["-l", "dart", "--use-freezed"]));
	     codegen.add_type::<AppData>();
	
	     let output = codegen.finish(Language::Dart);
	     /// output saved to the app_data.dart file...
	     /// build runner built here
}
```

now I just need to run `dart run build_runner` to generate our dart models! This makes sure our "backend" is isync with the front end, and we can much more easily communicate between the two. 

```bash 
# a simplified version of the bash script.
#!/bin/bash

cd portfolio_data

cd ..

echo "Build completed successfully!"
```

once this is built and run we are up to date!
""",
          endMsse: -1,
          url: "www.jonasesmith.com",
          lessons: [],
          description: "A looking glass into my projects, work, and love for building",
          iconAssetPath: "$path/dagger.png",
          startMsse: DateTime(
            2023,
            6,
          ).millisecondsSinceEpoch,
          technologies: [
            const Technology(label: "Flutter", url: "https://flutter.dev/"),
            const Technology(label: "React"),
            const Technology(label: "Rust", url: "https://www.rust-lang.org/"),
            const Technology(label: "Rust API"),
            const Technology(label: "Bloc", url: "https://pub.dev/packages/bloc"),
            const Technology(label: "Firebase", url: "https://firebase.google.com/"),
            const Technology(label: "Freezed", url: "https://pub.dev/packages/freezed"),
            const Technology(label: "FlutterModular", url: "https://pub.dev/packages/flutter_modular"),
          ],
        ),
        Project(
          color: [
            CupertinoColors.black.red,
            CupertinoColors.black.green,
            CupertinoColors.black.blue,
          ],
          platforms: const [
            PlatForms(iOs: IOs()),
            PlatForms(android: Android()),
            PlatForms(web: Web()),
          ],
          completionType: CompletionType.ACTIVE,
          title: "Rock Climber Guide",
          content: """
Rock Climbers Guide ( RCG ) is a want to be all in one climbers bible, or I want it to be this! For the time being while in development I am creating systems that I can use to monitor my training sessions, things like workouts, and climbs, a climb can be defined by many different key metrics so i used rusts beautiful struct and enum system to build this out there is an example bellow. 

## Features

* Storage
	* right now this is an on device storage system, we take all our data and don't send it our export any data to a server, but have plans to make a version that can be sent to our api for cross platform usage.
* Log training sessions
	* Log the number of climbs, rest, intensity and grade of many different types of climbs, bouldering, trad, lead, and top rope. 
	* Log workouts, the number of reps, weight added and perceived difficulties.
* Log Calories
	* Set goals for weight gain and loss.
	* track the total calories eaten and burned throw out the day.
	* Monitor long term trends for what works and what doesn't
* Log Injuries
	* Sadly climbing is a sport where injuries occur, they can be a big set back, but they aren't the end of the road, tracking your progress, range of motion, and general discomfort better tells the story of how you can heal yourself and make gains towards your goals. 
* Profile Page
	* The profile page is just basic information about the users stats, height, weight, ape index (height - wingspan).


### Future Features

* Finish API
	* Finish all endpoints for the application using a rust headless server, to allow users to navigate their data across the web, mobile, and desktop apps. As a premium feature.
	* AI coach, implement a system to use a open LLM, (LLAMA3 70B) to look at all user data and infer trends and strategies for training protocols. 
		* My mindset here is if I had an a2 pulley injury on my right middle finger, was the training sessions two weeks before this a call to action that I was over training? or was this inevitable? Well if we process our users data and can give them insights maybe we can reduce the potential stresses to them and reduce the total load, for the upcoming weeks so that injuries as much less frequent. 


## DEV

> WHY RUST?

Rust is sweet, it makes easy things somewhat hard, but hard things easy. Bellow is an example of how we use rust, and a converter system to build out dart objects in the app

``` rust 
#[derive(
Default, //
Debug,
Clone,
Serialize,
Deserialize,
PartialEq,
JsonSchema,
)]

pub struct Climb {
			pub id: String,
			/// the climb type is the general type we can infer, so
			/// like top rope, lead, etc.
			pub climb_type: ClimbType,
			/// we can have many different types of climbing holds, so lets
			/// generally allow all hold types :)
			pub hold_types: Vec<HoldTypes>,
			pub technique: ClimbTechnique,
			/// how hard was this thing? some days feel harder than others.
			pub perceived_difficulty: i32,
			pub is_ascent: i32,
			pub msse: String,
}

#[derive(
Default, //
Debug,
Clone,
Serialize,
Deserialize,
PartialEq,
JsonSchema,
)]

pub enum ClimbTechnique {
			#[default]
			General,
			Vert,
			OverHanging,
			Slab,
}

```

""",
          endMsse: -1,
          lessons: [],
          imgUrls: [
            ImageUrl(thumbNail: "", url: "$path/rcg/sessions_running_light.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/sessions_page.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/session_running.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/log_climb.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/repeater_setup.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/tabata_running.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/records_page.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/new_exercise.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/workouts.png"),
            ImageUrl(thumbNail: "", url: "$path/rcg/app_mac.png"),
          ],
          description: "Climbers bible",
          iconAssetPath: "$path/rcg.png",
          startMsse: DateTime(
            2023,
            6,
          ).millisecondsSinceEpoch,
          technologies: [
            const Technology(label: "Flutter", url: "https://flutter.dev/"),
            const Technology(label: "Rust", url: "https://www.rust-lang.org/"),
            const Technology(label: "Rust API"),
            const Technology(label: "Bloc", url: "https://pub.dev/packages/bloc"),
            const Technology(label: "FlutterModular", url: "https://pub.dev/packages/flutter_modular"),
          ],
        ),
        Project(
          color: [
            CupertinoColors.activeGreen.red,
            CupertinoColors.activeGreen.green,
            CupertinoColors.activeGreen.blue,
          ],
          completionType: CompletionType.ACTIVE,
          platforms: const [
            PlatForms(iOs: IOs()),
            PlatForms(android: Android()),
            PlatForms(web: Web()),
            PlatForms(macOs: MacOs()),
          ],
          title: "Better Fantasy System",
          content: """
## BFS idea

I run a DND campaign and wanted to create a simple crafting system for my players similar to that of [path of exile (POE)](https://www.pathofexile.com/). POE is built upon a system that uses consumable currencies that can be expended to augment an item, I took this basic idea and applied it to the crafting for dnd crafts, like +1 dex, str, int, wis, etc. As well as a pretty extensive set of abilities and fun augmentations. 

A DM can create a campaign and assign users to it, once a user is assigned they can create characters, and from their have access to add and remove items, these items then can have currencies that are expendable upon on the items, that will go through and based on a weighted system, along with the item tier can have specific crafting outcomes. Similar to how in DND a player can have a +1 sword that will increase the damage of a weapon, we can have specific crafts that can increase the damage dice by a specific type of damage for a set amount of times per short rest. This definitely has the opportunity to make players extremely strong!


## Tech Stack

the front end for the application is written in flutter and targets macOS, web, and in the future mobile, I wanted to use flutter because it is mature and allows me to build widgets once, and "easily" deploy them for all platforms. 

The backend is written in rust, using Actix, diesel, and postgres, as well as a litany of other very useful packages. Rusts type and enum system allows me to build complex interactions between the different types of weapons, and allows for a great range of customization for players and DM's. Using Actix we are also very easily able to host our flutter web site, and on top of that we can host the markdown files that are hosted inside of this folder. 



## Future Features

* Dedicated Server
	* I am re-building the api so that the service can be more easily used by end users. 
	* as of now for this to work many hoops need to be jumped through. 
* Markdown Editor
	* A simple markdown editor for any user to quickly and easily add notes to their campaign and share them between users or to the DM.
* Map builder
	* Build out maps in a highly customizable manner. Allowing for an interactive map for the players and Dm's. 
	* Long term goal here is a combat tracker. 
""",
          endMsse: -1,
          lessons: [],
          description: "A highly customizable table top simulator for players and GMs",
          iconAssetPath: "$path/dagger.png",
          startMsse: DateTime(
            2023,
            6,
          ).millisecondsSinceEpoch,
          imgUrls: [
            ImageUrl(
              thumbNail: "",
              url: '$path/bfs/bfs_player.png',
            ),
            ImageUrl(
              thumbNail: "",
              url: '$path/bfs/bfs_items.png',
            ),
            ImageUrl(
              thumbNail: "",
              url: '$path/bfs/bfs_item_page.png',
            ),
            ImageUrl(
              thumbNail: "",
              url: '$path/bfs/bfs_notes_page.png',
            ),
          ],
          technologies: [
            const Technology(label: "Flutter", url: "https://flutter.dev/"),
            const Technology(label: "Rust", url: "https://www.rust-lang.org/"),
            const Technology(label: "Rust API"),
            const Technology(label: "Postgres"),
            const Technology(label: "Actix"),
            const Technology(label: "SQL"),
            const Technology(label: "Diesel ORM"),
            const Technology(label: "oLLAMA"),
          ],
        ),
        Project(
          color: [
            CupertinoColors.activeGreen.red,
            CupertinoColors.activeGreen.green,
            CupertinoColors.activeGreen.blue,
          ],
          url: "https://pakmo-e7476.web.app/",
          imgUrls: [
            ImageUrl(
              thumbNail: "",
              url: '$path/pakmo/01.jpeg',
            ),
            ImageUrl(
              thumbNail: "",
              url: '$path/pakmo/02.png',
            ),
          ],
          completionType: CompletionType.INNACTIVE,
          platforms: const [
            PlatForms(iOs: IOs()),
            PlatForms(android: Android()),
            PlatForms(web: Web()),
            PlatForms(macOs: MacOs()),
          ],
          title: "Pakmo",
          content: """
## Client Landing Page

[Pakmo.co](https://pakmo.co/) is a middle man shipping service that clients will ship their inventories to, and pakmo handles orders and shipments from clients customers. I built out the user landing page to allow new users to come through and get the necessary information and be introduced to a sales rep.

## Client Application

Built out the client application to track what inventory items needs to be sent to the pakmo warehouses for shipments, used integrations with Zenventory and Shipstation API's to get current inventory numbers for clients and keep them updated on current Inventory.

## Automation Scripts

Built out scripts to look through orders and client user information to find fraud detection, and flag orders for fraud.
""",
          endMsse: -1,
          lessons: [],
          description: "Shipment, order, customer tracker",
          iconAssetPath: "$path/box.png",
          startMsse: DateTime(
            2023,
            6,
          ).millisecondsSinceEpoch,
          technologies: [
            const Technology(label: "Flutter", url: "https://flutter.dev/"),
            const Technology(label: "React"),
            const Technology(label: "ShipStation"),
            const Technology(label: "Zenventory"),
            const Technology(label: "Bloc"),
            const Technology(label: "FlutterModular"),
            const Technology(label: "Python"),
            const Technology(label: "PHP"),
            const Technology(label: "SQL"),
          ],
        ),
      ],
      urls: [],
      work: [],
    );
  }
}
