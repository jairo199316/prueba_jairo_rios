import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/presentation/pages/form_screen.dart';
import 'package:prueba_jairo_rios/presentation/provider/country_information_provider.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:dartz/dartz.dart';

void main() {
  testWidgets('FormScreen Test',
      (tester) async {
    final overrides = [
      countriesFutureProvider.overrideWithProvider(
        FutureProvider((ref) async => const Right(CountriesResponse(countries: ['Colombia']))),
      ),
      statesFutureProvider.overrideWithProvider((country) =>
          FutureProvider((ref) async => const Right(StatesResponse(states: ['Antioquia']))),
      ),
      citiesFutureProvider.overrideWithProvider((data) =>
          FutureProvider((ref) async => const Right(CitiesResponse(cities: ['Medellin']))),
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const MaterialApp(home: FormScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(DropdownButtonFormField<String>).first, findsOneWidget);
  });
}
