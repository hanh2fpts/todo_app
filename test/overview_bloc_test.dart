import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/model/todo_model.dart';

void main() {
  blocTest<OverviewCubit, OverviewState>(
    'emits [MyState] when MyEvent is added.',
    build: () => OverviewCubit(),
    act: (bloc) => bloc.addTodo(TodoModel(title: 'title', id: 'id', description: 'description')),
    expect: () => [],
  );
}
