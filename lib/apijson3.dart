import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIJson3 extends StatefulWidget {
  const APIJson3({Key? key}) : super(key: key);

  @override
  State<APIJson3> createState() => _APIJson3State();
}

class _APIJson3State extends State<APIJson3> {
  Future<dynamic> getdata() async {
    final url = "https://jsonplaceholder.typicode.com/posts";
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
          future: getdata(),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index) {

                  if(snapshot.hasData)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 150,
                        color: Colors.red,
                        child: ListTile(
                          title: Text(snapshot.data[index]["title"]),
                          subtitle: Text(snapshot.data[index]["body"]),
                        ),
                      ),
                    );
                  }
                  else {
                    return Text("somthing went wrong");
                  }
                }
            );
          }
      ) ,
    );
  }
}
