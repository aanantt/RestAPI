import 'package:equatable/equatable.dart';

class Data extends Equatable{
 final String name;
 final String capital;
 final int population;
 final String flag;
 final double area;
 final String nativeName;

  Data({this.population, this.capital, this.name, this.area, this.flag,
      this.nativeName});


  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      name: json["name"] ,
      capital:json["capital"],
      population:json["population"] ,
      flag:json["flag"],
      area:json["area"] ,
     nativeName: json["nativeName"],
    );
  }

  @override
  List<Object> get props => [
    name,capital,population,flag,area,nativeName
  ];
}
