import 'package:flutter/material.dart';
import 'package:formvalidation/pages/bloc/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);


    return Container(
      child:Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('EmailL: ${bloc.email}'),)
          ],
        ),
      )
    );
  }
}