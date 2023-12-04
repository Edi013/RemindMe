class ToDo {
  int? id;
  String title;
  String description;
  DateTime creationDate;
  DateTime startDate;
  DateTime? endDate;
  bool isFinished;
  int difficulty;
  int ownerId;

  ToDo({
    this.id,
    this.title = "",
    this.description = "",
    required this.creationDate,
    required this.startDate,
    this.endDate,
    this.isFinished = false,
    required this.difficulty,
    required this.ownerId,
  }) {
    this.creationDate = DateTime.now();
  }

  int? get getId => id;
  String get getTitle => title;
  String get getDescription => description;
  DateTime get getCreationDate => creationDate;
  DateTime get getStartDate => startDate;
  DateTime? get getEndDate => endDate;
  bool get getIsFinished => isFinished;
  int get getDifficulty => difficulty;
  int get getOwnerId => ownerId;
}
