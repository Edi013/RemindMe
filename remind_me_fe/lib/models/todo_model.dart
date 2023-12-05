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

  int? get getId => id;
  String get getTitle => title;
  String get getDescription => description;
  DateTime get getCreationDate => creationDate;
  DateTime get getStartDate => startDate;
  DateTime? get getEndDate => endDate;
  bool get getIsFinished => isFinished;
  int get getDifficulty => difficulty;
  int get getOwnerId => ownerId;

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
    creationDate = DateTime.now();
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['Id'] as int,
      title: json['Title'] as String,
      description: json['Description'] as String,
      creationDate: json['CreationDate'] as DateTime,
      startDate: json['StartDate'] as DateTime,
      endDate: json['EndDate'] ? json['EndDate'] as DateTime : null,
      difficulty: json['Difficulty'],
      isFinished: json['IsFinished'] as bool,
      ownerId: json['OwnerId'] as int,
    );
  }
}
