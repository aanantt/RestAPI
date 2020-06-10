import 'package:api/bloc/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'HomeScreen.dart';
import 'bloc/bloc_file.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:  BlocProvider(
        create: (context) => DataBloc(articleRepositoryImpl: DataRepositoryImpl())..add(FetchData()),
        child: Home(),
      ),
    );
  }
}

