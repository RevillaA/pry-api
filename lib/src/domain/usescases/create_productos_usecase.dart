import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class CreateProductosUseCase{
  final BaseRepository repo;

  CreateProductosUseCase(this.repo);

  //Future
  Future<void> call(ProductoEntity p){
    return repo.createProductos(p);
  }
}