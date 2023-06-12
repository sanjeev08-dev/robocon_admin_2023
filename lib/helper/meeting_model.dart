class MeetingModel {
  String? agenda;
  String? date;

  MeetingModel({this.agenda, this.date});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    agenda = json['agenda'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agenda'] = agenda;
    data['date'] = date;
    return data;
  }
}
