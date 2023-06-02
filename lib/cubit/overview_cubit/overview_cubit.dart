import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/model/todo_model.dart';

part 'overview_state.dart';

class OverviewCubit extends Cubit<OverviewState> {
  List<TodoModel> listTodos = List.generate(9,
      (index) => TodoModel(title: 'title $index', id: '$index', description: 'description $index'),
      growable: true);
  OverviewCubit() : super(const OverviewState(status: OverviewStatus.loading, listTodos: []));
  void initData() async {
    emit(const OverviewState(status: OverviewStatus.loading, listTodos: []));
    await Future.delayed(const Duration(seconds: 5));
    emit(OverviewState(status: OverviewStatus.success, listTodos: listTodos));
  }

  void addTodo(TodoModel model) {
    listTodos.add(model);
    emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
  }

  void makeTaskCompleted(String idTask) {
    var todoItem = listTodos.firstWhere((element) => idTask == element.id);
    todoItem.isCompleted = !todoItem.isCompleted;
    emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
  }

  void deleteTask(TodoModel item) {
    var copyList = List.from(listTodos);
    for (var element in copyList) {
      if (element == item) {
        listTodos.remove(element);
      }
    }
    emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
  }

  void modifierTask(TodoModel todoModel) {
    var id = todoModel.id;
    var item = listTodos.firstWhere((element) => id == element.id);
    item.title = todoModel.title;
    item.description = todoModel.description;
    emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
  }

  void filterList(int type) {
    List<TodoModel> tempList = [];
    switch (type) {
      case 0:
        emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
        break;
      case 1:
        for (var element in listTodos) {
          if (element.isCompleted == false) {
            tempList.add(element);
          }
        }
        emit(OverviewState(listTodos: tempList, status: OverviewStatus.success));
        break;
      case 2:
        for (var element in listTodos) {
          if (element.isCompleted == true) {
            tempList.add(element);
          }
        }
        emit(OverviewState(listTodos: tempList, status: OverviewStatus.success));
        break;
      case 3:
        for (var element in listTodos) {
          element.isCompleted = false;
        }
        emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
        break;
      case 4:
        var copyList = List.from(listTodos);
        for (var element in copyList) {
          if (element.isCompleted == true) {
            listTodos.remove(element);
          }
        }
        emit(OverviewState(listTodos: listTodos, status: OverviewStatus.success));
        break;
    }
  }
}
