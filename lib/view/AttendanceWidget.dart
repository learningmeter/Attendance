import 'package:attendance/api/API.dart';
import 'package:attendance/model/Attendance.dart';
import 'package:attendance/model/ResponseAttendance.dart';
import 'package:attendance/model/Store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';


class AttendanceWidget extends StatefulWidget {
  final Store? store;
  AttendanceWidget({this.store});

  @override
  _AttendanceWidgetState createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {

  final _formKey = GlobalKey<FormState>();

  String formTitle = 'Attendance';

  DateTime selectedDate = DateTime.now();

  final nameController = TextEditingController();
  final uIdController = TextEditingController();


  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Attendance'),
      ),
      body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                              ],
                              decoration: InputDecoration(
                                labelText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                              textAlign: TextAlign.left,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              maxLines: 1,
                              minLines: 1,
                              controller: uIdController,
                              decoration: InputDecoration(
                                labelText: 'User Id',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                              textAlign: TextAlign.left,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter User Id';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.indigoAccent),
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            color: Colors.indigoAccent,
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                  LocationData loc = await getLocation();
                                  if(loc != null){
                                    showDialogSubmit(loc);
                                  }else{
                                    getLocation();
                                  }
                                }
                            },
                            child: Text('Submit',
                            style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  getData(LocationData loc) async {

    var uuid = Uuid();
    var v1 = uuid.v1();
    Attendance? attendance = Attendance();
    attendance.name = nameController.text;
    attendance.uid = uIdController.text;
    attendance.latitude = loc.latitude.toString();
    attendance.longitude = loc.longitude.toString();
    attendance.request_id = v1;

    return attendance;
  }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData = null;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  showDialogSubmit(LocationData loc) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text('Are you sure to submit $formTitle?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () async {
              sendAttendance(await getData(loc));

              Navigator.of(context).pop(false);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ));
  }

  showDialogSubmitStatus(ResponseAttendance responseAttendance) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text(responseAttendance.userMessage!, textAlign: TextAlign.center, style: TextStyle(color: Colors.green),),
        actions: <Widget>[
          MaterialButton(
            color: Colors.indigoAccent,
            minWidth: 50,
            height: 40,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Icon(Icons.check, color: Colors.white,),
          ),
        ],
      ),
    ));
  }

  sendAttendance(Attendance? cpa){
      API().sendData(cpa!).then((value) {
        showDialogSubmitStatus(value);
      }
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
