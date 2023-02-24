import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIpost extends StatefulWidget {
  const APIpost({Key? key}) : super(key: key);

  @override
  State<APIpost> createState() => _APIpostState();
}

class _APIpostState extends State<APIpost> {
  TextEditingController txt=TextEditingController();
  postdata()async{

    final url="http://192.168.29.150:8080/userid";
    var body= {
      "id":txt.text,
    };
    var res=await post(Uri.parse(url),body: jsonEncode(body));
    if(res.statusCode==200)

    {
      print("hii");
      print (res.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            TextField(
              controller: txt,
            ),
            FloatingActionButton(onPressed: (){
              postdata();
            },child: Text("+"),),
          ],
        )
    );
  }
}
