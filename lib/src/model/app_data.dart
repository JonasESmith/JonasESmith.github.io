import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data.freezed.dart';
part 'app_data.g.dart';


@freezed
class AppData with _$AppData {
    const factory AppData({
        
        ///where did our user leave off last time?
        required bool isAboutMeOpen,
        required bool isSearchOpen,
        String? lastUrl,
        
        ///0.05 -> 0.5
        required double mouseFollowerOpacity,
        required int navIndex,
        required int navWidth,
        required Profile profile,
        required List<Project> projects,
        required bool showMouseFollower,
        required List<Skill> skills,
        required bool themeIsCollapsed,
        required List<String> urls,
        List<String>? visited,
        required List<WorkExperience> work,
    }) = _AppData;

    factory AppData.fromJson(Map<String, dynamic> json) => _$AppDataFromJson(json);
}

@freezed
class Profile with _$Profile {
    const factory Profile({
        required int birthDate,
        required String description,
        required String email,
        required String imagePath,
        required List<String> links,
        required String name,
        required String phoneNumber,
    }) = _Profile;

    factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

@freezed
class Project with _$Project {
    const factory Project({
        required List<int> color,
        required CompletionType completionType,
        
        ///our content in the form of markdown
        required String content,
        required String description,
        required int endMsse,
        required String iconAssetPath,
        List<ImageUrl>? imgUrls,
        required List<String> lessons,
        List<PlatForms>? platforms,
        required int startMsse,
        required List<Technology> technologies,
        required String title,
        String? url,
    }) = _Project;

    factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}

enum CompletionType {
    ACTIVE,
    INNACTIVE
}

final completionTypeValues = EnumValues({
    "Active": CompletionType.ACTIVE,
    "Innactive": CompletionType.INNACTIVE
});

@freezed
class ImageUrl with _$ImageUrl {
    const factory ImageUrl({
        required String thumbNail,
        required String url,
    }) = _ImageUrl;

    factory ImageUrl.fromJson(Map<String, dynamic> json) => _$ImageUrlFromJson(json);
}

@freezed
class PlatForms with _$PlatForms {
    const factory PlatForms({
        IOs? iOs,
        Web? web,
        IPad? iPad,
        MacOs? macOs,
        Linux? linux,
        Watch? watch,
        Windows? windows,
        Android? android,
    }) = _PlatForms;

    factory PlatForms.fromJson(Map<String, dynamic> json) => _$PlatFormsFromJson(json);
}

@freezed
class Android with _$Android {
    const factory Android({
        String? url,
    }) = _Android;

    factory Android.fromJson(Map<String, dynamic> json) => _$AndroidFromJson(json);
}

@freezed
class IOs with _$IOs {
    const factory IOs({
        String? url,
    }) = _IOs;

    factory IOs.fromJson(Map<String, dynamic> json) => _$IOsFromJson(json);
}

@freezed
class IPad with _$IPad {
    const factory IPad({
        String? url,
    }) = _IPad;

    factory IPad.fromJson(Map<String, dynamic> json) => _$IPadFromJson(json);
}

@freezed
class Linux with _$Linux {
    const factory Linux({
        String? url,
    }) = _Linux;

    factory Linux.fromJson(Map<String, dynamic> json) => _$LinuxFromJson(json);
}

@freezed
class MacOs with _$MacOs {
    const factory MacOs({
        String? url,
    }) = _MacOs;

    factory MacOs.fromJson(Map<String, dynamic> json) => _$MacOsFromJson(json);
}

@freezed
class Watch with _$Watch {
    const factory Watch({
        String? url,
    }) = _Watch;

    factory Watch.fromJson(Map<String, dynamic> json) => _$WatchFromJson(json);
}

@freezed
class Web with _$Web {
    const factory Web({
        String? url,
    }) = _Web;

    factory Web.fromJson(Map<String, dynamic> json) => _$WebFromJson(json);
}

@freezed
class Windows with _$Windows {
    const factory Windows({
        String? url,
    }) = _Windows;

    factory Windows.fromJson(Map<String, dynamic> json) => _$WindowsFromJson(json);
}

@freezed
class Technology with _$Technology {
    const factory Technology({
        required String label,
        String? url,
    }) = _Technology;

    factory Technology.fromJson(Map<String, dynamic> json) => _$TechnologyFromJson(json);
}

@freezed
class Skill with _$Skill {
    const factory Skill({
        required String content,
        String? endMsse,
        required Experience experience,
        required String name,
        
        ///this will link directly to our project that uses this skill!
        List<String>? projectIds,
        List<Skill>? skills,
        String? startMsse,
        List<String>? tags,
        String? url,
    }) = _Skill;

    factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

enum Experience {
    EXPERIENCED,
    LEARNING,
    PROFESSIONAL
}

final experienceValues = EnumValues({
    "Experienced": Experience.EXPERIENCED,
    "Learning": Experience.LEARNING,
    "Professional": Experience.PROFESSIONAL
});

@freezed
class WorkExperience with _$WorkExperience {
    const factory WorkExperience({
        required String companyName,
        required String content,
        required int endMsse,
        required String iconAssetPath,
        required List<String> lessons,
        required int startMsse,
        required List<String> technologies,
        required String title,
        String? url,
    }) = _WorkExperience;

    factory WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
