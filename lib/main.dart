import 'package:flutter/material.dart';
import 'package:formvalidation/pages/bloc/provider.dart';
import 'package:formvalidation/pages/home_page.dart';

import 'pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'home' : (BuildContext context) => HomePage(),
          'login' : (BuildContext context) => LogInPage(),
        },
        
      ),
    );
    
    
    
    
  }
}