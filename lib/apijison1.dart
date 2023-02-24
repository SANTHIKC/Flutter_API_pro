import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiJison1 extends StatefulWidget {
  const ApiJison1({Key? key}) : super(key: key);

  @override
  State<ApiJison1> createState() => _ApiJison1State();
}

class _ApiJison1State extends State<ApiJison1> {
  Future<dynamic> getdata() async {
    final url = "https://reqres.in/api/users?page=2";
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
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context,index) {


                  if(snapshot.hasData)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 70,
                        color: Colors.red,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]["avatar"]))),
                          ),
                          title: Text(snapshot.data["data"][index]["first_name"]),
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
      ),
    );
  }
}
