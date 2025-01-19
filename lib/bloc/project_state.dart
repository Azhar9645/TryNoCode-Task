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

// class MyProjectSuccessState extends ProjectState {
//   final List<ProjectModel> projects;
//   MyProjectSuccessState(this.projects);
  
// }

// class OtherProjectSuccessState extends ProjectState {
//   final List<OtherProjectModel> projects;
//   final bool hasMore;
//   final int currentPage;

//   OtherProjectSuccessState(
//     this.projects, {
//     required this.hasMore,
//     required this.currentPage,
//   });
// }

final class ProjectErrorState extends ProjectState {
  final String message;
  ProjectErrorState(this.message);
}
