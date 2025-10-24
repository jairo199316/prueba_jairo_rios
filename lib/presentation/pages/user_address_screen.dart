import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';
import 'package:prueba_jairo_rios/presentation/widgets/card_address_information_widget.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, required this.addresses});

  final List<AddressInformation> addresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(
            text: StringConstants.userAddressScreenTitle,
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.size22,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: SizeConstants.size8,
            right: SizeConstants.size8,
          ),
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                itemCount: addresses.length,
                itemBuilder: (_, i) {
                  final address = addresses[i];
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
        ));
  }
}
