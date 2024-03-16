class TodoEntity {
  int id;
  String title;
  String description;
  DateTime? creationDate;
  DateTime startDate;
  DateTime endDate;
  bool isFinished;
  int difficulty;
  String ownerId;

  TodoEntity({
    required this.id,
    this.title = "",
    this.description = "",
    required this.startDate,
    required this.endDate,
    this.isFinished = false,
    required this.difficulty,
    required this.ownerId,
  }) {
    if (this.creationDate == null) {
      this.creationDate = DateTime.now();
    }
  }
  TodoEntity.fromExistent({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.startDate,
    required this.endDate,
    required this.isFinished,
    required this.difficulty,
    required this.ownerId,
  });
}
