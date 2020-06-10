import 'dart:convert';

import 'model.dart';
import 'package:http/http.dart' as http;


abstract class DataRepository {
  Future<List<Data>> getData();
}


class DataRepositoryImpl implements DataRepository{
  List<Data> dataa=[];
  @override
  Future<List<Data>> getData()async {
  var response = await http.get("https://restcountries.eu/rest/v2/all");
  try{
    if(response.statusCode==200){
//      final data = json.decode(response.body);
      final datalist=json.decode(response.body);
      datalist.forEach((element) {
        print(element);
       return dataa.add(Data.fromMap(element));
       });
    }
    return dataa;
  } catch(e) {
    throw e;
  }
  }




}

//"https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD&page=1"