class Attendance{
  String? name;
  String? uid;
  String? latitude;
  String? longitude;
  String? request_id;

  Attendance({this.name, this.uid, this.latitude, this.longitude, this.request_id});

  Attendance.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    request_id = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['request_id'] = this.request_id;
    return data;
  }
}