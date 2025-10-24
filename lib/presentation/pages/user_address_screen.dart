import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, required this.addresses});

  final List<AddressInformation> addresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.userAddressScreenTitle),
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
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeConstants.size8),
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
        ));
  }
}
