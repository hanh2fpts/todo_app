import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/home_cubit/home_cubit.dart';
import 'package:todo/screens/tablet/setting_page_tl.dart';
import 'package:todo/screens/tablet/status_page_tl.dart';

import 'overview_page_tl.dart';

class MyHomePageTl extends StatefulWidget {
  const MyHomePageTl({super.key});

  @override
  State<MyHomePageTl> createState() => _MyHomePageTlState();
}

class _MyHomePageTlState extends State<MyHomePageTl> {
  final List<Widget> pages = const [OverviewPageTl(), StatusPageTl(), SettingPageTl()];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              NavigationDrawer(
                elevation: 0.5,
                onDestinationSelected: (value) => context.read<HomeCubit>().selectTab(value),
                selectedIndex: state,
                children: const [
                  SizedBox(height: 50),
                  NavigationDrawerDestination(
                    icon: Icon(CupertinoIcons.list_bullet),
                    label: Text('Todos'),
                  ),
                  NavigationDrawerDestination(
                    icon: Icon(Icons.show_chart),
                    label: Text('Status'),
                  ),
                  NavigationDrawerDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Setting'),
                  )
                ],
              ),
              const VerticalDivider(
                thickness: 1,
                width: 1,
              ),
              Expanded(child: IndexedStack(index: state, children: pages))
            ],
          ),
        );
      },
    );
  }
}
