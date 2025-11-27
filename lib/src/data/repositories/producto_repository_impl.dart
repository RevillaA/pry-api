import 'package:pry_api/src/data/datasources/base_datasource.dart';

import '../repositories/base_repository.dart';
import '../models/producto_model.dart';
import '../datasources/producto_api_datasource.dart';
import '../../domain/entities/product_entity.dart';

class ProductoReposirotyImpl implements BaseRepository{
  final BaseDataSource ds;

  ProductoReposirotyImpl(this.ds);

  @override
  Future<List<ProductoEntity>> getProductos() {
    return ds.fetchProductos();
  }

  @override
  Future<ProductoEntity> createProductos(ProductoEntity p) {
    return ds.createProductos({
      "nombre": p.nombre,
      "precio": p.precio,
      "stock": p.stock,
      "categoria": p.categoria
    });
  }

  @override
  Future<bool> deleteProductos(String id) {
    return ds.deleteProductos(id);
  }

  @override
  Future<ProductoEntity> updateProductos(String id, ProductoEntity p) {
    return ds.updateProductos(id, {
      "nombre": p.nombre,
      "precio": p.precio,
      "stock": p.stock,
      "categoria": p.categoria
    });
  }
}
