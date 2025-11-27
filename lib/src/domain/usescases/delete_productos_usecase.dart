import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class DeleteProductosUseCase{
  final BaseRepository repo;

  DeleteProductosUseCase(this.repo);

  //Future
  Future<void> call(String id){
    return repo.deleteProductos(id);
  }
}