class CreateToDoRequest {
  String title;
  String description;
  DateTime creationDate = DateTime.now();
  DateTime startDate;
  DateTime? endDate;
  bool isFinished;
  int difficulty;
  int ownerId;

  CreateToDoRequest({
    required this.title,
    required this.description,
    required this.creationDate,
    required this.startDate,
    this.endDate,
    required this.isFinished,
    required this.difficulty,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isFinished': isFinished,
      'difficulty': difficulty,
      'ownerId': ownerId,
    };
  }
}
