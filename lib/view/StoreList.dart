import 'package:attendance/model/Store.dart';
import 'package:flutter/material.dart';

import 'AttendanceWidget.dart';


class StoreList extends StatefulWidget {
  final List<Data>? stores;

  StoreList(this.stores);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            children: widget.stores!.map((store) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceWidget()));
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Text(store.name!,
                          textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.indigo, fontSize: 20)
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                          child: Text(store.address!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            ),
          );
  }
  @override
  void dispose() {
    super.dispose();
  }
}