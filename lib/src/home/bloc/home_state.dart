part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.uninitialized() = _Uninitialized;
  const factory HomeState.loaded({required AppData data}) = _Loaded;
}
