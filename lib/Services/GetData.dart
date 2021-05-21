import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetData {
  Future getdata(url) async {
    http.Response response = await http.get(url);
    String data = response.body;

    return jsonDecode(data);
  }
}
