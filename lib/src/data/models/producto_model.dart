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
      id: (json["id"] ?? json["_id"] ?? '').toString(),
      nombre: json["nombre"] ?? '',
      precio: (json["precio"] is int)
          ? (json["precio"] as int).toDouble()
          : double.tryParse(json["precio"].toString()) ?? 0.0,
      stock: int.tryParse(json["stock"].toString()) ?? 0,
      categoria: json["categoria"] ?? '',
    );
  }
}
