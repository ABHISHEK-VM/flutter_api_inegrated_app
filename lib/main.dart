import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// String stringResponse = "hi";
Map mapResponse = {};
Map dataResponse = {};
List listResponse = [];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        print(response.statusCode);
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API INTEGRATION'),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(listResponse[index]['avatar']),
                    ),
                    Text(listResponse[index]['id'].toString()),
                    Text(listResponse[index]['first_name'].toString()),
                    Text(listResponse[index]['last_name'].toString()),
                    Text(listResponse[index]['email'].toString()),
                  ],
                ),
              );
            },
            itemCount: listResponse == null ? 0 : listResponse.length));
  }
}
