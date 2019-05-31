import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final productBloc = Provider.productsBloc(context);
    productBloc.loadProduct();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        
      ),
      body: _list(productBloc),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _list(ProductBloc productBloc){

    return StreamBuilder(
      stream: productBloc.productStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.hasData) {

          final produts = snapshot.data;
          return ListView.builder(
            itemCount: produts.length,
            itemBuilder: (contex, i) => _item(context,productBloc,produts[i]),
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _item(BuildContext context,ProductBloc productBloc, ProductModel product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direccion) => productBloc.deleteProduct(product.id),
      child:  Card(
        child: Column(
          children: <Widget>[
            product.photoUrl == null
              ? Image(image:AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: NetworkImage( product.photoUrl),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text("${product.title} - ${product.value}"),
                subtitle: Text(product.id),
                onTap: () => Navigator.pushNamed(context, 'producto', arguments: product),
              )
          ],
        ),
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