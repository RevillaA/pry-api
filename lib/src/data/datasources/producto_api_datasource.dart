import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/producto_model.dart';

class ProductoApiDataSource implements BaseDataSource{
  final String baseUrl = "http://192.168.1.39:3000/api/productos";

  @override
  Future<List<ProductoModel>> fetchProductos() async {
    final url = Uri.parse(baseUrl);
    final resp= await http.get(url);

    if (resp.statusCode != 200){
      throw Exception("Error al obtener productos");
    }

    final List data = json.decode(resp.body);

    if (data.isNotEmpty) {
      print("Ejemplo de producto recibido: ${data[0]}");
    }

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
    final resp = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    print("Status Code PUT: ${resp.statusCode}");
    print("Response Body: ${resp.body}");

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception("Error al actualizar producto. Status: ${resp.statusCode}");
    }
    return ProductoModel.fromJson(json.decode(resp.body));
  }
}