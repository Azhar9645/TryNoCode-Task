part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoadingState extends ProjectState {}

class ProjectLoadedState extends ProjectState {
  final List<ProjectModel> myProjects;
  final List<OtherProjectModel> otherProjects;
  final bool hasMore;

  ProjectLoadedState({
    required this.myProjects,
    required this.otherProjects,
    required this.hasMore,
  });
}

class ProjectOfflineState extends ProjectState {
  final List<ProjectModel> myProjects;
  final List<OtherProjectModel> otherProjects;
  final bool hasMore;

  ProjectOfflineState({
    required this.myProjects,
    required this.otherProjects,
    required this.hasMore,
  });
}


final class ProjectErrorState extends ProjectState {
  final String message;
  ProjectErrorState(this.message);
}
