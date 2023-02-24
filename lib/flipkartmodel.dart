import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';

class Flipkartmodel extends StatefulWidget {
  const Flipkartmodel({Key? key}) : super(key: key);

  @override
  State<Flipkartmodel> createState() => _FlipkartmodelState();
}

class _FlipkartmodelState extends State<Flipkartmodel> {
  Future<dynamic> getdata() async {
    final url = "https://dummyjson.com/products/search?q=Laptop";
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
          future:getdata() ,
          builder: (context,snapshot) {

            if (snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data["products"][0]["images"].length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: 300,
                        color: Colors.grey,
                        child: ListTile(
                          leading: Container(
                            height: 200,
                            width: 80,
                            color: Colors.white,
                            child: Image.network(snapshot.data["products"][0]["images"][index]),
                          ),
                          title: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 150),
                                    child: Text(snapshot.data["products"][0]["id"].toString()),
                                  ),
                                  Text(snapshot.data["products"][0]["title"]),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 120),
                                    child: Text(snapshot.data["products"][0]["discountPercentage"].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 120),
                                    child: Text(snapshot.data["products"][0]["rating"].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 130),
                                    child: Text(snapshot.data["products"][0]["stock"].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:80),
                                    child: Text(snapshot.data["products"][0]["brand"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 95),
                                    child: Text(snapshot.data["products"][0]["category"]),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [

                                  Text(snapshot.data["products"][0]["price"].toString()),

                                ],
                              )
                            ],
                          ),


                        ),
                      ),
                    );
                  }
              );
            }
            else
            {
              return Text("somthing went wrong");
            }
          }
      ),
    );
  }
}
