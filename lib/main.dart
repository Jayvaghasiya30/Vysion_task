import 'package:flutter/material.dart';
import 'package:task/Services/GetData.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:task/Services/Download.dart';
import 'package:task/Displaydata.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String Id = 'Null';
  String Key = "Null";
  String value = "Null";
  String data;
  bool status = false;
  void updateui() async {
    dynamic data = await printdata();
    setState(() {
      Id = data['intId'].toString();
      Key = data['strKey'];
      value = data['strValue'];
    });
  }

  GlobalKey<RefreshIndicatorState> refreshkey;
  void initState() {
    super.initState();
    refreshkey = GlobalKey<RefreshIndicatorState>();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      Id = 'Null';
      Key = "Null";
      value = "Null";
      data = null;
      status = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await _pullRefresh();
        },
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 100)),
                Container(
                  height: 50,
                  width: 250,
                  child: TextButton(
                    onPressed: () async {
                      setState(() async {
                        status = await download();
                        updateui();
                      });
                    },
                    child: Center(
                      child: Text(
                        'Download CSV',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white60,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 20.0,
                        ),
                      ]),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                status ? Text('File Downloaded') : Text(''),
                Padding(padding: EdgeInsets.only(top: 40)),
                Container(
                  height: 50,
                  width: 250,
                  child: TextButton(
                    onPressed: () async {
                      if (status) {
                        data = await readfile();
                      }

                      if (data != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Display(data)));
                      }
                    },
                    child: Center(
                      child: Text(
                        'Get CSV',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white60,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 20.0,
                        ),
                      ]),
                ),
                Padding(padding: EdgeInsets.only(top: 60)),
                Text('ID : $Id'),
                Padding(padding: EdgeInsets.only(top: 60)),
                Text('Key : $Key'),
                Padding(padding: EdgeInsets.only(top: 60)),
                Text('Value : $value')
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
