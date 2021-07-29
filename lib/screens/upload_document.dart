// @dart=2.9
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:html' as webFile;
import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

//import 'package:file_picker_web/file_picker_web.dart' as webPicker;
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_mapping/widgets/text_widget.dart';
import 'package:csv/csv.dart';

// ignore: must_be_immutable
class UploadDocumentScreen extends StatefulWidget {
  //Wholesaler user;
  UploadDocumentScreen();
  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  // Wholesaler user;
  bool showLoader = false;
  String error = '';
  var itemsInfo;
  _UploadDocumentScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                text: "Bipin",
                color: Colors.black,
                size: 24,
                weight: FontWeight.w600),
            TextWidget(
              text: "Wholesaler ID: " + "1256",
              color: Colors.black,
              size: 16,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  DottedBorder(
                      radius: Radius.circular(4),
                      padding: EdgeInsets.all(0),
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Material(
                        child: InkWell(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            decoration: BoxDecoration(
                                color: HexColor("EDEDED"),
                                borderRadius: BorderRadius.circular(4)),
                            height: MediaQuery.of(context).size.width > 500
                                ? 400
                                : 152,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DottedBorder(
                                  borderType: BorderType.Circle,
                                  padding: EdgeInsets.all(0),
                                  color: HexColor("228BE6"),
                                  child: CircleAvatar(
                                    backgroundColor: HexColor('A5D8FF'),
                                    radius: 30,
                                    // alignment: Alignment.center,
                                    child: Icon(
                                      Icons.upload_file,
                                      color: HexColor("228BE6"),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14),
                                TextWidget(
                                  text: "Upload your document",
                                  color: HexColor("868E96"),
                                  size: 16,
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                          onTap: !showLoader
                              ? () async {
                                  setState(() {
                                    error = '';
                                  });
                                  //   var result;
                                  if (kIsWeb) {
                                    webFile.InputElement File =
                                        webFile.FileUploadInputElement();
                                    File.click();
                                    File.onChange.listen((event) {
                                      final file = File.files.first;
                                      final reader = webFile.FileReader();

                                      var a = file.name;
                                      if (a.contains('.xlsx')) {
                                        reader.onLoadEnd.listen((event) {
                                          reader.readAsArrayBuffer(file);
                                          var decoder =
                                              SpreadsheetDecoder.decodeBytes(
                                                  reader.result);
                                          var table = decoder.tables['Sheet 1'];
                                          var values = table.rows[0];
                                          print(values);
                                        });
                                      }
                                    }); //end of eventlistener

                                  } //end of if
                                  else {
                                    var result = await FlutterDocumentPicker
                                        .openDocument();

                                    if (result != null) {
                                      List<String> parts = result.split('.');

                                      String extensionPart =
                                          parts[parts.length - 1];

                                      if (extensionPart == 'xlsx' ||
                                          extensionPart == 'xls' ||
                                          extensionPart == 'csv') {
                                        HashMap<String, dynamic> map =
                                            HashMap();
                                        var file = result;
                                        setState(() {
                                          showLoader = true;
                                          error = '';
                                        });
                                        if (extensionPart == 'xlsx' ||
                                            extensionPart == 'xls') {
                                          itemsInfo = await compute(
                                              getData, file); // use of isolate
                                          setState(() {
                                            showLoader = false;
                                          });
                                        } else {
                                          String barcodeNumber;
                                          String supplierPartNumber;
                                          String partNumber;
                                          String size;
                                          int i = 0;
                                          var result = [];
                                          final input =
                                              new File(file).openRead();
                                          final fields = await input
                                              .transform(latin1.decoder)
                                              .transform(
                                                  new CsvToListConverter())
                                              .toList();
                                          for (var row in fields) {
                                            if (i == 0) {
                                              i++;
                                              continue;
                                            }
                                            if (row[0] == '') {
                                              if (row[9] != '') {
                                                barcodeNumber =
                                                    row[9].toString().trim();
                                                // barcodeNumber =
                                                //     removeZeroes(barcodeNumber);
                                                result[result.length - 1]
                                                        ['barcodeNumber'] +=
                                                    ' , ' + barcodeNumber;
                                              }
                                            } else {
                                              map = HashMap();
                                              barcodeNumber =
                                                  row[9].toString().trim();
                                              // barcodeNumber =
                                              //     removeZeroes(barcodeNumber);
                                              supplierPartNumber =
                                                  row[4].toString().trim();
                                              supplierPartNumber = removeZeroes(
                                                  supplierPartNumber);
                                              partNumber =
                                                  row[2].toString().trim();
                                              partNumber =
                                                  removeZeroes(partNumber);
                                              size = '';
                                              if (row[6] != '')
                                                size +=
                                                    row[6].toString().trim();
                                              if (row[7] != '') {
                                                if (size == '')
                                                  size +=
                                                      row[7].toString().trim();
                                                else
                                                  size += ' , ' +
                                                      row[7].toString().trim();
                                              }
                                              map['supplierPartNumber'] =
                                                  supplierPartNumber;
                                              map['category'] = row[0].trim();
                                              map['partNumber'] = partNumber;
                                              map['barcodeNumber'] =
                                                  barcodeNumber;
                                              map['description'] =
                                                  row[3].trim();
                                              map['size'] = size;
                                              result.add(map);
                                            }
                                          }
                                          itemsInfo = result;
                                        }
                                        setState(() {
                                          showLoader = false;
                                        });

                                        print("Uploaded Successfully");
                                        print(itemsInfo.toString());
                                        //     Navigator.push(
                                        //                                        context,
                                        //                                      MaterialPageRoute(
                                        //                                        builder: (context) =>
                                        //                                          UploadImagesScreen(
                                        //                                            "Bipin", itemsInfo)));
                                      }
                                    } else {
                                      setState(() {
                                        error =
                                            'Please select an xlsx or xls or csv file to proceed';
                                      });
                                    }
                                  }
                                }
                              : () {},
                        ),
                        color: Colors.transparent,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  error == ''
                      ? Container(
                          height: 0,
                        )
                      : Text(
                          error,
                          textScaleFactor: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                  SizedBox(height: 56),
                  Column(
                    children: [
                      Container(
                        child: Image.asset("lib/assets/error1.png"),
                        alignment: Alignment.center,
                        height: 200,
                      ),
                      TextWidget(
                        text: "No documents have been uploaded",
                        size: 16,
                        color: Colors.black.withOpacity(0.4),
                        weight: FontWeight.w400,
                      )
                    ],
                  )
                ],
              ),
            ),
            showLoader
                ? BackdropFilter(
                    child: Center(
                        child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator.adaptive(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Loading data...',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor('CED4DA')),
                        color: Colors.white,
                      ),
                    )),
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  )
          ]))),
    );
  }
}

