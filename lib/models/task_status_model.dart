class TaskStatusModel {
  String? id;
  int? sum;

  TaskStatusModel({this.id, this.sum});

  TaskStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sum = json['sum'];
  }
}
