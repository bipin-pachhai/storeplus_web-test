// @dart=2.9
import 'package:flutter/material.dart';
import 'package:data_mapping/screens/upload_document.dart';
import 'package:data_mapping/screens/table_view.dart';
//
//import 'package:data_mapping/screens/upload_images.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Mapping',
      debugShowCheckedModeBanner: false,
      home: UploadDocumentScreen(),
      // home: TableView(),
    );
  }
}
