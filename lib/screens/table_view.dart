// @dart=2.9
import 'dart:collection';

import 'package:flutter/material.dart';

class TableView extends StatefulWidget {
  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  HashMap dropdownMap = new HashMap<int, String>();
  //String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Table Mappping Test'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(2),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(300.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Column(children: [
                      DropdownButton<String>(
                          value: dropdownMap[0],
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'Category',
                            'ProductID',
                            'SPN',
                            'Barcode_Number',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Select a Field",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              dropdownMap[0] = value;
                            });
                          })
                    ]),
                    Column(children: [
                      DropdownButton<String>(
                          value: dropdownMap[1],
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'Category',
                            'ProductID',
                            'SPN',
                            'Barcode_Number',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Select a Field",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              dropdownMap[1] = value;
                            });
                          })
                    ]),
                    Column(children: [
                      DropdownButton<String>(
                          value: dropdownMap[2],
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'Category',
                            'ProductID',
                            'SPN',
                            'Barcode_Number',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Select a Field",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              //   print(dropdownMap[0]);
                              dropdownMap[2] = value;
                            });
                          })
                    ]),
                  ]),
                ],
              ),
            ),
            Container(
              //   margin: EdgeInsets.all(5),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(300.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Text('Website', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Tutorial', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Review', style: TextStyle(fontSize: 20.0))
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text(" " + dropdownMap[0].toString())]),
                    Column(children: [Text(" " + dropdownMap[1].toString())]),
                    Column(children: [Text(" " + dropdownMap[2].toString())]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('MySQL')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('ReactJS')]),
                    Column(children: [Text('5*')]),
                  ]),
                ],
              ),
            ),
          ]))),
    );
  }
}
