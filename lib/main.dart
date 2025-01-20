import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trynocode_assignment/bloc/project_bloc.dart';
import 'package:trynocode_assignment/data/database_helper.dart';
import 'package:trynocode_assignment/screens/home%20screen/home_screen.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final projectService = ProjectService();
  final connectivityService = ConnectivityService();
  final databaseHelper = DatabaseHelper(); 

  runApp(MyApp(
    projectService: projectService,
    connectivityService: connectivityService,
    databaseHelper: databaseHelper,
  ));
}

class MyApp extends StatelessWidget {
  final ProjectService projectService;
  final ConnectivityService connectivityService;
    final DatabaseHelper databaseHelper;


  const MyApp({
    super.key,
    required this.projectService,
    required this.connectivityService,
     required this.databaseHelper,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(
        projectService,
        connectivityService,
        databaseHelper, 
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