removeZeroes(String value) {
  if (value == '') return value;
  if (value[0] == '0') value = value.substring(1);
  return value;
}

getMonth(month) {
  if (month == '01')
    return 'January';
  else if (month == '02')
    return 'February';
  else if (month == '03')
    return 'March';
  else if (month == '04')
    return 'April';
  else if (month == '05')
    return 'May';
  else if (month == '06')
    return 'June';
  else if (month == '07')
    return 'July';
  else if (month == '08')
    return 'August';
  else if (month == '09')
    return 'September';
  else if (month == '10')
    return 'October';
  else if (month == '11')
    return 'November';
  else if (month == '12') return 'December';
}

getDate(date) {
  var dateParts = date.split('-');
  return dateParts[2] + " " + getMonth(dateParts[1]) + ", " + dateParts[0];
}

getData(file) async {
  HashMap map = HashMap<String, dynamic>();

  var bytes = file.readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  DateTime now = DateTime.now();
  String date = DateTime(now.year, now.month, now.day).toString().split(' ')[0];
  date = getDate(date);
  print(excel.tables.length);
  List<HashMap> result = [];
  for (var table in excel.tables.keys) {
    print(table); //sheet Name
    print(excel.tables[table].maxCols);
    print(excel.tables[table].maxRows);
    String barcodeNumber;
    String size;
    String supplierPartNumber;
    String partNumber;
    int i = 0;
    for (var row in excel.tables[table].rows) {
      if (i == 0) {
        i++;
        continue;
      } //

      if (row[0] == null) {
        if (row[9] != null)
          barcodeNumber = (row[9].value is double
              ? row[9].value.toInt().toString().trim()
              : row[9].value.toString().trim());
        // barcodeNumber = removeZeroes(barcodeNumber);
        result[result.length - 1]['barcodeNumber'] =
            result[result.length - 1]['barcodeNumber'] + ' , ' + barcodeNumber;
      } else {
        map = HashMap<String, dynamic>();
        size = '';
        size = size + (row[6] != null ? row[6].value.trim() : '');
        size = size +
            (row[7] != null
                ? ' , ' +
                    (row[7].value is double
                        ? row[7].value.toInt().toString().trim()
                        : row[7].value.trim())
                : '');
        barcodeNumber = row[9] != null
            ? (row[9].value is double
                ? row[9].value.toInt().toString().trim()
                : row[9].value.trim())
            : '';
        supplierPartNumber = row[4] != null
            ? (row[4].value is double
                ? row[4].value.toInt().toString().trim()
                : row[4].value.trim())
            : '';
        partNumber = row[2].value is double
            ? row[2].value.toInt().toString().trim()
            : row[2].value.toString().trim();
        if (Platform.isIOS) {
          //barcodeNumber = removeZeroes(barcodeNumber);
          supplierPartNumber = removeZeroes(supplierPartNumber);
          partNumber = removeZeroes(partNumber);
        }
        map['size'] = size;
        map['barcodeNumber'] = barcodeNumber;
        map['supplierPartNumber'] = supplierPartNumber;
        map['category'] = row[0].value.trim();
        map['partNumber'] = partNumber;
        map['description'] = row[3].value.trim();
        map['active'] = true;
        map['date'] = date;
        result.add(map);
      }
      print('done ' + i.toString());
      i++;
    }
  }
  return result;
}
