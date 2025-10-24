import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, required this.addresses});

  final List<AddressInformation> addresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Direcciones del usuario'),
        ),
        body: Column(
          children: [
            if (addresses.isEmpty) ...[
              const Center(
                child: Text('No hay direcciones'),
              ),
            ] else ...[
              Expanded(
                  child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (_, i) {
                  final address = addresses[i];
                  return Column(
                    children: [
                      const Text('---------'),
                      Text(
                        address.countryName,
                      ),
                      Text(
                        address.stateName,
                      ),
                      Text(
                        address.cityName,
                      ),
                      const Text('---------'),
                    ],
                  );
                },
              ))
            ]
          ],
        ));
  }
}
