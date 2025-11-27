import 'package:flutter/foundation.dart';

import '../../domain/entities/product_entity.dart';

class ProductoModel extends ProductoEntity{
  ProductoModel({
    required super.id,
    required super.nombre,
    required super.precio,
    required super.stock,
    required super.categoria});

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json["id"],
      nombre: json["nombre"],
      precio: (json["precio"] as num).toDouble(),
      stock: json["stock"],
      categoria: json["categoria"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "precio": precio,
    "stock": stock,
    "categoria": categoria,
  };
}
