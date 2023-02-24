import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apiflipkartmodel extends StatefulWidget {
  const Apiflipkartmodel({Key? key}) : super(key: key);

  @override
  State<Apiflipkartmodel> createState() => _ApiflipkartmodelState();
}

class _ApiflipkartmodelState extends State<Apiflipkartmodel> {
  Future<dynamic> getdata() async {
    final url = "https://dummyjson.com/products/search?q=Laptop";
    var res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
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
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data["products"].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,
                      color: Colors.white,
                      child: ListTile(
                          leading: Container(
                            height: 80,
                            width: 80,
                            child: Image.network(
                                snapshot.data["products"][index]["thumbnail"]),
                          ),
                          subtitle: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 120),
                                    child: Text("* ${snapshot.data["products"][index]["id"]
                                        .toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("* ${snapshot.data["products"][index]
                                    ["title"]}"),
                                  ),
                                  Container(
                                      height: 80,
                                      width: 140,
                                      child: Text("* ${snapshot.data["products"]
                                      [index]["description"]}",textAlign: TextAlign.start,)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 105),
                                    child: Text("*${snapshot.data["products"][index]
                                    ["discountPercentage"]
                                        .toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 105),
                                    child: Text("*${snapshot.data["products"][index]
                                    ["rating"]
                                        .toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 115),
                                    child: Text("*${snapshot.data["products"][index]["stock"]
                                        .toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70),
                                    child: Text("*${snapshot.data["products"][index]
                                    ["brand"]}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Text("*${snapshot.data["products"][index]
                                    ["category"]}"),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("*${snapshot.data["products"][index]["price"]
                                        .toString()}"),
                                  ),
                                ],
                              )
                            ],
                          )),
                    );
                  });
            } else {
              return Text("somthing went wrong");
            }
          }),
    );
  }
}
