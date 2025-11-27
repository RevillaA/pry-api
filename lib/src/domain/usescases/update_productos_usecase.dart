import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class UpdateProductosUseCase{
  final BaseRepository repo;

  UpdateProductosUseCase(this.repo);

  //Future
  Future<void> call(String id,ProductoEntity p){
    return repo.updateProductos(id, p);
  }
}
