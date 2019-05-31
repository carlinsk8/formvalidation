import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:formvalidation/src/models/product_model.dart';

class ProductosProvider{

  final String _url = "https://crudflutter-3d035.firebaseio.com";

  Future<bool> crateProduct(ProductModel product) async {

    final url = '$_url/product.json';
    
    final resp = await http.post(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }
  Future<bool> editroduct(ProductModel product) async {

    final url = '$_url/product/${product.id}.json';
    
    final resp = await http.put(url, body: productModelToJson(product));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }

  Future<List<ProductModel>> loadProduct() async {
    final url = '$_url/product.json';
    
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductModel> product = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, prod){
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id= id;

      product.add(prodTemp);
    });
    // print(product);

    return product;
  }

  Future<int> deleteProduct(String id) async{
    final url = '$_url/product/$id.json';
    
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  } 

  Future<String> uploadImage(File imagen) async {

    final url = Uri.parse("https://api.cloudinary.com/v1_1/dvxvlbh9r/image/upload?upload_preset=cyxwif0a");

    final mimeType = mime(imagen.path).split('/');
    final imageUploaRequest = http.MultipartRequest('POST',url);

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploaRequest.files.add(file);

    final streamResponse = await imageUploaRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    print(resp.statusCode);
    if (resp.statusCode != 200 && resp.statusCode != 201){
      
      print("algo salio mal");
      print(resp.body);
      return null;

    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData["secure_url"];


  }
  
}