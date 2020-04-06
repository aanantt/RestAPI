import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'DetailScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController streamController;
  Stream stream;
  double container_height;
  double image_height;
  double image_width;
  bool isTap = false;

  fetch() async {
    streamController.add(null);
    Response response = await http.get("https://restcountries.eu/rest/v2/all");
    if (response.statusCode == 200) {
      streamController.add(json.decode(response.body));
    }
  }

  @override
  void initState() {
    streamController = StreamController();
    stream = streamController.stream;
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countries",
        ),
      ),
      body: Container(
          child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailScreen(
                              name: snapshot.data[index]["name"],
                              population:
                                  snapshot.data[index]["population"].toString(),
                              area: snapshot.data[index]["area"].toString(),
                              flag: snapshot.data[index]["flag"],
                              capital: snapshot.data[index]["capital"],
                              nativeName: snapshot.data[index]["nativeName"],
                            )));
                  },
                  onLongPress: () {
                    setState(() {
                      isTap = !isTap;
                      container_height = 50;
                      image_height=70;
                      image_width=70;
                    });
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: snapshot.data[index]["flag"],
                          child: Container(
                            padding:isTap==true?EdgeInsets.all(1): EdgeInsets.all(5),
                            height: isTap == true
                                ? image_height
                                : 50,
                            width: isTap == true
                                ?  image_width
                                : 50,
                            child:ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child:  SvgPicture.network(snapshot.data[index]["flag"]),
                            )
                          ),
                        ),
                        AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: isTap == true
                                ? MediaQuery.of(context).size.height * 0.18
                                : container_height,
                            width: MediaQuery.of(context).size.width * 0.80,
                             child: Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data[index]["name"],
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Visibility(
                                  visible: isTap,
                                  child: Text(

                                    snapshot.data[index]["population"].toString(),
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
