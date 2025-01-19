import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

part 'project_event.dart';
part 'project_state.dart';

// class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
//   final ProjectService _projectService;
  

//   int _currentPage = 1;
//   static const int _pageLimit = 5;
//   bool _hasMore = true;

//   List<ProjectModel> _myProjects = [];
//   List<OtherProjectModel> _otherProjects = [];

//   ProjectBloc(this._projectService) : super(ProjectInitial()) {
//     on<FetchMyProjectsEvent>(_onFetchMyProjects);
//     on<FetchOtherProjectsEvent>(_onFetchOtherProjects);
//   }

//   Future<void> _onFetchMyProjects(
//     FetchMyProjectsEvent event,
//     Emitter<ProjectState> emit,
//   ) async {
//     try {
//       emit(ProjectLoadingState());
//       _myProjects = await _projectService.fetchMyProjects();
//       emit(ProjectLoadedState(
//         myProjects: _myProjects,
//         otherProjects: _otherProjects,
//         hasMore: _hasMore,
//       ));
//     } catch (e) {
//       emit(ProjectErrorState(e.toString()));
//     }
//   }

//   Future<void> _onFetchOtherProjects(
//     FetchOtherProjectsEvent event,
//     Emitter<ProjectState> emit,
//   ) async {
//     try {
//       if (!_hasMore) return;

//       final response = await _projectService.fetchOtherProjects(
//         page: _currentPage,
//         limit: _pageLimit,
//       );

//       if (response.isEmpty) {
//         _hasMore = false;
//       } else {
//         _currentPage++;
//         _otherProjects = [..._otherProjects, ...response];
//       }

//       emit(ProjectLoadedState(
//         myProjects: _myProjects,
//         otherProjects: _otherProjects,
//         hasMore: _hasMore,
//       ));
//     } catch (e) {
//       emit(ProjectErrorState(e.toString()));
//     }
//   }
// }

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectService _projectService;
  final ConnectivityService _connectivityService;
  final Box _projectBox;

  int _currentPage = 1;
  static const int _pageLimit = 5;
  bool _hasMore = true;

  List<ProjectModel> _myProjects = [];
  List<OtherProjectModel> _otherProjects = [];

  ProjectBloc(this._projectService, this._connectivityService, this._projectBox) 
      : super(ProjectInitial()) {
    on<FetchMyProjectsEvent>(_onFetchMyProjects);
    on<FetchOtherProjectsEvent>(_onFetchOtherProjects);
  }

  Future<void> _onFetchMyProjects(
    FetchMyProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      emit(ProjectLoadingState());

      bool isOnline = await _connectivityService.isOnline;
      if (isOnline) {
        _myProjects = await _projectService.fetchMyProjects();
        // Save fetched projects to Hive
        _projectBox.put('myProjects', _myProjects);
      } else {
        // Load from Hive if offline
        _myProjects = _projectBox.get('myProjects', defaultValue: []);
      }

      emit(ProjectLoadedState(
        myProjects: _myProjects,
        otherProjects: _otherProjects,
        hasMore: _hasMore,
      ));
    } catch (e) {
      emit(ProjectErrorState(e.toString()));
    }
  }

  Future<void> _onFetchOtherProjects(
    FetchOtherProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      if (!_hasMore) return;

      bool isOnline = await _connectivityService.isOnline;
      List<OtherProjectModel> response;

      if (isOnline) {
        response = await _projectService.fetchOtherProjects(
          page: _currentPage,
          limit: _pageLimit,
        );
        // Save fetched other projects to Hive
        _projectBox.put('otherProjects', response);
      } else {
        // Load from Hive if offline
        response = _projectBox.get('otherProjects', defaultValue: []);
      }

      if (response.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage++;
        _otherProjects = [..._otherProjects, ...response];
      }

      emit(ProjectLoadedState(
        myProjects: _myProjects,
        otherProjects: _otherProjects,
        hasMore: _hasMore,
      ));
    } catch (e) {
      emit(ProjectErrorState(e.toString()));
    }
  }
}
