import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/route/string_rout_names.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(getUsersFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push(StringRoutNames.formScreen);
            },
            child: const Text('Registrar usuario'),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) =>
                  ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, i) {
                      final user = users[i];
                      return InkWell(
                        onTap: (){
                          context.push(
                            StringRoutNames.detailScreen,
                            extra: user,
                          );
                        },
                        child: ListTile(
                          title: Text('${user.name} ${user.lastName}'),
                          subtitle: Text(user.birthday),
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
