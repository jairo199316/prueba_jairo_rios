import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.userInformation,
  });

  final UserInformation userInformation;

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
