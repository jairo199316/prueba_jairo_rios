import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/pages/detail_screen.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
class MockDeleteUserProvider extends Mock {
  Future<void> call(int index);
}

void main() {
  late ProviderContainer container;
  late MockDeleteUserProvider mockDeleteUserProvider;

  const userInformation = UserInformation(
    name: 'Jairo',
    lastName: 'Rios',
    birthday: '25/04/1993',
    addresses: [],
  );

  setUp(() {
    mockDeleteUserProvider = MockDeleteUserProvider();
    container = ProviderContainer(
      overrides: [
        deleteUserFutureProvider.overrideWithProvider(
          FutureProvider.family((ref, int index) async {
            await mockDeleteUserProvider(index);
          }),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  testWidgets('DetailScreen user information',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: DetailScreen(
            userInformation: userInformation,
            userIndex: 0,
          ),
        ),
      ),
    );

    expect(find.textContaining('Jairo'), findsOneWidget);
    expect(find.textContaining('Rios'), findsOneWidget);
    expect(find.textContaining('25/04/1993'), findsOneWidget);
  });
}
