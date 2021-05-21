import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:task/Services/GetData.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

String downloadlink;
String filepath = '';
String fetcheddata = '';

Future<dynamic> printdata() async {
  var key = Uri.parse(
      'https://enstallapi.enpaas.com/api/ConfigSetting/ConfigSettingListOne?strKey=GetStockDemoFilesPath');
  GetData data = GetData();
  var maindata = await data.getdata(key);
  print(maindata);

  return maindata;
}

Future<bool> download() async {
  var data = await printdata();
  downloadlink = data['strValue'].toString();
  downloadlink += 'Upload/Demo/demo_stocks.csv';
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(downloadlink));
  var fileresponse = await request.close();
  if (fileresponse.statusCode == 200) {
    var bytes = await consolidateHttpClientResponseBytes(fileresponse);
    filepath = (await getApplicationDocumentsDirectory()).path;
    filepath = filepath + '/demo.csv';
    File file = File(filepath);
    await file.writeAsBytes(bytes);
    print('downloaded');
  }

  return true;
}

Future<String> readfile() async {
  filepath = (await getApplicationDocumentsDirectory()).path;
  filepath = filepath + '/demo.csv';
  final csvFile = new File(filepath).openRead();
  print(filepath);
  var result = await csvFile
      .transform(utf8.decoder)
      .transform(
        CsvToListConverter(),
      )
      .toList();
  fetcheddata = result.toString();
  print(fetcheddata);
  return fetcheddata;
}
