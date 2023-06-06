import 'package:flutter/material.dart';

class StatusPageTl extends StatelessWidget {
  const StatusPageTl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Status'),
      ),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}
