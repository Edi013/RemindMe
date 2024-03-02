class TodoEntity {
  int id;
  String title;
  String description;
  DateTime creationDate;
  DateTime startDate;
  DateTime endDate;
  bool isFinished;
  int difficulty;
  int ownerId;

  TodoEntity({
    required this.id,
    this.title = "",
    this.description = "",
    required this.creationDate,
    required this.startDate,
    required this.endDate,
    this.isFinished = false,
    required this.difficulty,
    required this.ownerId,
  }) {
    creationDate = DateTime.now();
  }

  // factory ToDo.fromJson(Map<String, dynamic> json) {
  //   return ToDo(
  //     id: json['id'] as int,
  //     title: json['title'] as String,
  //     description: json['description'] as String,
  //     creationDate:
  //         DateFormat(Constants.DATE_TIME_FORMAT).parse(json['creationDate']),
  //     startDate:
  //         DateFormat(Constants.DATE_TIME_FORMAT).parse(json['startDate']),
  //     endDate: json['endDate'] != ""
  //         ? DateFormat(Constants.DATE_TIME_FORMAT).parse(json['endDate'])
  //         : null,
  //     difficulty: json['difficulty'],
  //     isFinished: json['isFinished'] as bool,
  //     ownerId: json['ownerId'] as int,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'creationDate': creationDate.toIso8601String(),
  //     'startDate': startDate.toIso8601String(),
  //     'endDate': endDate?.toIso8601String(),
  //     'isFinished': isFinished,
  //     'difficulty': difficulty,
  //     'ownerId': ownerId,
  //   };
  // }
}
