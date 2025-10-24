import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/route/string_rout_names.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(getUsersFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.homeScreenTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              context.push(StringRoutNames.formScreen);
            },
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text(StringConstants.homeScreenAddUser),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) => Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    final user = users[i];
                    return InkWell(
                      onTap: () {
                        context.push(
                          StringRoutNames.detailScreen,
                          extra: {
                            'user': user,
                            'index': i,
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                  '${StringConstants.formScreenNameField}: ${user.name} ${user.lastName}'),
                              subtitle: Text(
                                  '${StringConstants.formScreenBirthdayField}: ${user.birthday}'),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('${StringConstants.error} $err')),
            ),
          ),
        ],
      ),
    );
  }
}
