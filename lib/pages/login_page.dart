import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        body: Stack(
          children: <Widget>[
            _logInBackground(context),
            _logInForm(context)
          ],
        )
      )
    );
  }

  Widget _logInBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height *0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        background,

        Container(

          padding: EdgeInsetsDirectional.only(top: size.height *0.1),

          child: Column(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.white, size: 80.0,),
              SizedBox( width: double.infinity, height: size.height *0.01),
              Text('Log In', style: TextStyle( color: Colors.white, fontSize: 18),)
              
            ],
          ),
        )
      ],
    );

  }

  Widget _logInForm(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: size.height *0.25,
            )
          ),


          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0)
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Log in', style: TextStyle(fontSize: 18.0),)
              ],
            ),
          )
        ],
      ),
    );

  }
}