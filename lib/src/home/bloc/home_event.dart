part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.reset() = _Reset;
  const factory HomeEvent.started({bool? reset}) = _Started;
  const factory HomeEvent.updateModel({required AppData data}) = _UpdateModel;
}
