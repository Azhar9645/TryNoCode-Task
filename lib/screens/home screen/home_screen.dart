import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trynocode_assignment/bloc/project_bloc.dart';
import 'package:trynocode_assignment/widgets/my_project/my_project_header.dart';
import 'package:trynocode_assignment/widgets/other_project/other_project_card.dart';
import 'package:trynocode_assignment/widgets/other_project/other_project_header.dart';
import 'package:trynocode_assignment/widgets/shimmer_card.dart';
import '../../widgets/my_project/app_bar.dart';
import '../../widgets/my_project/project_card.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             MyProject(),
//             MainProjectCard(),
//             SizedBox(height: 13),
//             OtherProject(),
//             OtherProjectCard(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProjectBloc>().add(FetchMyProjectsEvent());
    context.read<ProjectBloc>().add(FetchOtherProjectsEvent(page: 1, limit: 5));

    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProjectBloc>().add(FetchMyProjectsEvent());
          context
              .read<ProjectBloc>()
              .add(FetchOtherProjectsEvent(page: 1, limit: 5));
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.otherProjects.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: OtherProjectCard(
                                project: state.otherProjects[index]),
                          );
                        },
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
