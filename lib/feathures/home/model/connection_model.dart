class Connections {
  String? sId;
  String? userId;
  String? companyId;
  String? reason;
  String? status;
  String? subject;
  String? message;
  String? email;
  String? linkedinurl;
  String? date;
  int? iV;

  Connections(
      {this.sId,
      this.userId,
      this.companyId,
      this.reason,
      this.status,
      this.subject,
      this.message,
      this.email,
      this.linkedinurl,
      this.date,
      this.iV});

  Connections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    companyId = json['companyId'];
    reason = json['reason'];
    status = json['status'];
    subject = json['subject'];
    message = json['message'];
    email = json['email'];
    linkedinurl = json['linkedinurl'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['companyId'] = companyId;
    data['reason'] = reason;
    data['status'] = status;
    data['subject'] = subject;
    data['message'] = message;
    data['email'] = email;
    data['linkedinurl'] = linkedinurl;
    data['date'] = date;
    data['__v'] = iV;
    return data;
  }
}
