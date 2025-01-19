import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

part 'project_event.dart';
part 'project_state.dart';

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
      print('Fetching My Projects...');
      emit(ProjectLoadingState());

      bool isOnline = await _connectivityService.isOnline;
      print('Is online: $isOnline');

      if (isOnline) {
        print('Fetching from server...');
        _myProjects = await _projectService.fetchMyProjects();
        print('Fetched ${_myProjects.length} projects from server');
        // Save fetched projects to Hive
        _projectBox.put('myProjects', _myProjects);
        print('Saved myProjects to Hive');
      } else {
        print('Loading from Hive...');
        _myProjects = _projectBox.get('myProjects', defaultValue: []);
        print('Loaded ${_myProjects.length} projects from Hive');
      }

      emit(ProjectLoadedState(
        myProjects: _myProjects,
        otherProjects: _otherProjects,
        hasMore: _hasMore,
      ));
    } catch (e) {
      print('Error fetching My Projects: $e');
      emit(ProjectErrorState(e.toString()));
    }
  }

  // Future<void> _onFetchOtherProjects(
  //   FetchOtherProjectsEvent event,
  //   Emitter<ProjectState> emit,
  // ) async {
  //   try {
  //     if (!_hasMore) {
  //       print('No more projects to fetch.');
  //       return;
  //     }

  //     print('Fetching Other Projects...');
  //     bool isOnline = await _connectivityService.isOnline;
  //     print('Is online: $isOnline');

  //     List<OtherProjectModel> response;

  //     if (isOnline) {
  //       print(
  //           'Fetching from server (page: $_currentPage, limit: $_pageLimit)...');
  //       response = await _projectService.fetchOtherProjects(
  //         page: _currentPage,
  //         limit: _pageLimit,
  //       );
  //       print('Fetched ${response.length} projects from server');
  //       // Save fetched other projects to Hive
  //       _projectBox.put('otherProjects', response);
  //       print('Saved otherProjects to Hive');
  //       // Log the saved data
  //       final otherProjects = _projectBox.get('otherProjects');
  //       print('Other Projects: $otherProjects'); // Log the data to the terminal

  //       // You can also log individual project details for more granularity:
  //       response.forEach((project) {
  //         print('Project: ${project.projectName}');
  //       });
  //     } else {
  //       print('Loading from Hive...');
  //       response = _projectBox.get('otherProjects', defaultValue: []);
  //       print('Loaded ${response.length} projects from Hive');
  //     }

  //     if (response.isEmpty) {
  //       print('No more projects found');
  //       _hasMore = false;
  //     } else {
  //       print('Adding new projects to the list');
  //       _currentPage++;
  //       _otherProjects = [..._otherProjects, ...response];
  //     }

  //     emit(ProjectLoadedState(
  //       myProjects: _myProjects,
  //       otherProjects: _otherProjects,
  //       hasMore: _hasMore,
  //     ));
  //   } catch (e) {
  //     print('Error fetching Other Projects: $e');
  //     emit(ProjectErrorState(e.toString()));
  //   }
  // }

  Future<void> _onFetchOtherProjects(
  FetchOtherProjectsEvent event,
  Emitter<ProjectState> emit,
) async {
  try {
    if (!_hasMore) return;

    // Check if the device is online before making the network request
    bool isOnline = await _connectivityService.isOnline;

    if (isOnline) {
      // Fetch from the server if online
      List<OtherProjectModel> response = await _projectService.fetchOtherProjects(
        page: _currentPage,
        limit: _pageLimit,
      );
      print('Fetched other projects from server');
      // Save fetched data to Hive
      _projectBox.put('otherProjects', response);
      print('Saved other projects to Hive');
      
      if (response.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage++;
        _otherProjects = [..._otherProjects, ...response];
      }
    } else {
      // Load from Hive if offline
      List<OtherProjectModel> response = _projectBox.get('otherProjects', defaultValue: []);
      print('Loaded other projects from local storage');
      
      if (response.isEmpty) {
        // Handle empty data case if needed
        print('No projects available in local storage');
      } else {
        _otherProjects = response;
      }
    }

    // Emit loaded state
    emit(ProjectLoadedState(
      myProjects: _myProjects,
      otherProjects: _otherProjects,
      hasMore: _hasMore,
    ));
  } catch (e) {
    // Handle any unexpected errors
    emit(ProjectErrorState(e.toString()));
  }
}

}
