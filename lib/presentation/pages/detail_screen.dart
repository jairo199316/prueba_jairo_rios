import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
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
          title: const Text(StringConstants.detailScreenTitle),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Card(
                child: ListTile(
                  title: Text(
                      '${StringConstants.formScreenNameField}: ${userInformation.name} ${userInformation.lastName}'),
                  subtitle: Text(
                      '${StringConstants.formScreenBirthdayField}: ${userInformation.birthday}'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                StringConstants.detailScreenAddressTitle,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.separated(
                itemCount: userInformation.addresses.length,
                itemBuilder: (_, i) {
                  final address = userInformation.addresses[i];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${StringConstants.detailScreenCountryName}: ${address.countryName}',
                          ),
                          Text(
                            '${StringConstants.detailScreenStateName}: ${address.stateName}',
                          ),
                          Text(
                            '${StringConstants.detailScreenCityName}: ${address.cityName}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
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
                title:
                    const Text(StringConstants.detailScreenDeleteUserConfirm),
                content: const Text(
                    StringConstants.detailScreenDeleteUserConfirmMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                        StringConstants.detailScreenDeleteUserCancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                        StringConstants.detailScreenDeleteUserDelete),
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
                      content: Text(
                          StringConstants.detailScreenDeleteUserDeleteMessage),
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
