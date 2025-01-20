import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trynocode_assignment/bloc/project_bloc.dart';
import 'package:trynocode_assignment/screens/widgets/my_project/my_project_header.dart';
import 'package:trynocode_assignment/screens/widgets/other_project/other_project_card.dart';
import 'package:trynocode_assignment/screens/widgets/shimmer_card.dart';
import '../widgets/my_project/app_bar.dart';
import '../widgets/my_project/project_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(FetchMyProjectsEvent());
    context.read<ProjectBloc>().add(FetchOtherProjectsEvent(page: _currentPage, limit: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _currentPage = 1; // Reset page number on refresh
          context.read<ProjectBloc>().add(FetchOtherProjectsEvent(page: _currentPage, limit: 5));
        },
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoadingState) {
              return const Center(child: ShimmerCard());
            } else if (state is ProjectErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProjectLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyProject(),
                    if (state.myProjects.isNotEmpty)
                      MainProjectCard(project: state.myProjects[0])
                    else
                      const Center(child: Text('No projects found')),
                
                    const SizedBox(height: 16),
                
                    // Other Projects Section
                    if (state.otherProjects.isNotEmpty)
                      Column(
                        children: state.otherProjects.map((project) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: OtherProjectCard(project: project),
                          );
                        }).toList(),
                      )
                    else
                      const Center(child: Text('No other projects found')),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
