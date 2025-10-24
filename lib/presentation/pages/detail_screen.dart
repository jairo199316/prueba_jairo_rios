import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/widgets/card_address_information_widget.dart';
import 'package:prueba_jairo_rios/presentation/widgets/card_user_information_widget.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

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
          title: const TextWidget(
            text: StringConstants.detailScreenTitle,
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.size22,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: SizeConstants.size8, right: SizeConstants.size8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: SizeConstants.size16,
              ),
              CardUserInformationWidget(
                  title:
                      '${StringConstants.formScreenNameField}: ${userInformation.name} ${userInformation.lastName}',
                  subtitle:
                      '${StringConstants.formScreenBirthdayField}: ${userInformation.birthday}'),
              const SizedBox(
                height: SizeConstants.size16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: SizeConstants.size8),
                child: TextWidget(
                  text: StringConstants.detailScreenAddressTitle,
                  fontSize: SizeConstants.size22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: SizeConstants.size16,
              ),
              Expanded(
                  child: ListView.separated(
                itemCount: userInformation.addresses.length,
                itemBuilder: (_, i) {
                  final address = userInformation.addresses[i];
                  return CardAddressInformationWidget(
                    countryName:
                        '${StringConstants.detailScreenCountryName}: ${address.countryName}',
                    stateName:
                        '${StringConstants.detailScreenStateName}: ${address.stateName}',
                    cityName:
                        '${StringConstants.detailScreenCityName}: ${address.cityName}',
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: Colors.indigoAccent,
          onPressed: () async {
            await deleteUserData(context, userIndex, ref);
          },
          child: const Icon(Icons.delete_forever),
        ));
  }

  Future<void> deleteUserData(
      BuildContext context, int index, WidgetRef ref) async {
    final shouldDelete = await showDeleteDialog(context);

    if (shouldDelete ?? false) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        await ref.read(deleteUserFutureProvider(userIndex).future);

        ref.read(usersListVersionProvider.notifier).state++;

        if (context.mounted) {
          Navigator.pop(context);
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: TextWidget(
                  text: StringConstants.detailScreenDeleteUserDeleteMessage),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }
  }

  Future<bool?> showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const TextWidget(
            text: StringConstants.detailScreenDeleteUserConfirm),
        content: const TextWidget(
            text: StringConstants.detailScreenDeleteUserConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const TextWidget(
                text: StringConstants.detailScreenDeleteUserCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const TextWidget(
                text: StringConstants.detailScreenDeleteUserDelete),
          ),
        ],
      ),
    );
  }
}
