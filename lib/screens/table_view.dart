// @dart=2.9
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class TableView extends StatefulWidget {
  var itemsInfo;
  int maxCols;
  TableView(this.itemsInfo, this.maxCols);
  @override
  _TableViewState createState() => _TableViewState(itemsInfo, maxCols);
}

class _TableViewState extends State<TableView> {
  var itemsInfo;
  int maxCols;
  final int maxRows = 40;
  _TableViewState(this.itemsInfo, this.maxCols);
  HashMap dropdownMap = new HashMap<int, String>();
  List<String> dropdownItems = [
    "Category",
    "ProductId",
    "Supplier",
    "BarCode",
    "OrderNumber",
    "Price"
  ];
  //String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Table Mappping Test'),
            leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(2),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(250.0),
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    TableRow(
                        children: List.generate(
                      maxCols,
                      (index) => Container(
                          decoration: BoxDecoration(
                            color: HexColor("F1F3F5"),
                            border: Border.all(color: HexColor("F1F3F5")),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(children: [
                            DropdownButton<String>(
                                isExpanded: false,
                                menuMaxHeight:
                                    MediaQuery.of(context).size.height / 2,
                                value: dropdownMap[index.toString()],
                                style: TextStyle(
                                    color: HexColor("171819"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                dropdownColor: HexColor("F1F3F5"),
                                //elevation: 5,

                                //TO DO: Creating Mapping data options on Firebase
                                //TO DO: Create
                                items: dropdownItems
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.trim()),
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
                                    dropdownMap[index.toString()] = value;
                                    // dropdownItemSelected[index] = true;
                                  });
                                })
                          ])),
                    ))
                  ],
                ),
              ),
              Container(
                //   margin: EdgeInsets.all(5),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(250.0),
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 1),
                  children: List.generate(
                      maxRows,
                      (index) => TableRow(children: [
                            Column(children: [
                              Text("" + itemsInfo[index][0].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][1].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][2].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][3].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][4].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][5].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][6].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][7].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][8].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][9].toString())
                            ]),
                            Column(children: [
                              Text(" " + itemsInfo[index][10].toString())
                            ]),
                          ])),
                ),
              ),
            ])),
      ),
    );
  }
}
