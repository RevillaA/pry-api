import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/producto_viewmodel.dart';
import '../../domain/entities/product_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),

      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: vm.productos.length,
        itemBuilder: (_, i) {
          final p = vm.productos[i];
          return ListTile(
            title: Text(p.nombre),
            subtitle: Text("Precio: \$${p.precio} | Stock: ${p.stock}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---- Editar ----
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _openProductModal(context, vm,
                        isEdit: true, producto: p);
                  },
                ),

                // ---- Eliminar ----
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    vm.eliminarProductos(p.id);
                  },
                ),
              ],
            ),
          );
        },
      ),

      // ---- Botón para crear nuevo producto ----
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openProductModal(context, vm, isEdit: false);
        },
      ),
    );
  }

  // ============================================================
  //            MODAL: CREAR / EDITAR PRODUCTO
  // ============================================================
  void _openProductModal(
      BuildContext context,
      ProductoViewModel vm, {
        required bool isEdit,
        ProductoEntity? producto,
      }) {
    final nombreController =
    TextEditingController(text: isEdit ? producto!.nombre : "");

    final precioController = TextEditingController(
        text: isEdit ? producto!.precio.toString() : "");

    final stockController = TextEditingController(
        text: isEdit ? producto!.stock.toString() : "");

    final categoriaController =
    TextEditingController(text: isEdit ? producto!.categoria : "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? "Editar Producto" : "Nuevo Producto",
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // -------- CAMPOS --------
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),

              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
              ),

              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
              ),

              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(labelText: "Categoría"),
              ),

              const SizedBox(height: 20),

              // -------- BOTÓN GUARDAR --------
              ElevatedButton(
                onPressed: () {
                  final nombre = nombreController.text.trim();
                  final precio =
                      double.tryParse(precioController.text.trim()) ?? 0;
                  final stock =
                      int.tryParse(stockController.text.trim()) ?? 0;
                  final categoria = categoriaController.text.trim();

                  if (isEdit) {
                    vm.editarProductos(
                      producto!.id,
                      ProductoEntity(
                        id: producto.id,
                        nombre: nombre,
                        precio: precio,
                        stock: stock,
                        categoria: categoria,
                      ),
                    );
                  } else {
                    vm.agregarProductos(
                      ProductoEntity(
                        id: "", // tu backend genera ID
                        nombre: nombre,
                        precio: precio,
                        stock: stock,
                        categoria: categoria,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(isEdit ? "Actualizar" : "Crear"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
