import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = new ProductosProvider();

  ProductModel product = new ProductModel();
  bool _loading = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    final ProductModel productData = ModalRoute.of(context).settings.arguments;

    if(productData != null){
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selecionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
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
                _mostrarFoto(),
                _inputName(),
                _inputPrice(),
                _active(),
                _button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Product",
      ),
      onSaved: (value) => product.title = value,
      validator: (value){
        if(value.length < 3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _inputPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Price",
      ),
      onSaved: (value) => product.value = double.parse(value),
      validator: (value){
        
        if(utils.isNumeric(value)){
          return null;
        }else{
          return "Solo numeros";
        }
      }
    );
  }

  Widget _active(){

    return SwitchListTile(
      value: product.active,
      title: Text("Active"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        product.active = value;
      }),
    );

  }

  Widget _button() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text("Save"),
      icon: Icon(Icons.save),
      onPressed: _loading ? null : _submit,
    );
  }

  void _submit() async{

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {_loading = true;});

    if(foto != null){
      product.photoUrl  = await productProvider.uploadImage(foto);
    }

    if(product.id == null){
      productProvider.crateProduct(product);
    }else{
      productProvider.editroduct(product);
    }

    //setState(() {_loading = false;});

    mostrarSnackbar("Registro Guardado");

    Navigator.pop(context);

  }

  void mostrarSnackbar(String text){

    final snackbar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }

  _mostrarFoto(){
    if(product.photoUrl != null){
      return FadeInImage(
        image: NetworkImage( product.photoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    }else{
      return Image(
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _selecionarFoto() async{
    _procesarImagen(ImageSource.gallery);

  }
  
  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: origen
    );

    if(foto != null){
      product.photoUrl = null;
    }
    setState(() {});
  }
}