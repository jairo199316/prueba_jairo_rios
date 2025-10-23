import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/country_information_provider.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/widgets/select_with_loading.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();

  String? _countrySelect;
  String? _stateSelect;
  String? _citySelect;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _birthdayController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GenericDropdown<String>(
              provider: countriesFutureProvider,
              hint: 'Selecciona un país',
              itemsExtractor: (response) => response?.countries ?? [],
              labelBuilder: (country) => country,
              onChanged: (value) {
                if (value != _countrySelect) {
                  setState(() {
                    _countrySelect = value;
                    _stateSelect = null;
                    _citySelect = null;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            if (_countrySelect != null && _countrySelect!.isNotEmpty)
              GenericDropdown<String>(
                provider: statesFutureProvider(_countrySelect ?? ""),
                hint: 'Selecciona un estado',
                itemsExtractor: (response) => response?.states ?? [],
                labelBuilder: (state) => state,
                onChanged: (value) {
                  if (value != _stateSelect) {
                    setState(() {
                      _stateSelect = value;
                      _citySelect = null;
                    });
                  }
                },
              ),
            const SizedBox(height: 16),
            if (_stateSelect != null && _stateSelect!.isNotEmpty)
              GenericDropdown<String>(
                provider: citiesFutureProvider({
                  "country": _countrySelect,
                  "state": _stateSelect,
                }),
                hint: 'Selecciona una ciudad',
                itemsExtractor: (response) => response?.cities ?? [],
                labelBuilder: (city) => city,
                onChanged: (value) {
                  _citySelect = value;
                },
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final user = UserInformation(
                    addresses: [
                      AddressInformation(
                          countryName: _countrySelect ?? "",
                          stateName: _stateSelect ?? "",
                          cityName: _citySelect ?? "")
                    ],
                    name: _nameController.text,
                    lastName: _lastNameController.text,
                    birthday: _birthdayController.text);
                await ref.read(saveUserFutureProvider(user).future);
              },
              child: const Text('Guardar usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
