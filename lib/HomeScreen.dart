import 'package:api/bloc/bloc_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'DetailScreen.dart';
import 'bloc/model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body:BlocBuilder<DataBloc,DataState>(
          builder: (context,state){
           return Container(
             child:_buildState(state),
            );
          },
        )
    );
  }

  _buildState(DataState state){
    if(state is LoadedState) {
      return Loaded(state.data);
    }
    else if(state is IsLoading) {
      return Center(
        child: CircularProgressIndicator(
        ),
      );
    }
  }

  Widget Loaded(List<Data> data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (_)=>DetailScreen(
                name: data[index].name,
                population: data[index].population ,
                area: data[index].area ,
                flag: data[index].flag,
                nativeName: data[index].nativeName,
                capital: data[index].capital,
              )
            ));
          },
          title: Text(data[index].name),
          subtitle: Text(data[index].capital),
          leading: SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.network(data[index].flag)),
        );
      },
    );
  }


}

