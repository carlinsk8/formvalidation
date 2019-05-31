import 'dart:io';

import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';


import 'package:formvalidation/src/models/product_model.dart';

class ProductBloc{

  final _productController  = new BehaviorSubject<List<ProductModel>>();
  final _loadController     = new BehaviorSubject<bool>();

  final _productProvider    = new ProductosProvider();


  Stream<List<ProductModel>> get productStream => _productController.stream;
  Stream<bool> get loadStream => _loadController.stream;

  void loadProduct() async {

    final products  = await _productProvider.loadProduct();
    _productController.sink.add(products);

  }

  void addProduct(ProductModel product) async{

    _loadController.sink.add(true);
    await _productProvider.crateProduct(product);
    _loadController.sink.add(false);

  }

  Future<String> uploadImage(File photo) async{

    _loadController.sink.add(true);
    final pphotoUrl = await _productProvider.uploadImage(photo);
    _loadController.sink.add(false);

    return pphotoUrl;
    
  }

  void editProduct(ProductModel product) async{

    _loadController.sink.add(true);
    await _productProvider.editroduct(product);
    _loadController.sink.add(false);

  }

  void deleteProduct(String id) async{

    await _productProvider.deleteProduct(id);

  }

  dispose(){
    _productController?.close();
    _loadController?.close();
  }

}