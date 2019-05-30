import 'dart:convert';

import 'package:http/http.dart' as http;
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
  
}