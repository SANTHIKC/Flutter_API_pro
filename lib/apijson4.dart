import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiJiosns extends StatefulWidget {
  const ApiJiosns({Key? key}) : super(key: key);

  @override
  State<ApiJiosns> createState() => _ApiJiosnsState();
}

class _ApiJiosnsState extends State<ApiJiosns> {
  getdata()async{
    final url="https://reqres.in/api/users/2";
    var response =await get(Uri.parse(url));
    if(response.statusCode==200)
    {
      var body = jsonDecode(response.body);
      print(body["data"]["email"]);
      print(body["data"]["first_name"]);
      print(body["data"]["last_name"]);
      print(body["data"]["avatar"]);
      setState(() {
        emal=body["data"]["email"];
        fname=body["data"]["first_name"];
        lname=body["data"]["last_name"];
        img=body["data"]["avatar"];

      });
    }
  }
  String?emal ="";
  String?fname="";
  String?lname="";
  String?img="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          ElevatedButton(onPressed: getdata,
            child: Text("get"),),
          Text(emal.toString()),
          Text(fname.toString()),
          Text(lname.toString()),
          Container(
            height: 100,
            width: 100,
            child:Image.network(img.toString()),

          ),


        ],
      ),
    );
  }
}
