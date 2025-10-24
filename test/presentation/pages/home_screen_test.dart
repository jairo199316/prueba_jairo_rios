import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/presentation/pages/home_screen.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';

void main() {
  testWidgets('HomeScreen Test',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getUsersFutureProvider.overrideWithProvider(
            FutureProvider.autoDispose((ref) async => [
              const UserInformation(
                name: 'Jairo',
                lastName: 'Rios',
                birthday: '25/04/1993',
                addresses: [],
              )
            ]),
          ),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person_add_alt_1), findsOneWidget);

    expect(find.textContaining('Jairo'), findsOneWidget);
    expect(find.textContaining('25/04/1993'), findsOneWidget);
  });
}
