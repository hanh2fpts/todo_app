part of 'overview_cubit.dart';

enum OverviewStatus {
  loading,
  success,
}

final class OverviewState {
  final OverviewStatus status;
  final List<TodoModel> listTodos;
  const OverviewState({required this.status, required this.listTodos});
}
