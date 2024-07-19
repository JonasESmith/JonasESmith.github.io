// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppData _$AppDataFromJson(Map<String, dynamic> json) {
  return _AppData.fromJson(json);
}

/// @nodoc
mixin _$AppData {
  ///where did our user leave off last time?
  bool get isAboutMeOpen => throw _privateConstructorUsedError;
  bool get isSearchOpen => throw _privateConstructorUsedError;
  String? get lastUrl => throw _privateConstructorUsedError;

  ///0.05 -> 0.5
  double get mouseFollowerOpacity => throw _privateConstructorUsedError;
  int get navIndex => throw _privateConstructorUsedError;
  int get navWidth => throw _privateConstructorUsedError;
  Profile get profile => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  bool get showMouseFollower => throw _privateConstructorUsedError;
  List<Skill> get skills => throw _privateConstructorUsedError;
  bool get themeIsCollapsed => throw _privateConstructorUsedError;
  List<String> get urls => throw _privateConstructorUsedError;
  List<String>? get visited => throw _privateConstructorUsedError;
  List<WorkExperience> get work => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppDataCopyWith<AppData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDataCopyWith<$Res> {
  factory $AppDataCopyWith(AppData value, $Res Function(AppData) then) =
      _$AppDataCopyWithImpl<$Res, AppData>;
  @useResult
  $Res call(
      {bool isAboutMeOpen,
      bool isSearchOpen,
      String? lastUrl,
      double mouseFollowerOpacity,
      int navIndex,
      int navWidth,
      Profile profile,
      List<Project> projects,
      bool showMouseFollower,
      List<Skill> skills,
      bool themeIsCollapsed,
      List<String> urls,
      List<String>? visited,
      List<WorkExperience> work});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class _$AppDataCopyWithImpl<$Res, $Val extends AppData>
    implements $AppDataCopyWith<$Res> {
  _$AppDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAboutMeOpen = null,
    Object? isSearchOpen = null,
    Object? lastUrl = freezed,
    Object? mouseFollowerOpacity = null,
    Object? navIndex = null,
    Object? navWidth = null,
    Object? profile = null,
    Object? projects = null,
    Object? showMouseFollower = null,
    Object? skills = null,
    Object? themeIsCollapsed = null,
    Object? urls = null,
    Object? visited = freezed,
    Object? work = null,
  }) {
    return _then(_value.copyWith(
      isAboutMeOpen: null == isAboutMeOpen
          ? _value.isAboutMeOpen
          : isAboutMeOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchOpen: null == isSearchOpen
          ? _value.isSearchOpen
          : isSearchOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUrl: freezed == lastUrl
          ? _value.lastUrl
          : lastUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mouseFollowerOpacity: null == mouseFollowerOpacity
          ? _value.mouseFollowerOpacity
          : mouseFollowerOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      navIndex: null == navIndex
          ? _value.navIndex
          : navIndex // ignore: cast_nullable_to_non_nullable
              as int,
      navWidth: null == navWidth
          ? _value.navWidth
          : navWidth // ignore: cast_nullable_to_non_nullable
              as int,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      showMouseFollower: null == showMouseFollower
          ? _value.showMouseFollower
          : showMouseFollower // ignore: cast_nullable_to_non_nullable
              as bool,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      themeIsCollapsed: null == themeIsCollapsed
          ? _value.themeIsCollapsed
          : themeIsCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visited: freezed == visited
          ? _value.visited
          : visited // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      work: null == work
          ? _value.work
          : work // ignore: cast_nullable_to_non_nullable
              as List<WorkExperience>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppDataImplCopyWith<$Res> implements $AppDataCopyWith<$Res> {
  factory _$$AppDataImplCopyWith(
          _$AppDataImpl value, $Res Function(_$AppDataImpl) then) =
      __$$AppDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isAboutMeOpen,
      bool isSearchOpen,
      String? lastUrl,
      double mouseFollowerOpacity,
      int navIndex,
      int navWidth,
      Profile profile,
      List<Project> projects,
      bool showMouseFollower,
      List<Skill> skills,
      bool themeIsCollapsed,
      List<String> urls,
      List<String>? visited,
      List<WorkExperience> work});

  @override
  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$$AppDataImplCopyWithImpl<$Res>
    extends _$AppDataCopyWithImpl<$Res, _$AppDataImpl>
    implements _$$AppDataImplCopyWith<$Res> {
  __$$AppDataImplCopyWithImpl(
      _$AppDataImpl _value, $Res Function(_$AppDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAboutMeOpen = null,
    Object? isSearchOpen = null,
    Object? lastUrl = freezed,
    Object? mouseFollowerOpacity = null,
    Object? navIndex = null,
    Object? navWidth = null,
    Object? profile = null,
    Object? projects = null,
    Object? showMouseFollower = null,
    Object? skills = null,
    Object? themeIsCollapsed = null,
    Object? urls = null,
    Object? visited = freezed,
    Object? work = null,
  }) {
    return _then(_$AppDataImpl(
      isAboutMeOpen: null == isAboutMeOpen
          ? _value.isAboutMeOpen
          : isAboutMeOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchOpen: null == isSearchOpen
          ? _value.isSearchOpen
          : isSearchOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUrl: freezed == lastUrl
          ? _value.lastUrl
          : lastUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mouseFollowerOpacity: null == mouseFollowerOpacity
          ? _value.mouseFollowerOpacity
          : mouseFollowerOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      navIndex: null == navIndex
          ? _value.navIndex
          : navIndex // ignore: cast_nullable_to_non_nullable
              as int,
      navWidth: null == navWidth
          ? _value.navWidth
          : navWidth // ignore: cast_nullable_to_non_nullable
              as int,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      showMouseFollower: null == showMouseFollower
          ? _value.showMouseFollower
          : showMouseFollower // ignore: cast_nullable_to_non_nullable
              as bool,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      themeIsCollapsed: null == themeIsCollapsed
          ? _value.themeIsCollapsed
          : themeIsCollapsed // ignore: cast_nullable_to_non_nullable
              as bool,
      urls: null == urls
          ? _value._urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visited: freezed == visited
          ? _value._visited
          : visited // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      work: null == work
          ? _value._work
          : work // ignore: cast_nullable_to_non_nullable
              as List<WorkExperience>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppDataImpl implements _AppData {
  const _$AppDataImpl(
      {required this.isAboutMeOpen,
      required this.isSearchOpen,
      this.lastUrl,
      required this.mouseFollowerOpacity,
      required this.navIndex,
      required this.navWidth,
      required this.profile,
      required final List<Project> projects,
      required this.showMouseFollower,
      required final List<Skill> skills,
      required this.themeIsCollapsed,
      required final List<String> urls,
      final List<String>? visited,
      required final List<WorkExperience> work})
      : _projects = projects,
        _skills = skills,
        _urls = urls,
        _visited = visited,
        _work = work;

  factory _$AppDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppDataImplFromJson(json);

  ///where did our user leave off last time?
  @override
  final bool isAboutMeOpen;
  @override
  final bool isSearchOpen;
  @override
  final String? lastUrl;

  ///0.05 -> 0.5
  @override
  final double mouseFollowerOpacity;
  @override
  final int navIndex;
  @override
  final int navWidth;
  @override
  final Profile profile;
  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final bool showMouseFollower;
  final List<Skill> _skills;
  @override
  List<Skill> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  @override
  final bool themeIsCollapsed;
  final List<String> _urls;
  @override
  List<String> get urls {
    if (_urls is EqualUnmodifiableListView) return _urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urls);
  }

  final List<String>? _visited;
  @override
  List<String>? get visited {
    final value = _visited;
    if (value == null) return null;
    if (_visited is EqualUnmodifiableListView) return _visited;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<WorkExperience> _work;
  @override
  List<WorkExperience> get work {
    if (_work is EqualUnmodifiableListView) return _work;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_work);
  }

  @override
  String toString() {
    return 'AppData(isAboutMeOpen: $isAboutMeOpen, isSearchOpen: $isSearchOpen, lastUrl: $lastUrl, mouseFollowerOpacity: $mouseFollowerOpacity, navIndex: $navIndex, navWidth: $navWidth, profile: $profile, projects: $projects, showMouseFollower: $showMouseFollower, skills: $skills, themeIsCollapsed: $themeIsCollapsed, urls: $urls, visited: $visited, work: $work)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDataImpl &&
            (identical(other.isAboutMeOpen, isAboutMeOpen) ||
                other.isAboutMeOpen == isAboutMeOpen) &&
            (identical(other.isSearchOpen, isSearchOpen) ||
                other.isSearchOpen == isSearchOpen) &&
            (identical(other.lastUrl, lastUrl) || other.lastUrl == lastUrl) &&
            (identical(other.mouseFollowerOpacity, mouseFollowerOpacity) ||
                other.mouseFollowerOpacity == mouseFollowerOpacity) &&
            (identical(other.navIndex, navIndex) ||
                other.navIndex == navIndex) &&
            (identical(other.navWidth, navWidth) ||
                other.navWidth == navWidth) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.showMouseFollower, showMouseFollower) ||
                other.showMouseFollower == showMouseFollower) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.themeIsCollapsed, themeIsCollapsed) ||
                other.themeIsCollapsed == themeIsCollapsed) &&
            const DeepCollectionEquality().equals(other._urls, _urls) &&
            const DeepCollectionEquality().equals(other._visited, _visited) &&
            const DeepCollectionEquality().equals(other._work, _work));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isAboutMeOpen,
      isSearchOpen,
      lastUrl,
      mouseFollowerOpacity,
      navIndex,
      navWidth,
      profile,
      const DeepCollectionEquality().hash(_projects),
      showMouseFollower,
      const DeepCollectionEquality().hash(_skills),
      themeIsCollapsed,
      const DeepCollectionEquality().hash(_urls),
      const DeepCollectionEquality().hash(_visited),
      const DeepCollectionEquality().hash(_work));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDataImplCopyWith<_$AppDataImpl> get copyWith =>
      __$$AppDataImplCopyWithImpl<_$AppDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppDataImplToJson(
      this,
    );
  }
}

