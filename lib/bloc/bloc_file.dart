
import 'package:api/bloc/model.dart';
import 'package:api/bloc/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DataEvent extends Equatable {

}

class FetchData extends DataEvent {
  @override

  List<Object> get props => null;
}


abstract class DataState extends Equatable {

}

class IsLoading extends DataState {
  @override
  List<Object> get props => [];
}

class LoadedState extends DataState {
  List<Data> data;

  LoadedState({this.data});

  @override
  List<Object> get props => [data];
}

class ErrorState extends DataState {
  final String error;

  ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class DataBloc extends Bloc<DataEvent, DataState> {

  DataRepositoryImpl articleRepositoryImpl;
  DataBloc({this.articleRepositoryImpl});
  @override
  DataState get initialState => IsLoading();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchData) {
      print("Not initial");
      yield IsLoading();
      try{

        final datalist= await articleRepositoryImpl.getData();
        yield LoadedState(data: datalist);
      } catch(e){
        throw e;
      }

      }
    }
  }

