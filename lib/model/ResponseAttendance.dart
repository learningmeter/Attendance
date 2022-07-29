class ResponseAttendance {
  int? code;
  String? appMessage;
  String? userMessage;
  Data? data;

  ResponseAttendance({this.code, this.appMessage, this.userMessage, this.data});

  ResponseAttendance.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    appMessage = json['app_message'];
    userMessage = json['user_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['app_message'] = this.appMessage;
    data['user_message'] = this.userMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? uid;
  String? latitude;
  String? longitude;
  String? requestId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.name,
        this.uid,
        this.latitude,
        this.longitude,
        this.requestId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    requestId = json['request_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['request_id'] = this.requestId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}