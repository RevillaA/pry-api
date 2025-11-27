import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/producto_model.dart';

class ProductoApiDataSource implements BaseDataSource{
  final String baseUrl = "http://10.240.1.14:3000/api/productos";

  @override
  Future<List<ProductoModel>> fetchProductos() async {
    final url = Uri.parse(baseUrl);
    final resp= await http.get(url);

    if (resp.statusCode != 200){
      throw Exception("Error al obtener productos");
    }

    final List data = json.decode(resp.body);

    return data.map((item)=>ProductoModel.fromJson(item)).toList();
  }

  @override
  Future<ProductoModel> createProductos(Map<String, dynamic> data) async {
    final resp= await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (resp.statusCode != 201){
      throw Exception("Error al obtener productos");
    }
    
    return ProductoModel.fromJson(json.decode(resp.body));
  }

  @override
  Future<bool> deleteProductos(String id) async {
    final resp= await http.delete(Uri.parse("$baseUrl/$id"));
    return resp.statusCode == 200;
  }

  @override
  Future<ProductoModel> updateProductos(String id, Map<String, dynamic> data) async {
    final resp= await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Context Type": "application/json"},
      body: json.encode(data),
    );

    if (resp.statusCode != 201){
      throw Exception("Error al obtener productos");
    }

    return ProductoModel.fromJson(json.decode(resp.body));
  }
}