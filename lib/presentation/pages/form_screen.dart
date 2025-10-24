import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/country_information_provider.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/route/string_rout_names.dart';
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
  List<AddressInformation> address = [];

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

  void _showSnackBar(BuildContext context, String message,
      {Color color = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    if (_countrySelect == null ||
                        _stateSelect == null ||
                        _citySelect == null) {
                      _showSnackBar(context,
                          'Selecciona país, estado y ciudad antes de agregar una dirección',
                          color: Colors.orange);
                      return;
                    }

                    address.add(AddressInformation(
                      countryName: _countrySelect ?? "",
                      stateName: _stateSelect ?? "",
                      cityName: _citySelect ?? "",
                    ));

                    _showSnackBar(context, 'Dirección agregada correctamente');
                  },
                  icon: const Icon(Icons.add_location_alt_outlined),
                  label: const Text('Agregar dirección'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _birthdayController.text.isEmpty) {
                      _showSnackBar(
                        context,
                        'Por favor completa todos los campos obligatorios',
                        color: Colors.redAccent,
                      );
                      return;
                    }

                    final user = UserInformation(
                      addresses: address,
                      name: _nameController.text,
                      lastName: _lastNameController.text,
                      birthday: _birthdayController.text,
                    );

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    await ref.read(saveUserFutureProvider(user).future);

                    if (context.mounted) Navigator.pop(context);

                    _showSnackBar(
                      context,
                      'Usuario guardado exitosamente',
                      color: Colors.green,
                    );
                  },
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Guardar usuario'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    if (address.isEmpty) {
                      _showSnackBar(context, 'No hay direcciones agregadas',
                          color: Colors.orange);
                      return;
                    }

                    context.push(
                      StringRoutNames.userAddressScreen,
                      extra: address,
                    );
                  },
                  icon: const Icon(Icons.list_alt_outlined),
                  label: const Text('Ver direcciones agregadas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
