import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trynocode_assignment/bloc/project_bloc.dart';
import 'package:trynocode_assignment/models/project_model.dart';
import 'package:trynocode_assignment/screens/home%20screen/home_screen.dart';
import 'package:trynocode_assignment/service/project_service.dart';
import 'package:trynocode_assignment/utils/connectivity_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(OtherProjectModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());

  // Initialize Hive and open the project box
  await Hive.initFlutter();
  final Box projectBox = await Hive.openBox('projectBox');

  // Pass the projectBox directly to MyApp
  runApp(MyApp(projectBox: projectBox));
}

class MyApp extends StatelessWidget {
  final Box projectBox;
  const MyApp({super.key, required this.projectBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(
        ProjectService(),
        ConnectivityService(),
        projectBox, // Pass the projectBox directly to the Bloc
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor:
              const Color(0xFFF5F5F5), // Set background to off-white
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
