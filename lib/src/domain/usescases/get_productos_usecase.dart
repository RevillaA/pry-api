import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetProductosUseCase{
  final BaseRepository repo;

  GetProductosUseCase(this.repo);

  //Future
  Future<List<ProductoEntity>> call(){
    return repo.getProductos();
  }
}