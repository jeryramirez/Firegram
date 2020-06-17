import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';


class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey <FormState>();
  final scaffoldKey = GlobalKey <ScaffoldState>();

  final productProvider = new ProductProvider();

  ProductModel product = new ProductModel();

  File photo;

  @override
  Widget build(BuildContext context) {


    ProductModel prodData = ModalRoute.of(context).settings.arguments;

    if( prodData != null ) {

      product = prodData;

    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon ( Icons.photo_size_select_actual ),
            onPressed: _sellectPhoto,
          ),
          IconButton( 
            icon: Icon( Icons.camera_alt),
            onPressed: _takePicture,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showPicture(),
                _productName(),
                _productPrice(),
                _disponible(),
                _button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productName() {
    return TextFormField(
      initialValue: product.title,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product Name'
      ),
      onSaved: (value) => product.title = value,
      validator: (value) => value.length <= 3 ? 'add a name ': null,
    );
  }

  Widget _productPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Product Price'
      ),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value ) => isNumber(value) ? null : 'only numbers',
    );
  }

  Widget _button(){

    

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon ( Icons. save),
      onPressed: _submit,
    );
  }

  void _submit() async {

    setState(() {
      
    });
 
    if ( !formKey.currentState.validate() ) return ;

    formKey.currentState.save();


    if ( photo != null ){
      product.photoUrl = await productProvider.uploadImage(photo);
    }


    if ( product.id == null) {
      productProvider.createProduct(product);

    } else {
      productProvider.editProduct(product);
    }


    await showSnackbar('item added success');

    Navigator.pop(context);



  }

  Widget _disponible() {

    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      onChanged: (value) => setState((){
        product.available = value;
      })
    );

  }

  showSnackbar(String message) {

    final snackbar = SnackBar(

      content: Text(message),
      duration: Duration( milliseconds: 2000),

    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }

  _showPicture(){

    if(product.photoUrl != null) {
      return FadeInImage(
        image: NetworkImage( product.photoUrl),
        placeholder: AssetImage('assets/loading.gif'),
        height: 300.0,
        fit: BoxFit.contain
      );
    } else {
      return Image(
        image: AssetImage( photo?.path ??'assets/no_image.png'),
      );
    }

  }

  _sellectPhoto() async{

    photo = await ImagePicker.pickImage(source: ImageSource.gallery);

    if ( photo != null){
      product.photoUrl = null;
    }

    setState(() {


    });


  }

  void _takePicture() async{


    photo = await ImagePicker.pickImage(source: ImageSource.camera);

    if ( photo != null){
      product.photoUrl = null;
    }

    setState(() {
    });
  }
}