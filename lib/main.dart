import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/observer.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = TodoObserver();
  runApp(const MyApp());
}
