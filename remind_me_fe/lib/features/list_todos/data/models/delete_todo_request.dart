class DeleteToDoRequest {
  int id;

  DeleteToDoRequest({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
