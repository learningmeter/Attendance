import 'dart:convert';
import 'dart:io';
import 'package:attendance/model/Attendance.dart';
import 'package:attendance/model/ResponseAttendance.dart';
import 'package:attendance/model/Store.dart';
import 'package:http/http.dart';

class API{
  String BASE_URL = 'http://128.199.215.102:4040';
  final String contentTypeJson = 'application/json; charset=UTF-8';
  final int statusOK = 200;


  Future<Store> fetchData() async {
    final response = await get(
        Uri.parse('$BASE_URL/api/stores'),
    );
    if (response.statusCode == statusOK) {
      return Store.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseAttendance> sendData(Attendance attendance) async {
    var url = '$BASE_URL/api/attendance';
    final Response response = await post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: contentTypeJson },
        body: jsonEncode(attendance.toJson()));
    if (response.statusCode == statusOK) {
      return ResponseAttendance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save data');
    }
  }
}