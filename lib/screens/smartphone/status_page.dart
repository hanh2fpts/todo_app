import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/status_cubit/status_cubit.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StatusCubit, StatusState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.check_rounded),
                title: const Text('Complete Todo'),
                trailing: Text(
                  '${state.complete}',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.radio_button_unchecked_rounded),
                title: const Text('Active Todo'),
                trailing: Text(
                  '${state.active}',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
