part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

class FetchMyProjectsEvent extends ProjectEvent {}

class FetchOtherProjectsEvent extends ProjectEvent {
  final int page;
  final int limit;

  FetchOtherProjectsEvent({
    required this.page,
    required this.limit,
  });
}
