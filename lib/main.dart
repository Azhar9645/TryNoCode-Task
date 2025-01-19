import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trynocode_assignment/bloc/project_bloc.dart';
import 'package:trynocode_assignment/screens/home%20screen/home_screen.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('projectBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final projectService = ProjectService();
    final connectivityService = ConnectivityService();
    final projectBox = Hive.box('projectBox'); 

    return BlocProvider(
      create: (context) =>
          ProjectBloc(projectService, connectivityService, projectBox)
            ..add(FetchMyProjectsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor:
              Color(0xFFF5F5F5), // Set the background to off-white
        ),
        home: HomeScreen(),
      ),
    );
  }
}
