class TodoModel {
  String id;
  String title;
  String description;
  bool isCompleted = false;
  TodoModel({
    required this.title,
    required this.id,
    required this.description,
    this.isCompleted = false,
  });
}
