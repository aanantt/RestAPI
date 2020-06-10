import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreen extends StatefulWidget {

  String name;
  String capital;
  int population;
  String flag;
  double area;
  String nativeName;
  DetailScreen(
      {@required this.name,@required this.nativeName,@required  this.capital,@required  this.population,@required  this.flag,@required this.area});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  TextStyle _style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Screen"),
      ),
      body: Container(
         child: ListView(
          children: <Widget>[
           Column(
             children: <Widget>[
              Hero(
                tag: widget.flag,
                child: Container(
                   padding: EdgeInsets.all(10),
                  alignment: Alignment.topCenter,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.network(
                      widget.flag,
                          fit:BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Country: ${widget.name}", style: _style,),
                  Text("Capital: ${widget.capital}", style: _style,),
                  Text("Population: ${widget.population.toString()}", style: _style,),
                  Text("Area: ${widget.area.toString()}", style: _style,),
                  Text("Native name: ${widget.nativeName}",style: _style,)
                ],

              )
            ],
          ),
          ],),
      ),
    );
  }
}
