class LogsModel {
  String? date;
  String? email;
  String? type;
  int? timestamp;
  String? name;
  String? committee;
  String? markedBy;

  LogsModel({this.date, this.email, this.type, this.timestamp, this.name,this.markedBy});

  LogsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    email = json['email'];
    type = json['type'];
    timestamp = json['timestamp'];
    name = json['name'];
    markedBy = json['marked_by'] ?? "Self";
    committee = json['committee'] ?? "--";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['email'] = email;
    data['type'] = type;
    data['timestamp'] = timestamp;
    data['name'] = name;
    data['committee'] = committee;
    data['marked_by'] = markedBy;
    return data;
  }
}
