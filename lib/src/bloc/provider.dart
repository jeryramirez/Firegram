import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/logIn_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc = LogInBloc();

  Provider({Key key, Widget child}) : super(key: key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LogInBloc of (BuildContext context) {

    return ( context.dependOnInheritedWidgetOfExactType() as Provider ).loginBloc;


  }

  



}