import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;



import 'package:formvalidation/src/models/product_model.dart';
import 'package:mime_type/mime_type.dart';

class ProductProvider{

  final String _url = 'https://firegram-2c009.firebaseio.com';

  Future<bool> createProduct( ProductModel product ) async{
    
    final url = '$_url/products.json';

    await http.post(url, body: productModelToJson(product));

    // final decodedData = json.decode(res.body);

    // print(decodedData);


    return true;


  }

  Future<bool> editProduct( ProductModel product ) async{
    
    final url = '$_url/products/${ product.id}.json';

    final res = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;


  }

  Future <List<ProductModel>> getProducts() async {

    final url = '$_url/products.json';
    final res = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(res.body);
    final List<ProductModel> products = new List();

    if (decodedData == null ) return [];

    decodedData.forEach((id, prod) {

      final temporaryProduct = ProductModel.fromJson(prod);
      temporaryProduct.id = id;

      products.add(temporaryProduct);

    });
    print(products);

    return products;
  }

  Future<int> deleteProduct(String id ) async {
    final url = '$_url/products/$id.json';

    await http.delete(url);

    // print( json.decode(res.body));

    return 1;
  }

  Future<String> uploadImage(File image) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/oshindeveloper12/image/upload?upload_preset&upload_preset=rg0zdvze');

    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath('file', image.path, contentType: MediaType(mimeType[0],mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201){
      print('something is wrong');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
    

  }

}