import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apijison2 extends StatefulWidget {
  const Apijison2({Key? key}) : super(key: key);

  @override
  State<Apijison2> createState() => _Apijison2State();
}

class _Apijison2State extends State<Apijison2> {
  Future<dynamic>getdata()async {
    final url = "https://reqres.in/api/users/2";
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getdata(),
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data["data"]["first_name"]),
                    Text(snapshot.data["data"]["email"]),

                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: Image(image: NetworkImage(snapshot.data["data"]["avatar"])),
                    ),
                    Text(snapshot.data["support"]["url"]),

                    Text(snapshot.data["support"]["text"]),
                  ],
                );
              }

              else {
                return Text("somthing went wrong");
              }
            }
        )
    );
  }
}
