import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/presentation/viewmodel/producto_viewmodel.dart';
import 'src/domain/usescases/get_productos_usecase.dart';
import 'src/data/repositories/producto_repository_impl.dart';
import 'src/data/datasources/producto_api_datasource.dart';
import 'src/domain/usescases/create_productos_usecase.dart';
import 'src/domain/usescases/delete_productos_usecase.dart';
import 'src/domain/usescases/update_productos_usecase.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  final dataSource = ProductoApiDataSource();
  final repo = ProductoReposirotyImpl(dataSource);
  final getProductosUseCase = GetProductosUseCase(repo);
  final createProductosUseCase = CreateProductosUseCase(repo);
  final updateProductosUseCase = UpdateProductosUseCase(repo);
  final deleteProductosUseCase = DeleteProductosUseCase(repo);

  runApp(MyApp(getProductosUseCase: getProductosUseCase, createProductosUseCase: createProductosUseCase, updateProductosUseCase:updateProductosUseCase, deleteProductosUseCase:deleteProductosUseCase ));
}

class MyApp extends StatelessWidget {
  final GetProductosUseCase getProductosUseCase;
  final CreateProductosUseCase createProductosUseCase;
  final UpdateProductosUseCase updateProductosUseCase;
  final DeleteProductosUseCase deleteProductosUseCase;

  const MyApp({
    super.key,
    required this.getProductosUseCase,
    required this.createProductosUseCase,
    required this.updateProductosUseCase,
    required this.deleteProductosUseCase
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProductoViewModel(
                getProductosUseCase,
                createProductosUseCase,
                updateProductosUseCase,
                deleteProductosUseCase)..cargarProductos()),
      ],
      child: MaterialApp(
        title: "Consumo API Flutter",
        routes: AppRoutes.routes,
      ),
    );
  }
}
