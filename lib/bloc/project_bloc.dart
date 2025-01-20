import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/service/database_service.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectService _projectService;
  final ConnectivityService _connectivityService;

  int _currentPage = 1;
  static const int _pageLimit = 5;
  bool _hasMore = true;

  List<ProjectModel> _myProjects = [];
  List<OtherProjectModel> _otherProjects = [];

  ProjectBloc(
    this._projectService,
    this._connectivityService,
  ) : super(ProjectInitial()) {
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
        try {
          _myProjects = await _projectService.fetchMyProjects();
        } catch (e) {
          print('Error fetching from API: $e');
          _myProjects = []; // Provide an empty fallback if API fails
        }
      } else {
        _myProjects = []; // No offline support without Hive
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

      if (isOnline) {
        final response = await _projectService.fetchOtherProjects(
          page: _currentPage,
          limit: _pageLimit,
        );

        if (response.isEmpty) {
          _hasMore = false;
        } else {
          _currentPage++;
          _otherProjects = [..._otherProjects, ...response];
        }
      } else {
        _hasMore = false; // No offline support without Hive
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


