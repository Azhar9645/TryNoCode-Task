import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:trynocode_assignment/data/database_helper.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/main_project.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectService _projectService;
  final ConnectivityService _connectivityService;
  final DatabaseHelper _databaseHelper;

  int _currentPage = 1;
  static const int _pageLimit = 5;
  bool _hasMore = true;

  List<ProjectModel> _myProjects = [];
  List<OtherProjectModel> _otherProjects = [];

  ProjectBloc(
    this._projectService,
    this._connectivityService,
    this._databaseHelper,
  ) : super(ProjectInitial()) {
    on<FetchMyProjectsEvent>(_onFetchMyProjects);
    on<FetchOtherProjectsEvent>(_onFetchOtherProjects);
  }

  Future<void> _onFetchMyProjects(
    FetchMyProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      print("Fetching MyProjects...");
      emit(ProjectLoadingState());
      bool isOnline = await _connectivityService.isOnline;
      print("Is online: $isOnline");

      if (isOnline) {
        try {
          // Fetch data from API
          print("Fetching MyProjects from API...");
          _myProjects = await _projectService.fetchMyProjects();
          print("Fetched ${_myProjects.length} MyProjects from API.");
          // Save to SQLite for offline access
          for (var project in _myProjects) {
            await _databaseHelper.insertMyProject(project);
          }
          print("MyProjects saved to local database.");
        } catch (e) {
          print('Error fetching from API: $e');
          _myProjects = [];
        }
      } else {
        // Fetch data from SQLite if offline
        print("Fetching MyProjects from local database...");
        _myProjects = await _databaseHelper.getMyProjects();
        print("Fetched ${_myProjects.length} MyProjects from local database.");
      }

      emit(ProjectLoadedState(
        myProjects: _myProjects,
        otherProjects: _otherProjects,
        hasMore: _hasMore,
      ));
    } catch (e) {
      print("Error: $e");
      emit(ProjectErrorState(e.toString()));
    }
  }

  Future<void> _onFetchOtherProjects(
    FetchOtherProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      print("Fetching OtherProjects...");
      if (!_hasMore) return;

      bool isOnline = await _connectivityService.isOnline;
      print("Is online: $isOnline");

      if (isOnline) {
        // Fetch data from API
        print("Fetching OtherProjects from API...");
        final response = await _projectService.fetchOtherProjects(
          page: _currentPage,
          limit: _pageLimit,
        );
        print("Fetched ${response.length} OtherProjects from API.");

        if (response.isEmpty) {
          _hasMore = false;
          print("No more projects to fetch.");
        } else {
          _currentPage++;
          _otherProjects = [..._otherProjects, ...response];
          // Save to SQLite for offline access
          for (var project in response) {
            await _databaseHelper.insertOtherProject(project);
          }
          print("OtherProjects saved to local database.");
        }
      } else {
        // Fetch data from SQLite if offline
        print("Fetching OtherProjects from local database...");
        _otherProjects = await _databaseHelper.getOtherProjects();
        print(
            "Fetched ${_otherProjects.length} OtherProjects from local database.");
      }

      emit(ProjectLoadedState(
        myProjects: _myProjects,
        otherProjects: _otherProjects,
        hasMore: _hasMore,
      ));
    } catch (e) {
      print("Error: $e");
      emit(ProjectErrorState(e.toString()));
    }
  }
}
