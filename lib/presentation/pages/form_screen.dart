import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/country_information_provider.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';
import 'package:prueba_jairo_rios/presentation/route/string_rout_names.dart';
import 'package:prueba_jairo_rios/presentation/widgets/select_with_loading_widget.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

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
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  void _showSnackBar(BuildContext context, String message,
      {Color color = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(text: message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: StringConstants.formScreenTitle,
          fontWeight: FontWeight.bold,
          fontSize: SizeConstants.size22,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizeConstants.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: StringConstants.formScreenNameField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConstants.size20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SizeConstants.size12),
            TextField(
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: StringConstants.formScreenLastNameField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConstants.size20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SizeConstants.size12),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _birthdayController,
                  decoration: const InputDecoration(
                    labelText: StringConstants.formScreenBirthdayField,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConstants.size20),
                      ),
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SizeConstants.size24),
            SelectWithLoadingWidget<String>(
              provider: countriesFutureProvider,
              hint: StringConstants.formScreenSelectCountry,
              itemsExtractor: (response) => response?.countries ?? [],
              labelBuilder: (country) => country,
              value: _countrySelect,
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
            const SizedBox(height: SizeConstants.size16),
            if (_countrySelect != null && _countrySelect!.isNotEmpty)
              SelectWithLoadingWidget<String>(
                provider: statesFutureProvider(_countrySelect ?? ''),
                hint: StringConstants.formScreenSelectState,
                itemsExtractor: (response) => response?.states ?? [],
                labelBuilder: (state) => state,
                value: _stateSelect,
                onChanged: (value) {
                  if (value != _stateSelect) {
                    setState(() {
                      _stateSelect = value;
                      _citySelect = null;
                    });
                  }
                },
              ),
            const SizedBox(height: SizeConstants.size16),
            if (_stateSelect != null && _stateSelect!.isNotEmpty)
              SelectWithLoadingWidget<String>(
                provider: citiesFutureProvider({
                  'country': _countrySelect,
                  'state': _stateSelect,
                }),
                hint: StringConstants.formScreenSelectCity,
                itemsExtractor: (response) => response?.cities ?? [],
                labelBuilder: (city) => city,
                value: _citySelect,
                onChanged: (value) {
                  if (value != _citySelect) {
                    setState(() {
                      _citySelect = value;
                    });
                  }
                },
              ),
            const SizedBox(height: SizeConstants.size24),
            Wrap(
              spacing: SizeConstants.size8,
              runSpacing: SizeConstants.size8,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await addAddress();
                    },
                    icon: const Icon(Icons.add_location_alt_outlined),
                    label: const TextWidget(
                        text: StringConstants.formScreenAddAddress),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await addUser(context, ref);
                    },
                    icon: const Icon(Icons.save_alt),
                    label: const TextWidget(
                        text: StringConstants.formScreenSaveUserData),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size(double.infinity, SizeConstants.size48),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      goToViewAddress(context);
                    },
                    icon: const Icon(Icons.list_alt_outlined),
                    label: const TextWidget(
                        text: StringConstants.formScreenViewAddress),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addAddress() async {
    if (_countrySelect == null || _stateSelect == null || _citySelect == null) {
      _showSnackBar(context, StringConstants.formScreenCountryStateCityRequired,
          color: Colors.orange);
      return;
    }

    address.add(AddressInformation(
      countryName: _countrySelect ?? '',
      stateName: _stateSelect ?? '',
      cityName: _citySelect ?? '',
    ));

    _showSnackBar(context, StringConstants.formScreenAddressAdded);
  }

  Future<void> addUser(BuildContext context, WidgetRef ref) async {
    if (_nameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _birthdayController.text.isEmpty) {
      _showSnackBar(
        context,
        StringConstants.formScreenDataRequired,
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
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await ref.read(saveUserFutureProvider(user).future);
    ref.read(usersListVersionProvider.notifier).state++;

    if (context.mounted) Navigator.pop(context);

    setState(() {
      _nameController.text = "";
      _lastNameController.text = "";
      _birthdayController.text = "";

      _countrySelect = null;
      _stateSelect = null;
      _citySelect = null;
      address = [];
    });

    _showSnackBar(
      context,
      StringConstants.formScreenSuccessMessage,
      color: Colors.green,
    );
  }

  void goToViewAddress(BuildContext context) {
    if (address.isEmpty) {
      _showSnackBar(context, StringConstants.formScreenAddressEmpty,
          color: Colors.orange);
      return;
    }

    context.push(
      StringRoutNames.userAddressScreen,
      extra: address,
    );
  }
}
