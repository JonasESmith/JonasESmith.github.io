// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppDataImpl _$$AppDataImplFromJson(Map<String, dynamic> json) =>
    _$AppDataImpl(
      isAboutMeOpen: json['isAboutMeOpen'] as bool,
      isSearchOpen: json['isSearchOpen'] as bool,
      lastUrl: json['lastUrl'] as String?,
      mouseFollowerOpacity: (json['mouseFollowerOpacity'] as num).toDouble(),
      navIndex: (json['navIndex'] as num).toInt(),
      navWidth: (json['navWidth'] as num).toInt(),
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      projects: (json['projects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      showMouseFollower: json['showMouseFollower'] as bool,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      themeIsCollapsed: json['themeIsCollapsed'] as bool,
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      visited:
          (json['visited'] as List<dynamic>?)?.map((e) => e as String).toList(),
      work: (json['work'] as List<dynamic>)
          .map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppDataImplToJson(_$AppDataImpl instance) =>
    <String, dynamic>{
      'isAboutMeOpen': instance.isAboutMeOpen,
      'isSearchOpen': instance.isSearchOpen,
      'lastUrl': instance.lastUrl,
      'mouseFollowerOpacity': instance.mouseFollowerOpacity,
      'navIndex': instance.navIndex,
      'navWidth': instance.navWidth,
      'profile': instance.profile,
      'projects': instance.projects,
      'showMouseFollower': instance.showMouseFollower,
      'skills': instance.skills,
      'themeIsCollapsed': instance.themeIsCollapsed,
      'urls': instance.urls,
      'visited': instance.visited,
      'work': instance.work,
    };

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      birthDate: (json['birthDate'] as num).toInt(),
      description: json['description'] as String,
      email: json['email'] as String,
      imagePath: json['imagePath'] as String,
      links: (json['links'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'description': instance.description,
      'email': instance.email,
      'imagePath': instance.imagePath,
      'links': instance.links,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
    };

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      color: (json['color'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      completionType:
          $enumDecode(_$CompletionTypeEnumMap, json['completionType']),
      content: json['content'] as String,
      description: json['description'] as String,
      endMsse: (json['endMsse'] as num).toInt(),
      iconAssetPath: json['iconAssetPath'] as String,
      imgUrls: (json['imgUrls'] as List<dynamic>?)
          ?.map((e) => ImageUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      lessons:
          (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => PlatForms.fromJson(e as Map<String, dynamic>))
          .toList(),
      startMsse: (json['startMsse'] as num).toInt(),
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => Technology.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'completionType': _$CompletionTypeEnumMap[instance.completionType]!,
      'content': instance.content,
      'description': instance.description,
      'endMsse': instance.endMsse,
      'iconAssetPath': instance.iconAssetPath,
      'imgUrls': instance.imgUrls,
      'lessons': instance.lessons,
      'platforms': instance.platforms,
      'startMsse': instance.startMsse,
      'technologies': instance.technologies,
      'title': instance.title,
      'url': instance.url,
    };

const _$CompletionTypeEnumMap = {
  CompletionType.ACTIVE: 'ACTIVE',
  CompletionType.INNACTIVE: 'INNACTIVE',
};

_$ImageUrlImpl _$$ImageUrlImplFromJson(Map<String, dynamic> json) =>
    _$ImageUrlImpl(
      thumbNail: json['thumbNail'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ImageUrlImplToJson(_$ImageUrlImpl instance) =>
    <String, dynamic>{
      'thumbNail': instance.thumbNail,
      'url': instance.url,
    };

_$PlatFormsImpl _$$PlatFormsImplFromJson(Map<String, dynamic> json) =>
    _$PlatFormsImpl(
      iOs: json['iOs'] == null
          ? null
          : IOs.fromJson(json['iOs'] as Map<String, dynamic>),
      web: json['web'] == null
          ? null
          : Web.fromJson(json['web'] as Map<String, dynamic>),
      iPad: json['iPad'] == null
          ? null
          : IPad.fromJson(json['iPad'] as Map<String, dynamic>),
      macOs: json['macOs'] == null
          ? null
          : MacOs.fromJson(json['macOs'] as Map<String, dynamic>),
      linux: json['linux'] == null
          ? null
          : Linux.fromJson(json['linux'] as Map<String, dynamic>),
      watch: json['watch'] == null
          ? null
          : Watch.fromJson(json['watch'] as Map<String, dynamic>),
      windows: json['windows'] == null
          ? null
          : Windows.fromJson(json['windows'] as Map<String, dynamic>),
      android: json['android'] == null
          ? null
          : Android.fromJson(json['android'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PlatFormsImplToJson(_$PlatFormsImpl instance) =>
    <String, dynamic>{
      'iOs': instance.iOs,
      'web': instance.web,
      'iPad': instance.iPad,
      'macOs': instance.macOs,
      'linux': instance.linux,
      'watch': instance.watch,
      'windows': instance.windows,
      'android': instance.android,
    };

_$AndroidImpl _$$AndroidImplFromJson(Map<String, dynamic> json) =>
    _$AndroidImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$AndroidImplToJson(_$AndroidImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$IOsImpl _$$IOsImplFromJson(Map<String, dynamic> json) => _$IOsImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$IOsImplToJson(_$IOsImpl instance) => <String, dynamic>{
      'url': instance.url,
    };

_$IPadImpl _$$IPadImplFromJson(Map<String, dynamic> json) => _$IPadImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$IPadImplToJson(_$IPadImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$LinuxImpl _$$LinuxImplFromJson(Map<String, dynamic> json) => _$LinuxImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$LinuxImplToJson(_$LinuxImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$MacOsImpl _$$MacOsImplFromJson(Map<String, dynamic> json) => _$MacOsImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$MacOsImplToJson(_$MacOsImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$WatchImpl _$$WatchImplFromJson(Map<String, dynamic> json) => _$WatchImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$WatchImplToJson(_$WatchImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$WebImpl _$$WebImplFromJson(Map<String, dynamic> json) => _$WebImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$WebImplToJson(_$WebImpl instance) => <String, dynamic>{
      'url': instance.url,
    };

_$WindowsImpl _$$WindowsImplFromJson(Map<String, dynamic> json) =>
    _$WindowsImpl(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$WindowsImplToJson(_$WindowsImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$TechnologyImpl _$$TechnologyImplFromJson(Map<String, dynamic> json) =>
    _$TechnologyImpl(
      label: json['label'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$TechnologyImplToJson(_$TechnologyImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
    };

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
      content: json['content'] as String,
      endMsse: json['endMsse'] as String?,
      experience: $enumDecode(_$ExperienceEnumMap, json['experience']),
      name: json['name'] as String,
      projectIds: (json['projectIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      startMsse: json['startMsse'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'endMsse': instance.endMsse,
      'experience': _$ExperienceEnumMap[instance.experience]!,
      'name': instance.name,
      'projectIds': instance.projectIds,
      'skills': instance.skills,
      'startMsse': instance.startMsse,
      'tags': instance.tags,
      'url': instance.url,
    };

const _$ExperienceEnumMap = {
  Experience.EXPERIENCED: 'EXPERIENCED',
  Experience.LEARNING: 'LEARNING',
  Experience.PROFESSIONAL: 'PROFESSIONAL',
};

_$WorkExperienceImpl _$$WorkExperienceImplFromJson(Map<String, dynamic> json) =>
    _$WorkExperienceImpl(
      companyName: json['companyName'] as String,
      content: json['content'] as String,
      endMsse: (json['endMsse'] as num).toInt(),
      iconAssetPath: json['iconAssetPath'] as String,
      lessons:
          (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
      startMsse: (json['startMsse'] as num).toInt(),
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$WorkExperienceImplToJson(
        _$WorkExperienceImpl instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'content': instance.content,
      'endMsse': instance.endMsse,
      'iconAssetPath': instance.iconAssetPath,
      'lessons': instance.lessons,
      'startMsse': instance.startMsse,
      'technologies': instance.technologies,
      'title': instance.title,
      'url': instance.url,
    };
