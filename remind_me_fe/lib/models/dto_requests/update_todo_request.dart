class UpdateToDoRequest {
  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime? endDate;
  bool isFinished;
  int difficulty;
  int ownerId;

  UpdateToDoRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.isFinished,
    required this.difficulty,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isFinished': isFinished,
      'difficulty': difficulty,
      'ownerId': ownerId,
    };
  }
}
