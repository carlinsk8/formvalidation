import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/login_bloc.dart';
import 'package:formvalidation/src/blocs/product_bloc.dart';

export 'package:formvalidation/src/blocs/login_bloc.dart';
export 'package:formvalidation/src/blocs/product_bloc.dart';

class Provider extends InheritedWidget {

  final loginBloc     = new LoginBloc();
  final _productBloc  = new ProductBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}){

    if(_instancia==null){
      _instancia= new Provider._internal(key:key, child:child);
    }
    return _instancia;

  }
  
  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  

  // Provider({Key key, Widget child})
  //   : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }

  static ProductBloc productsBloc (BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._productBloc;
  }

}