import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final scaffoldKey = GlobalKey <ScaffoldState>();
@override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    productsProvider.getProducts();
    super.initState();
  }

  final productsProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _listTile(),
      floatingActionButton: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return FloatingActionButton(
      child: Icon (Icons. add),
      onPressed: (){
        Navigator.pushNamed(context, 'product');
      } 
    );
  }

  Widget _listTile() {

    return FutureBuilder(
      future: productsProvider.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){

        if(snapshot.hasData){

          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _items(context, products[i])

          );

        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );


  }

  Widget _items(BuildContext context, ProductModel product) {

    return Dismissible(
      
      
      key: UniqueKey(),
      background:  Container(
        color: Colors.red,
      ),
      onDismissed: (direcction){

        productsProvider.deleteProduct(product.id);
      },

      child: Card(
        child: Column(
          children: <Widget>[

            ( product.photoUrl == null 
              ? Image( image: AssetImage('assets/no_image.png'),) 
              : FadeInImage(
                image : NetworkImage( product.photoUrl),
                placeholder: AssetImage('assets/loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover
              )
            ),
            ListTile(

              title: Text('${ product.title } - ${ product.price }'),
              subtitle: Text( product.id ),
              onTap: () {
                
                Navigator.pushNamed(context, 'product', arguments: product);
              }

            ),
          ],
        ),
      )
    );
  }
}



