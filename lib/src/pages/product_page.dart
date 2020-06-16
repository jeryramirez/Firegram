import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/utils.dart';


class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey <FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon ( Icons.photo_size_select_actual ),
            onPressed: () {},
          ),
          IconButton( 
            icon: Icon( Icons.camera_alt),
            onPressed: () {},
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
                _productName(),
                _productPrice(),
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
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product Name'
      ),
      validator: (value) => value.length <= 3 ? 'add a name ': null,
    );
  }

  Widget _productPrice() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Product Price'
      ),
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

  void _submit(){
    
    if ( !formKey.currentState.validate() ) return ;

    print('all ok');




  }
}