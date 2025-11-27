import 'package:pry_api/src/domain/usescases/create_productos_usecase.dart';
import 'package:pry_api/src/domain/usescases/delete_productos_usecase.dart';
import 'package:pry_api/src/domain/usescases/update_productos_usecase.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usescases/get_productos_usecase.dart';
import 'base_viewmodel.dart';

class ProductoViewModel extends BaseViewModel {
  final GetProductosUseCase usecase;
  final CreateProductosUseCase createProductosUseCase;
  final UpdateProductosUseCase updateProductosUseCase;
  final DeleteProductosUseCase deleteProductosUseCase;

  List<ProductoEntity> productos = [];

  ProductoViewModel(
      this.usecase,
      this.createProductosUseCase,
      this.updateProductosUseCase,
      this.deleteProductosUseCase);

  Future<void> cargarProductos() async {
    setLoading(true);
    productos = await usecase();
    setLoading(false);
  }

  Future<void> agregarProductos(ProductoEntity p) async {
    await createProductosUseCase(p);
    await cargarProductos();
  }

  Future<void> editarProductos(String id, ProductoEntity p) async {
    await updateProductosUseCase(id, p);
    await cargarProductos();
  }

  Future<void> eliminarProductos(String id) async {
    await deleteProductosUseCase(id);
    await cargarProductos();
  }
}
