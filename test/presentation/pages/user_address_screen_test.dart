import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/presentation/pages/user_address_screen.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';

void main() {
  testWidgets('UserAddressScreen Test', (tester) async {
    final addresses = [
      const AddressInformation(
        countryName: 'Colombia',
        stateName: 'Antioquia',
        cityName: 'Medellin',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: UserAddressScreen(addresses: addresses)),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Colombia'), findsOneWidget);
    expect(find.textContaining('Antioquia'), findsOneWidget);
    expect(find.textContaining('Medellin'), findsOneWidget);
  });
}
