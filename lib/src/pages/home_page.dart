import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        
      ),
      body: _list(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _list(){
    return FutureBuilder(
      future: productosProvider.loadProduct(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if(snapshot.hasData) {

          final produts = snapshot.data;
          return ListView.builder(
            itemCount: produts.length,
            itemBuilder: (contex, i) => _item(context,produts[i]),
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _item(BuildContext context, ProductModel product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direccion){
        productosProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text("${product.title} - ${product.value}"),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: product),
      ),
    );
  }

  _createButton(BuildContext context) {

    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
    );
    
  }
}