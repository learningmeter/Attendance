import 'package:attendance/view/StoreList.dart';
import 'package:flutter/material.dart';

import 'api/API.dart';
import 'model/Store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Attendance',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Online Attendance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Store> response;

  @override
  void initState() {
    super.initState();
    response = API().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Stores'),
      ),
      body: FutureBuilder<Store>(
        future: response,
        builder:  (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            List<Data>? list = snapshot.data!.data;

            if(list != null) {
              return StoreList(list);
            }else {
              return Container();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
