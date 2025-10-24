import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    super.key,
    required this.userInformation,
    required this.userIndex,
  });

  final UserInformation userInformation;
  final int userIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle usuario'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                userInformation.name,
              ),
              Text(
                userInformation.lastName,
              ),
              Text(
                userInformation.birthday,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: userInformation.addresses.length,
                itemBuilder: (_, i) {
                  final address = userInformation.addresses[i];
                  return Column(
                    children: [
                      const Text("---------"),
                      Text(
                        address.countryName,
                      ),
                      Text(
                        address.stateName,
                      ),
                      Text(
                        address.cityName,
                      ),
                      const Text("---------"),
                    ],
                  );
                },
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmar eliminación'),
                content:
                    const Text('¿Está seguro que desea eliminar este usuario?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );

            if (shouldDelete ?? false) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                await ref.read(deleteUserFutureProvider(userIndex).future);

                ref.read(usersListVersionProvider.notifier).state++;

                if (context.mounted) {
                  Navigator.pop(context);
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario eliminado exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            }
          },
          child: const Icon(Icons.delete_forever),
        ));
  }
}
