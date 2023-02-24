import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Tooduus extends StatefulWidget {
  const Tooduus({Key? key}) : super(key: key);

  @override
  State<Tooduus> createState() => _TooduusState();
}

class _TooduusState extends State<Tooduus> {
  Future<dynamic> getdata()async{
    final url="https://dummyjson.com/todos";
    var response =await get(Uri.parse(url));
    if( response.statusCode==200)
    {
      var body=jsonDecode(response.body);
      return body;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getdata(),
          builder: (context,snapshot) {

            if (snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data["todos"].length,
                  itemBuilder: (context,index) {



                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 80,
                        color: Colors.purpleAccent,
                        child: ListTile(
                          leading: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(shape: BoxShape.circle,

                                color:snapshot.data["todos"][index]["completed"] == true ?  Colors.green:Colors.red

                            ),
                          ),

                          title: Text(snapshot.data["todos"][index][ "todo"]),
                          subtitle: Text(snapshot.data["todos"][index]["id"].toString()),

                        ),
                      ),
                    );
                  }



              );
            }else{


              return Text("somthing went wrong");
            }








          }
      ),
    );
  }
}