abstract class _AppData implements AppData {
  const factory _AppData(
      {required final bool isAboutMeOpen,
      required final bool isSearchOpen,
      final String? lastUrl,
      required final double mouseFollowerOpacity,
      required final int navIndex,
      required final int navWidth,
      required final Profile profile,
      required final List<Project> projects,
      required final bool showMouseFollower,
      required final List<Skill> skills,
      required final bool themeIsCollapsed,
      required final List<String> urls,
      final List<String>? visited,
      required final List<WorkExperience> work}) = _$AppDataImpl;

  factory _AppData.fromJson(Map<String, dynamic> json) = _$AppDataImpl.fromJson;

  @override

  ///where did our user leave off last time?
  bool get isAboutMeOpen;
  @override
  bool get isSearchOpen;
  @override
  String? get lastUrl;
  @override

  ///0.05 -> 0.5
  double get mouseFollowerOpacity;
  @override
  int get navIndex;
  @override
  int get navWidth;
  @override
  Profile get profile;
  @override
  List<Project> get projects;
  @override
  bool get showMouseFollower;
  @override
  List<Skill> get skills;
  @override
  bool get themeIsCollapsed;
  @override
  List<String> get urls;
  @override
  List<String>? get visited;
  @override
  List<WorkExperience> get work;
  @override
  @JsonKey(ignore: true)
  _$$AppDataImplCopyWith<_$AppDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  int get birthDate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  List<String> get links => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {int birthDate,
      String description,
      String email,
      String imagePath,
      List<String> links,
      String name,
      String phoneNumber});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthDate = null,
    Object? description = null,
    Object? email = null,
    Object? imagePath = null,
    Object? links = null,
    Object? name = null,
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int birthDate,
      String description,
      String email,
      String imagePath,
      List<String> links,
      String name,
      String phoneNumber});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthDate = null,
    Object? description = null,
    Object? email = null,
    Object? imagePath = null,
    Object? links = null,
    Object? name = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$ProfileImpl(
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {required this.birthDate,
      required this.description,
      required this.email,
      required this.imagePath,
      required final List<String> links,
      required this.name,
      required this.phoneNumber})
      : _links = links;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final int birthDate;
  @override
  final String description;
  @override
  final String email;
  @override
  final String imagePath;
  final List<String> _links;
  @override
  List<String> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  @override
  final String name;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'Profile(birthDate: $birthDate, description: $description, email: $email, imagePath: $imagePath, links: $links, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      birthDate,
      description,
      email,
      imagePath,
      const DeepCollectionEquality().hash(_links),
      name,
      phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {required final int birthDate,
      required final String description,
      required final String email,
      required final String imagePath,
      required final List<String> links,
      required final String name,
      required final String phoneNumber}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  int get birthDate;
  @override
  String get description;
  @override
  String get email;
  @override
  String get imagePath;
  @override
  List<String> get links;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  List<int> get color => throw _privateConstructorUsedError;
  CompletionType get completionType => throw _privateConstructorUsedError;

  ///our content in the form of markdown
  String get content => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get endMsse => throw _privateConstructorUsedError;
  String get iconAssetPath => throw _privateConstructorUsedError;
  List<ImageUrl>? get imgUrls => throw _privateConstructorUsedError;
  List<String> get lessons => throw _privateConstructorUsedError;
  List<PlatForms>? get platforms => throw _privateConstructorUsedError;
  int get startMsse => throw _privateConstructorUsedError;
  List<Technology> get technologies => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {List<int> color,
      CompletionType completionType,
      String content,
      String description,
      int endMsse,
      String iconAssetPath,
      List<ImageUrl>? imgUrls,
      List<String> lessons,
      List<PlatForms>? platforms,
      int startMsse,
      List<Technology> technologies,
      String title,
      String? url});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? completionType = null,
    Object? content = null,
    Object? description = null,
    Object? endMsse = null,
    Object? iconAssetPath = null,
    Object? imgUrls = freezed,
    Object? lessons = null,
    Object? platforms = freezed,
    Object? startMsse = null,
    Object? technologies = null,
    Object? title = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as List<int>,
      completionType: null == completionType
          ? _value.completionType
          : completionType // ignore: cast_nullable_to_non_nullable
              as CompletionType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: null == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as int,
      iconAssetPath: null == iconAssetPath
          ? _value.iconAssetPath
          : iconAssetPath // ignore: cast_nullable_to_non_nullable
              as String,
      imgUrls: freezed == imgUrls
          ? _value.imgUrls
          : imgUrls // ignore: cast_nullable_to_non_nullable
              as List<ImageUrl>?,
      lessons: null == lessons
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: freezed == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<PlatForms>?,
      startMsse: null == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as int,
      technologies: null == technologies
          ? _value.technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as List<Technology>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> color,
      CompletionType completionType,
      String content,
      String description,
      int endMsse,
      String iconAssetPath,
      List<ImageUrl>? imgUrls,
      List<String> lessons,
      List<PlatForms>? platforms,
      int startMsse,
      List<Technology> technologies,
      String title,
      String? url});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? completionType = null,
    Object? content = null,
    Object? description = null,
    Object? endMsse = null,
    Object? iconAssetPath = null,
    Object? imgUrls = freezed,
    Object? lessons = null,
    Object? platforms = freezed,
    Object? startMsse = null,
    Object? technologies = null,
    Object? title = null,
    Object? url = freezed,
  }) {
    return _then(_$ProjectImpl(
      color: null == color
          ? _value._color
          : color // ignore: cast_nullable_to_non_nullable
              as List<int>,
      completionType: null == completionType
          ? _value.completionType
          : completionType // ignore: cast_nullable_to_non_nullable
              as CompletionType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: null == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as int,
      iconAssetPath: null == iconAssetPath
          ? _value.iconAssetPath
          : iconAssetPath // ignore: cast_nullable_to_non_nullable
              as String,
      imgUrls: freezed == imgUrls
          ? _value._imgUrls
          : imgUrls // ignore: cast_nullable_to_non_nullable
              as List<ImageUrl>?,
      lessons: null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: freezed == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<PlatForms>?,
      startMsse: null == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as int,
      technologies: null == technologies
          ? _value._technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as List<Technology>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl implements _Project {
  const _$ProjectImpl(
      {required final List<int> color,
      required this.completionType,
      required this.content,
      required this.description,
      required this.endMsse,
      required this.iconAssetPath,
      final List<ImageUrl>? imgUrls,
      required final List<String> lessons,
      final List<PlatForms>? platforms,
      required this.startMsse,
      required final List<Technology> technologies,
      required this.title,
      this.url})
      : _color = color,
        _imgUrls = imgUrls,
        _lessons = lessons,
        _platforms = platforms,
        _technologies = technologies;

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  final List<int> _color;
  @override
  List<int> get color {
    if (_color is EqualUnmodifiableListView) return _color;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_color);
  }

  @override
  final CompletionType completionType;

  ///our content in the form of markdown
  @override
  final String content;
  @override
  final String description;
  @override
  final int endMsse;
  @override
  final String iconAssetPath;
  final List<ImageUrl>? _imgUrls;
  @override
  List<ImageUrl>? get imgUrls {
    final value = _imgUrls;
    if (value == null) return null;
    if (_imgUrls is EqualUnmodifiableListView) return _imgUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _lessons;
  @override
  List<String> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  final List<PlatForms>? _platforms;
  @override
  List<PlatForms>? get platforms {
    final value = _platforms;
    if (value == null) return null;
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int startMsse;
  final List<Technology> _technologies;
  @override
  List<Technology> get technologies {
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologies);
  }

  @override
  final String title;
  @override
  final String? url;

  @override
  String toString() {
    return 'Project(color: $color, completionType: $completionType, content: $content, description: $description, endMsse: $endMsse, iconAssetPath: $iconAssetPath, imgUrls: $imgUrls, lessons: $lessons, platforms: $platforms, startMsse: $startMsse, technologies: $technologies, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            const DeepCollectionEquality().equals(other._color, _color) &&
            (identical(other.completionType, completionType) ||
                other.completionType == completionType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.endMsse, endMsse) || other.endMsse == endMsse) &&
            (identical(other.iconAssetPath, iconAssetPath) ||
                other.iconAssetPath == iconAssetPath) &&
            const DeepCollectionEquality().equals(other._imgUrls, _imgUrls) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            (identical(other.startMsse, startMsse) ||
                other.startMsse == startMsse) &&
            const DeepCollectionEquality()
                .equals(other._technologies, _technologies) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_color),
      completionType,
      content,
      description,
      endMsse,
      iconAssetPath,
      const DeepCollectionEquality().hash(_imgUrls),
      const DeepCollectionEquality().hash(_lessons),
      const DeepCollectionEquality().hash(_platforms),
      startMsse,
      const DeepCollectionEquality().hash(_technologies),
      title,
      url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project implements Project {
  const factory _Project(
      {required final List<int> color,
      required final CompletionType completionType,
      required final String content,
      required final String description,
      required final int endMsse,
      required final String iconAssetPath,
      final List<ImageUrl>? imgUrls,
      required final List<String> lessons,
      final List<PlatForms>? platforms,
      required final int startMsse,
      required final List<Technology> technologies,
      required final String title,
      final String? url}) = _$ProjectImpl;

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  List<int> get color;
  @override
  CompletionType get completionType;
  @override

  ///our content in the form of markdown
  String get content;
  @override
  String get description;
  @override
  int get endMsse;
  @override
  String get iconAssetPath;
  @override
  List<ImageUrl>? get imgUrls;
  @override
  List<String> get lessons;
  @override
  List<PlatForms>? get platforms;
  @override
  int get startMsse;
  @override
  List<Technology> get technologies;
  @override
  String get title;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageUrl _$ImageUrlFromJson(Map<String, dynamic> json) {
  return _ImageUrl.fromJson(json);
}

/// @nodoc
mixin _$ImageUrl {
  String get thumbNail => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageUrlCopyWith<ImageUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageUrlCopyWith<$Res> {
  factory $ImageUrlCopyWith(ImageUrl value, $Res Function(ImageUrl) then) =
      _$ImageUrlCopyWithImpl<$Res, ImageUrl>;
  @useResult
  $Res call({String thumbNail, String url});
}

/// @nodoc
class _$ImageUrlCopyWithImpl<$Res, $Val extends ImageUrl>
    implements $ImageUrlCopyWith<$Res> {
  _$ImageUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thumbNail = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      thumbNail: null == thumbNail
          ? _value.thumbNail
          : thumbNail // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageUrlImplCopyWith<$Res>
    implements $ImageUrlCopyWith<$Res> {
  factory _$$ImageUrlImplCopyWith(
          _$ImageUrlImpl value, $Res Function(_$ImageUrlImpl) then) =
      __$$ImageUrlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String thumbNail, String url});
}

/// @nodoc
class __$$ImageUrlImplCopyWithImpl<$Res>
    extends _$ImageUrlCopyWithImpl<$Res, _$ImageUrlImpl>
    implements _$$ImageUrlImplCopyWith<$Res> {
  __$$ImageUrlImplCopyWithImpl(
      _$ImageUrlImpl _value, $Res Function(_$ImageUrlImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thumbNail = null,
    Object? url = null,
  }) {
    return _then(_$ImageUrlImpl(
      thumbNail: null == thumbNail
          ? _value.thumbNail
          : thumbNail // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageUrlImpl implements _ImageUrl {
  const _$ImageUrlImpl({required this.thumbNail, required this.url});

  factory _$ImageUrlImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageUrlImplFromJson(json);

  @override
  final String thumbNail;
  @override
  final String url;

  @override
  String toString() {
    return 'ImageUrl(thumbNail: $thumbNail, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUrlImpl &&
            (identical(other.thumbNail, thumbNail) ||
                other.thumbNail == thumbNail) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, thumbNail, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUrlImplCopyWith<_$ImageUrlImpl> get copyWith =>
      __$$ImageUrlImplCopyWithImpl<_$ImageUrlImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageUrlImplToJson(
      this,
    );
  }
}

abstract class _ImageUrl implements ImageUrl {
  const factory _ImageUrl(
      {required final String thumbNail,
      required final String url}) = _$ImageUrlImpl;

  factory _ImageUrl.fromJson(Map<String, dynamic> json) =
      _$ImageUrlImpl.fromJson;

  @override
  String get thumbNail;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$ImageUrlImplCopyWith<_$ImageUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlatForms _$PlatFormsFromJson(Map<String, dynamic> json) {
  return _PlatForms.fromJson(json);
}

/// @nodoc
mixin _$PlatForms {
  IOs? get iOs => throw _privateConstructorUsedError;
  Web? get web => throw _privateConstructorUsedError;
  IPad? get iPad => throw _privateConstructorUsedError;
  MacOs? get macOs => throw _privateConstructorUsedError;
  Linux? get linux => throw _privateConstructorUsedError;
  Watch? get watch => throw _privateConstructorUsedError;
  Windows? get windows => throw _privateConstructorUsedError;
  Android? get android => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlatFormsCopyWith<PlatForms> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlatFormsCopyWith<$Res> {
  factory $PlatFormsCopyWith(PlatForms value, $Res Function(PlatForms) then) =
      _$PlatFormsCopyWithImpl<$Res, PlatForms>;
  @useResult
  $Res call(
      {IOs? iOs,
      Web? web,
      IPad? iPad,
      MacOs? macOs,
      Linux? linux,
      Watch? watch,
      Windows? windows,
      Android? android});

  $IOsCopyWith<$Res>? get iOs;
  $WebCopyWith<$Res>? get web;
  $IPadCopyWith<$Res>? get iPad;
  $MacOsCopyWith<$Res>? get macOs;
  $LinuxCopyWith<$Res>? get linux;
  $WatchCopyWith<$Res>? get watch;
  $WindowsCopyWith<$Res>? get windows;
  $AndroidCopyWith<$Res>? get android;
}

/// @nodoc
class _$PlatFormsCopyWithImpl<$Res, $Val extends PlatForms>
    implements $PlatFormsCopyWith<$Res> {
  _$PlatFormsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iOs = freezed,
    Object? web = freezed,
    Object? iPad = freezed,
    Object? macOs = freezed,
    Object? linux = freezed,
    Object? watch = freezed,
    Object? windows = freezed,
    Object? android = freezed,
  }) {
    return _then(_value.copyWith(
      iOs: freezed == iOs
          ? _value.iOs
          : iOs // ignore: cast_nullable_to_non_nullable
              as IOs?,
      web: freezed == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as Web?,
      iPad: freezed == iPad
          ? _value.iPad
          : iPad // ignore: cast_nullable_to_non_nullable
              as IPad?,
      macOs: freezed == macOs
          ? _value.macOs
          : macOs // ignore: cast_nullable_to_non_nullable
              as MacOs?,
      linux: freezed == linux
          ? _value.linux
          : linux // ignore: cast_nullable_to_non_nullable
              as Linux?,
      watch: freezed == watch
          ? _value.watch
          : watch // ignore: cast_nullable_to_non_nullable
              as Watch?,
      windows: freezed == windows
          ? _value.windows
          : windows // ignore: cast_nullable_to_non_nullable
              as Windows?,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as Android?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IOsCopyWith<$Res>? get iOs {
    if (_value.iOs == null) {
      return null;
    }

    return $IOsCopyWith<$Res>(_value.iOs!, (value) {
      return _then(_value.copyWith(iOs: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WebCopyWith<$Res>? get web {
    if (_value.web == null) {
      return null;
    }

    return $WebCopyWith<$Res>(_value.web!, (value) {
      return _then(_value.copyWith(web: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IPadCopyWith<$Res>? get iPad {
    if (_value.iPad == null) {
      return null;
    }

    return $IPadCopyWith<$Res>(_value.iPad!, (value) {
      return _then(_value.copyWith(iPad: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MacOsCopyWith<$Res>? get macOs {
    if (_value.macOs == null) {
      return null;
    }

    return $MacOsCopyWith<$Res>(_value.macOs!, (value) {
      return _then(_value.copyWith(macOs: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LinuxCopyWith<$Res>? get linux {
    if (_value.linux == null) {
      return null;
    }

    return $LinuxCopyWith<$Res>(_value.linux!, (value) {
      return _then(_value.copyWith(linux: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WatchCopyWith<$Res>? get watch {
    if (_value.watch == null) {
      return null;
    }

    return $WatchCopyWith<$Res>(_value.watch!, (value) {
      return _then(_value.copyWith(watch: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WindowsCopyWith<$Res>? get windows {
    if (_value.windows == null) {
      return null;
    }

    return $WindowsCopyWith<$Res>(_value.windows!, (value) {
      return _then(_value.copyWith(windows: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AndroidCopyWith<$Res>? get android {
    if (_value.android == null) {
      return null;
    }

    return $AndroidCopyWith<$Res>(_value.android!, (value) {
      return _then(_value.copyWith(android: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlatFormsImplCopyWith<$Res>
    implements $PlatFormsCopyWith<$Res> {
  factory _$$PlatFormsImplCopyWith(
          _$PlatFormsImpl value, $Res Function(_$PlatFormsImpl) then) =
      __$$PlatFormsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IOs? iOs,
      Web? web,
      IPad? iPad,
      MacOs? macOs,
      Linux? linux,
      Watch? watch,
      Windows? windows,
      Android? android});

  @override
  $IOsCopyWith<$Res>? get iOs;
  @override
  $WebCopyWith<$Res>? get web;
  @override
  $IPadCopyWith<$Res>? get iPad;
  @override
  $MacOsCopyWith<$Res>? get macOs;
  @override
  $LinuxCopyWith<$Res>? get linux;
  @override
  $WatchCopyWith<$Res>? get watch;
  @override
  $WindowsCopyWith<$Res>? get windows;
  @override
  $AndroidCopyWith<$Res>? get android;
}

/// @nodoc
class __$$PlatFormsImplCopyWithImpl<$Res>
    extends _$PlatFormsCopyWithImpl<$Res, _$PlatFormsImpl>
    implements _$$PlatFormsImplCopyWith<$Res> {
  __$$PlatFormsImplCopyWithImpl(
      _$PlatFormsImpl _value, $Res Function(_$PlatFormsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iOs = freezed,
    Object? web = freezed,
    Object? iPad = freezed,
    Object? macOs = freezed,
    Object? linux = freezed,
    Object? watch = freezed,
    Object? windows = freezed,
    Object? android = freezed,
  }) {
    return _then(_$PlatFormsImpl(
      iOs: freezed == iOs
          ? _value.iOs
          : iOs // ignore: cast_nullable_to_non_nullable
              as IOs?,
      web: freezed == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as Web?,
      iPad: freezed == iPad
          ? _value.iPad
          : iPad // ignore: cast_nullable_to_non_nullable
              as IPad?,
      macOs: freezed == macOs
          ? _value.macOs
          : macOs // ignore: cast_nullable_to_non_nullable
              as MacOs?,
      linux: freezed == linux
          ? _value.linux
          : linux // ignore: cast_nullable_to_non_nullable
              as Linux?,
      watch: freezed == watch
          ? _value.watch
          : watch // ignore: cast_nullable_to_non_nullable
              as Watch?,
      windows: freezed == windows
          ? _value.windows
          : windows // ignore: cast_nullable_to_non_nullable
              as Windows?,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as Android?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlatFormsImpl implements _PlatForms {
  const _$PlatFormsImpl(
      {this.iOs,
      this.web,
      this.iPad,
      this.macOs,
      this.linux,
      this.watch,
      this.windows,
      this.android});

  factory _$PlatFormsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlatFormsImplFromJson(json);

  @override
  final IOs? iOs;
  @override
  final Web? web;
  @override
  final IPad? iPad;
  @override
  final MacOs? macOs;
  @override
  final Linux? linux;
  @override
  final Watch? watch;
  @override
  final Windows? windows;
  @override
  final Android? android;

  @override
  String toString() {
    return 'PlatForms(iOs: $iOs, web: $web, iPad: $iPad, macOs: $macOs, linux: $linux, watch: $watch, windows: $windows, android: $android)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlatFormsImpl &&
            (identical(other.iOs, iOs) || other.iOs == iOs) &&
            (identical(other.web, web) || other.web == web) &&
            (identical(other.iPad, iPad) || other.iPad == iPad) &&
            (identical(other.macOs, macOs) || other.macOs == macOs) &&
            (identical(other.linux, linux) || other.linux == linux) &&
            (identical(other.watch, watch) || other.watch == watch) &&
            (identical(other.windows, windows) || other.windows == windows) &&
            (identical(other.android, android) || other.android == android));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, iOs, web, iPad, macOs, linux, watch, windows, android);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlatFormsImplCopyWith<_$PlatFormsImpl> get copyWith =>
      __$$PlatFormsImplCopyWithImpl<_$PlatFormsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlatFormsImplToJson(
      this,
    );
  }
}

abstract class _PlatForms implements PlatForms {
  const factory _PlatForms(
      {final IOs? iOs,
      final Web? web,
      final IPad? iPad,
      final MacOs? macOs,
      final Linux? linux,
      final Watch? watch,
      final Windows? windows,
      final Android? android}) = _$PlatFormsImpl;

  factory _PlatForms.fromJson(Map<String, dynamic> json) =
      _$PlatFormsImpl.fromJson;

  @override
  IOs? get iOs;
  @override
  Web? get web;
  @override
  IPad? get iPad;
  @override
  MacOs? get macOs;
  @override
  Linux? get linux;
  @override
  Watch? get watch;
  @override
  Windows? get windows;
  @override
  Android? get android;
  @override
  @JsonKey(ignore: true)
  _$$PlatFormsImplCopyWith<_$PlatFormsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Android _$AndroidFromJson(Map<String, dynamic> json) {
  return _Android.fromJson(json);
}

/// @nodoc
mixin _$Android {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidCopyWith<Android> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidCopyWith<$Res> {
  factory $AndroidCopyWith(Android value, $Res Function(Android) then) =
      _$AndroidCopyWithImpl<$Res, Android>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$AndroidCopyWithImpl<$Res, $Val extends Android>
    implements $AndroidCopyWith<$Res> {
  _$AndroidCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AndroidImplCopyWith<$Res> implements $AndroidCopyWith<$Res> {
  factory _$$AndroidImplCopyWith(
          _$AndroidImpl value, $Res Function(_$AndroidImpl) then) =
      __$$AndroidImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$AndroidImplCopyWithImpl<$Res>
    extends _$AndroidCopyWithImpl<$Res, _$AndroidImpl>
    implements _$$AndroidImplCopyWith<$Res> {
  __$$AndroidImplCopyWithImpl(
      _$AndroidImpl _value, $Res Function(_$AndroidImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$AndroidImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AndroidImpl implements _Android {
  const _$AndroidImpl({this.url});

  factory _$AndroidImpl.fromJson(Map<String, dynamic> json) =>
      _$$AndroidImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Android(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AndroidImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AndroidImplCopyWith<_$AndroidImpl> get copyWith =>
      __$$AndroidImplCopyWithImpl<_$AndroidImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AndroidImplToJson(
      this,
    );
  }
}

abstract class _Android implements Android {
  const factory _Android({final String? url}) = _$AndroidImpl;

  factory _Android.fromJson(Map<String, dynamic> json) = _$AndroidImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$AndroidImplCopyWith<_$AndroidImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IOs _$IOsFromJson(Map<String, dynamic> json) {
  return _IOs.fromJson(json);
}

/// @nodoc
mixin _$IOs {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IOsCopyWith<IOs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOsCopyWith<$Res> {
  factory $IOsCopyWith(IOs value, $Res Function(IOs) then) =
      _$IOsCopyWithImpl<$Res, IOs>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$IOsCopyWithImpl<$Res, $Val extends IOs> implements $IOsCopyWith<$Res> {
  _$IOsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IOsImplCopyWith<$Res> implements $IOsCopyWith<$Res> {
  factory _$$IOsImplCopyWith(_$IOsImpl value, $Res Function(_$IOsImpl) then) =
      __$$IOsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$IOsImplCopyWithImpl<$Res> extends _$IOsCopyWithImpl<$Res, _$IOsImpl>
    implements _$$IOsImplCopyWith<$Res> {
  __$$IOsImplCopyWithImpl(_$IOsImpl _value, $Res Function(_$IOsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$IOsImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IOsImpl implements _IOs {
  const _$IOsImpl({this.url});

  factory _$IOsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IOsImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'IOs(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IOsImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IOsImplCopyWith<_$IOsImpl> get copyWith =>
      __$$IOsImplCopyWithImpl<_$IOsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IOsImplToJson(
      this,
    );
  }
}

abstract class _IOs implements IOs {
  const factory _IOs({final String? url}) = _$IOsImpl;

  factory _IOs.fromJson(Map<String, dynamic> json) = _$IOsImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$IOsImplCopyWith<_$IOsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IPad _$IPadFromJson(Map<String, dynamic> json) {
  return _IPad.fromJson(json);
}

/// @nodoc
mixin _$IPad {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IPadCopyWith<IPad> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IPadCopyWith<$Res> {
  factory $IPadCopyWith(IPad value, $Res Function(IPad) then) =
      _$IPadCopyWithImpl<$Res, IPad>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$IPadCopyWithImpl<$Res, $Val extends IPad>
    implements $IPadCopyWith<$Res> {
  _$IPadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IPadImplCopyWith<$Res> implements $IPadCopyWith<$Res> {
  factory _$$IPadImplCopyWith(
          _$IPadImpl value, $Res Function(_$IPadImpl) then) =
      __$$IPadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$IPadImplCopyWithImpl<$Res>
    extends _$IPadCopyWithImpl<$Res, _$IPadImpl>
    implements _$$IPadImplCopyWith<$Res> {
  __$$IPadImplCopyWithImpl(_$IPadImpl _value, $Res Function(_$IPadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$IPadImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IPadImpl implements _IPad {
  const _$IPadImpl({this.url});

  factory _$IPadImpl.fromJson(Map<String, dynamic> json) =>
      _$$IPadImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'IPad(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IPadImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IPadImplCopyWith<_$IPadImpl> get copyWith =>
      __$$IPadImplCopyWithImpl<_$IPadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IPadImplToJson(
      this,
    );
  }
}

abstract class _IPad implements IPad {
  const factory _IPad({final String? url}) = _$IPadImpl;

  factory _IPad.fromJson(Map<String, dynamic> json) = _$IPadImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$IPadImplCopyWith<_$IPadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Linux _$LinuxFromJson(Map<String, dynamic> json) {
  return _Linux.fromJson(json);
}

/// @nodoc
mixin _$Linux {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinuxCopyWith<Linux> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinuxCopyWith<$Res> {
  factory $LinuxCopyWith(Linux value, $Res Function(Linux) then) =
      _$LinuxCopyWithImpl<$Res, Linux>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$LinuxCopyWithImpl<$Res, $Val extends Linux>
    implements $LinuxCopyWith<$Res> {
  _$LinuxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinuxImplCopyWith<$Res> implements $LinuxCopyWith<$Res> {
  factory _$$LinuxImplCopyWith(
          _$LinuxImpl value, $Res Function(_$LinuxImpl) then) =
      __$$LinuxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$LinuxImplCopyWithImpl<$Res>
    extends _$LinuxCopyWithImpl<$Res, _$LinuxImpl>
    implements _$$LinuxImplCopyWith<$Res> {
  __$$LinuxImplCopyWithImpl(
      _$LinuxImpl _value, $Res Function(_$LinuxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$LinuxImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinuxImpl implements _Linux {
  const _$LinuxImpl({this.url});

  factory _$LinuxImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinuxImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Linux(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinuxImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinuxImplCopyWith<_$LinuxImpl> get copyWith =>
      __$$LinuxImplCopyWithImpl<_$LinuxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinuxImplToJson(
      this,
    );
  }
}

abstract class _Linux implements Linux {
  const factory _Linux({final String? url}) = _$LinuxImpl;

  factory _Linux.fromJson(Map<String, dynamic> json) = _$LinuxImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$LinuxImplCopyWith<_$LinuxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MacOs _$MacOsFromJson(Map<String, dynamic> json) {
  return _MacOs.fromJson(json);
}

/// @nodoc
mixin _$MacOs {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MacOsCopyWith<MacOs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MacOsCopyWith<$Res> {
  factory $MacOsCopyWith(MacOs value, $Res Function(MacOs) then) =
      _$MacOsCopyWithImpl<$Res, MacOs>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$MacOsCopyWithImpl<$Res, $Val extends MacOs>
    implements $MacOsCopyWith<$Res> {
  _$MacOsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MacOsImplCopyWith<$Res> implements $MacOsCopyWith<$Res> {
  factory _$$MacOsImplCopyWith(
          _$MacOsImpl value, $Res Function(_$MacOsImpl) then) =
      __$$MacOsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$MacOsImplCopyWithImpl<$Res>
    extends _$MacOsCopyWithImpl<$Res, _$MacOsImpl>
    implements _$$MacOsImplCopyWith<$Res> {
  __$$MacOsImplCopyWithImpl(
      _$MacOsImpl _value, $Res Function(_$MacOsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$MacOsImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MacOsImpl implements _MacOs {
  const _$MacOsImpl({this.url});

  factory _$MacOsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MacOsImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'MacOs(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MacOsImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MacOsImplCopyWith<_$MacOsImpl> get copyWith =>
      __$$MacOsImplCopyWithImpl<_$MacOsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MacOsImplToJson(
      this,
    );
  }
}

abstract class _MacOs implements MacOs {
  const factory _MacOs({final String? url}) = _$MacOsImpl;

  factory _MacOs.fromJson(Map<String, dynamic> json) = _$MacOsImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$MacOsImplCopyWith<_$MacOsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Watch _$WatchFromJson(Map<String, dynamic> json) {
  return _Watch.fromJson(json);
}

/// @nodoc
mixin _$Watch {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WatchCopyWith<Watch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchCopyWith<$Res> {
  factory $WatchCopyWith(Watch value, $Res Function(Watch) then) =
      _$WatchCopyWithImpl<$Res, Watch>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$WatchCopyWithImpl<$Res, $Val extends Watch>
    implements $WatchCopyWith<$Res> {
  _$WatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchImplCopyWith<$Res> implements $WatchCopyWith<$Res> {
  factory _$$WatchImplCopyWith(
          _$WatchImpl value, $Res Function(_$WatchImpl) then) =
      __$$WatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$WatchImplCopyWithImpl<$Res>
    extends _$WatchCopyWithImpl<$Res, _$WatchImpl>
    implements _$$WatchImplCopyWith<$Res> {
  __$$WatchImplCopyWithImpl(
      _$WatchImpl _value, $Res Function(_$WatchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$WatchImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchImpl implements _Watch {
  const _$WatchImpl({this.url});

  factory _$WatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Watch(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchImplCopyWith<_$WatchImpl> get copyWith =>
      __$$WatchImplCopyWithImpl<_$WatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchImplToJson(
      this,
    );
  }
}

abstract class _Watch implements Watch {
  const factory _Watch({final String? url}) = _$WatchImpl;

  factory _Watch.fromJson(Map<String, dynamic> json) = _$WatchImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$WatchImplCopyWith<_$WatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Web _$WebFromJson(Map<String, dynamic> json) {
  return _Web.fromJson(json);
}

/// @nodoc
mixin _$Web {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebCopyWith<Web> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebCopyWith<$Res> {
  factory $WebCopyWith(Web value, $Res Function(Web) then) =
      _$WebCopyWithImpl<$Res, Web>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$WebCopyWithImpl<$Res, $Val extends Web> implements $WebCopyWith<$Res> {
  _$WebCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebImplCopyWith<$Res> implements $WebCopyWith<$Res> {
  factory _$$WebImplCopyWith(_$WebImpl value, $Res Function(_$WebImpl) then) =
      __$$WebImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$WebImplCopyWithImpl<$Res> extends _$WebCopyWithImpl<$Res, _$WebImpl>
    implements _$$WebImplCopyWith<$Res> {
  __$$WebImplCopyWithImpl(_$WebImpl _value, $Res Function(_$WebImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$WebImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebImpl implements _Web {
  const _$WebImpl({this.url});

  factory _$WebImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Web(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebImplCopyWith<_$WebImpl> get copyWith =>
      __$$WebImplCopyWithImpl<_$WebImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebImplToJson(
      this,
    );
  }
}

abstract class _Web implements Web {
  const factory _Web({final String? url}) = _$WebImpl;

  factory _Web.fromJson(Map<String, dynamic> json) = _$WebImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$WebImplCopyWith<_$WebImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Windows _$WindowsFromJson(Map<String, dynamic> json) {
  return _Windows.fromJson(json);
}

/// @nodoc
mixin _$Windows {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WindowsCopyWith<Windows> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindowsCopyWith<$Res> {
  factory $WindowsCopyWith(Windows value, $Res Function(Windows) then) =
      _$WindowsCopyWithImpl<$Res, Windows>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$WindowsCopyWithImpl<$Res, $Val extends Windows>
    implements $WindowsCopyWith<$Res> {
  _$WindowsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WindowsImplCopyWith<$Res> implements $WindowsCopyWith<$Res> {
  factory _$$WindowsImplCopyWith(
          _$WindowsImpl value, $Res Function(_$WindowsImpl) then) =
      __$$WindowsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$WindowsImplCopyWithImpl<$Res>
    extends _$WindowsCopyWithImpl<$Res, _$WindowsImpl>
    implements _$$WindowsImplCopyWith<$Res> {
  __$$WindowsImplCopyWithImpl(
      _$WindowsImpl _value, $Res Function(_$WindowsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$WindowsImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WindowsImpl implements _Windows {
  const _$WindowsImpl({this.url});

  factory _$WindowsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WindowsImplFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Windows(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WindowsImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WindowsImplCopyWith<_$WindowsImpl> get copyWith =>
      __$$WindowsImplCopyWithImpl<_$WindowsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WindowsImplToJson(
      this,
    );
  }
}

abstract class _Windows implements Windows {
  const factory _Windows({final String? url}) = _$WindowsImpl;

  factory _Windows.fromJson(Map<String, dynamic> json) = _$WindowsImpl.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$WindowsImplCopyWith<_$WindowsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Technology _$TechnologyFromJson(Map<String, dynamic> json) {
  return _Technology.fromJson(json);
}

/// @nodoc
mixin _$Technology {
  String get label => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechnologyCopyWith<Technology> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnologyCopyWith<$Res> {
  factory $TechnologyCopyWith(
          Technology value, $Res Function(Technology) then) =
      _$TechnologyCopyWithImpl<$Res, Technology>;
  @useResult
  $Res call({String label, String? url});
}

/// @nodoc
class _$TechnologyCopyWithImpl<$Res, $Val extends Technology>
    implements $TechnologyCopyWith<$Res> {
  _$TechnologyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TechnologyImplCopyWith<$Res>
    implements $TechnologyCopyWith<$Res> {
  factory _$$TechnologyImplCopyWith(
          _$TechnologyImpl value, $Res Function(_$TechnologyImpl) then) =
      __$$TechnologyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String? url});
}

/// @nodoc
class __$$TechnologyImplCopyWithImpl<$Res>
    extends _$TechnologyCopyWithImpl<$Res, _$TechnologyImpl>
    implements _$$TechnologyImplCopyWith<$Res> {
  __$$TechnologyImplCopyWithImpl(
      _$TechnologyImpl _value, $Res Function(_$TechnologyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? url = freezed,
  }) {
    return _then(_$TechnologyImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TechnologyImpl implements _Technology {
  const _$TechnologyImpl({required this.label, this.url});

  factory _$TechnologyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechnologyImplFromJson(json);

  @override
  final String label;
  @override
  final String? url;

  @override
  String toString() {
    return 'Technology(label: $label, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechnologyImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TechnologyImplCopyWith<_$TechnologyImpl> get copyWith =>
      __$$TechnologyImplCopyWithImpl<_$TechnologyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechnologyImplToJson(
      this,
    );
  }
}

abstract class _Technology implements Technology {
  const factory _Technology({required final String label, final String? url}) =
      _$TechnologyImpl;

  factory _Technology.fromJson(Map<String, dynamic> json) =
      _$TechnologyImpl.fromJson;

  @override
  String get label;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$TechnologyImplCopyWith<_$TechnologyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get content => throw _privateConstructorUsedError;
  String? get endMsse => throw _privateConstructorUsedError;
  Experience get experience => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  ///this will link directly to our project that uses this skill!
  List<String>? get projectIds => throw _privateConstructorUsedError;
  List<Skill>? get skills => throw _privateConstructorUsedError;
  String? get startMsse => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call(
      {String content,
      String? endMsse,
      Experience experience,
      String name,
      List<String>? projectIds,
      List<Skill>? skills,
      String? startMsse,
      List<String>? tags,
      String? url});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? endMsse = freezed,
    Object? experience = null,
    Object? name = null,
    Object? projectIds = freezed,
    Object? skills = freezed,
    Object? startMsse = freezed,
    Object? tags = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: freezed == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as Experience,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      projectIds: freezed == projectIds
          ? _value.projectIds
          : projectIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>?,
      startMsse: freezed == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
          _$SkillImpl value, $Res Function(_$SkillImpl) then) =
      __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String content,
      String? endMsse,
      Experience experience,
      String name,
      List<String>? projectIds,
      List<Skill>? skills,
      String? startMsse,
      List<String>? tags,
      String? url});
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
      _$SkillImpl _value, $Res Function(_$SkillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? endMsse = freezed,
    Object? experience = null,
    Object? name = null,
    Object? projectIds = freezed,
    Object? skills = freezed,
    Object? startMsse = freezed,
    Object? tags = freezed,
    Object? url = freezed,
  }) {
    return _then(_$SkillImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: freezed == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as Experience,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      projectIds: freezed == projectIds
          ? _value._projectIds
          : projectIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>?,
      startMsse: freezed == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl(
      {required this.content,
      this.endMsse,
      required this.experience,
      required this.name,
      final List<String>? projectIds,
      final List<Skill>? skills,
      this.startMsse,
      final List<String>? tags,
      this.url})
      : _projectIds = projectIds,
        _skills = skills,
        _tags = tags;

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String content;
  @override
  final String? endMsse;
  @override
  final Experience experience;
  @override
  final String name;

  ///this will link directly to our project that uses this skill!
  final List<String>? _projectIds;

  ///this will link directly to our project that uses this skill!
  @override
  List<String>? get projectIds {
    final value = _projectIds;
    if (value == null) return null;
    if (_projectIds is EqualUnmodifiableListView) return _projectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Skill>? _skills;
  @override
  List<Skill>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? startMsse;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? url;

  @override
  String toString() {
    return 'Skill(content: $content, endMsse: $endMsse, experience: $experience, name: $name, projectIds: $projectIds, skills: $skills, startMsse: $startMsse, tags: $tags, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.endMsse, endMsse) || other.endMsse == endMsse) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._projectIds, _projectIds) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.startMsse, startMsse) ||
                other.startMsse == startMsse) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      content,
      endMsse,
      experience,
      name,
      const DeepCollectionEquality().hash(_projectIds),
      const DeepCollectionEquality().hash(_skills),
      startMsse,
      const DeepCollectionEquality().hash(_tags),
      url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(
      this,
    );
  }
}

abstract class _Skill implements Skill {
  const factory _Skill(
      {required final String content,
      final String? endMsse,
      required final Experience experience,
      required final String name,
      final List<String>? projectIds,
      final List<Skill>? skills,
      final String? startMsse,
      final List<String>? tags,
      final String? url}) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get content;
  @override
  String? get endMsse;
  @override
  Experience get experience;
  @override
  String get name;
  @override

  ///this will link directly to our project that uses this skill!
  List<String>? get projectIds;
  @override
  List<Skill>? get skills;
  @override
  String? get startMsse;
  @override
  List<String>? get tags;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) {
  return _WorkExperience.fromJson(json);
}

/// @nodoc
mixin _$WorkExperience {
  String get companyName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get endMsse => throw _privateConstructorUsedError;
  String get iconAssetPath => throw _privateConstructorUsedError;
  List<String> get lessons => throw _privateConstructorUsedError;
  int get startMsse => throw _privateConstructorUsedError;
  List<String> get technologies => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkExperienceCopyWith<WorkExperience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkExperienceCopyWith<$Res> {
  factory $WorkExperienceCopyWith(
          WorkExperience value, $Res Function(WorkExperience) then) =
      _$WorkExperienceCopyWithImpl<$Res, WorkExperience>;
  @useResult
  $Res call(
      {String companyName,
      String content,
      int endMsse,
      String iconAssetPath,
      List<String> lessons,
      int startMsse,
      List<String> technologies,
      String title,
      String? url});
}

/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res, $Val extends WorkExperience>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? content = null,
    Object? endMsse = null,
    Object? iconAssetPath = null,
    Object? lessons = null,
    Object? startMsse = null,
    Object? technologies = null,
    Object? title = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: null == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as int,
      iconAssetPath: null == iconAssetPath
          ? _value.iconAssetPath
          : iconAssetPath // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startMsse: null == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as int,
      technologies: null == technologies
          ? _value.technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkExperienceImplCopyWith<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  factory _$$WorkExperienceImplCopyWith(_$WorkExperienceImpl value,
          $Res Function(_$WorkExperienceImpl) then) =
      __$$WorkExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String companyName,
      String content,
      int endMsse,
      String iconAssetPath,
      List<String> lessons,
      int startMsse,
      List<String> technologies,
      String title,
      String? url});
}

/// @nodoc
class __$$WorkExperienceImplCopyWithImpl<$Res>
    extends _$WorkExperienceCopyWithImpl<$Res, _$WorkExperienceImpl>
    implements _$$WorkExperienceImplCopyWith<$Res> {
  __$$WorkExperienceImplCopyWithImpl(
      _$WorkExperienceImpl _value, $Res Function(_$WorkExperienceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? content = null,
    Object? endMsse = null,
    Object? iconAssetPath = null,
    Object? lessons = null,
    Object? startMsse = null,
    Object? technologies = null,
    Object? title = null,
    Object? url = freezed,
  }) {
    return _then(_$WorkExperienceImpl(
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      endMsse: null == endMsse
          ? _value.endMsse
          : endMsse // ignore: cast_nullable_to_non_nullable
              as int,
      iconAssetPath: null == iconAssetPath
          ? _value.iconAssetPath
          : iconAssetPath // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startMsse: null == startMsse
          ? _value.startMsse
          : startMsse // ignore: cast_nullable_to_non_nullable
              as int,
      technologies: null == technologies
          ? _value._technologies
          : technologies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkExperienceImpl implements _WorkExperience {
  const _$WorkExperienceImpl(
      {required this.companyName,
      required this.content,
      required this.endMsse,
      required this.iconAssetPath,
      required final List<String> lessons,
      required this.startMsse,
      required final List<String> technologies,
      required this.title,
      this.url})
      : _lessons = lessons,
        _technologies = technologies;

  factory _$WorkExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkExperienceImplFromJson(json);

  @override
  final String companyName;
  @override
  final String content;
  @override
  final int endMsse;
  @override
  final String iconAssetPath;
  final List<String> _lessons;
  @override
  List<String> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  @override
  final int startMsse;
  final List<String> _technologies;
  @override
  List<String> get technologies {
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologies);
  }

  @override
  final String title;
  @override
  final String? url;

  @override
  String toString() {
    return 'WorkExperience(companyName: $companyName, content: $content, endMsse: $endMsse, iconAssetPath: $iconAssetPath, lessons: $lessons, startMsse: $startMsse, technologies: $technologies, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkExperienceImpl &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.endMsse, endMsse) || other.endMsse == endMsse) &&
            (identical(other.iconAssetPath, iconAssetPath) ||
                other.iconAssetPath == iconAssetPath) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons) &&
            (identical(other.startMsse, startMsse) ||
                other.startMsse == startMsse) &&
            const DeepCollectionEquality()
                .equals(other._technologies, _technologies) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      companyName,
      content,
      endMsse,
      iconAssetPath,
      const DeepCollectionEquality().hash(_lessons),
      startMsse,
      const DeepCollectionEquality().hash(_technologies),
      title,
      url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      __$$WorkExperienceImplCopyWithImpl<_$WorkExperienceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkExperienceImplToJson(
      this,
    );
  }
}

abstract class _WorkExperience implements WorkExperience {
  const factory _WorkExperience(
      {required final String companyName,
      required final String content,
      required final int endMsse,
      required final String iconAssetPath,
      required final List<String> lessons,
      required final int startMsse,
      required final List<String> technologies,
      required final String title,
      final String? url}) = _$WorkExperienceImpl;

  factory _WorkExperience.fromJson(Map<String, dynamic> json) =
      _$WorkExperienceImpl.fromJson;

  @override
  String get companyName;
  @override
  String get content;
  @override
  int get endMsse;
  @override
  String get iconAssetPath;
  @override
  List<String> get lessons;
  @override
  int get startMsse;
  @override
  List<String> get technologies;
  @override
  String get title;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
