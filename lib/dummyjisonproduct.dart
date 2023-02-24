import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class  DummyJsonproduct extends StatefulWidget {
  const  DummyJsonproduct({Key? key}) : super(key: key);

  @override
  State< DummyJsonproduct> createState() => _DummyJsonproductState();
}

class _DummyJsonproductState extends State< DummyJsonproduct> {
  Future<dynamic> getdata() async {
    final url = "https://dummyjson.com/products";
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
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data["products"][0]["images"].length,
                itemBuilder: (context, index) {

                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 80,
                        color: Colors.red,
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image:
                                  DecorationImage(image: NetworkImage(snapshot.data["products"][0]["images"][index]))),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text("somthing went wrong");
                  }
                });
          }),
    );
  }
}
