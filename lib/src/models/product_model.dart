// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    String id;
    String title;
    double value;
    bool active;
    String photoUrl;

    ProductModel({
        this.id,
        this.title  = "",
        this.value  = 0.0,
        this.active = true,
        this.photoUrl,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => new ProductModel(
        id      : json["id"],
        title   : json["title"],
        value   : json["value"].toDouble(),
        active  : json["active"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        // "id"      : id,
        "title"   : title,
        "value"   : value,
        "active"  : active,
        "photoUrl": photoUrl,
    };
}
