class StringConstants {
  //Generic Strings
  static const String error = 'Error';
  static const String getDataError = 'Error al obtener los datos';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';

  //Urls
  static const String baseUrl = 'https://countriesnow.space/api/v0.1';
  static const String countriesUrl = '$baseUrl/countries';
  static const String statesUrl = '$baseUrl/countries/states/q?country=';
  static const String citiesUrl = '$baseUrl/countries/state/cities/q?country=';

  //Strings detail_screen.dart
  static const String detailScreenTitle = 'Detalle usuario';
  static const String detailScreenDeleteUserConfirm = 'Confirmar eliminación';
  static const String detailScreenDeleteUserConfirmMessage =
      '¿Está seguro que desea eliminar este usuario?';
  static const String detailScreenDeleteUserCancel = 'Cancelar';
  static const String detailScreenDeleteUserDelete = 'Eliminar';
  static const String detailScreenDeleteUserDeleteMessage =
      'Usuario eliminado exitosamente';

  //Strings form_screen.dart
  static const String formScreenTitle = 'Registrar usuario';
  static const String formScreenNameField = 'Nombre';
  static const String formScreenLastNameField = 'Apellido';
  static const String formScreenBirthdayField = 'Fecha de nacimiento';
  static const String formScreenSelectCountry = 'Selecciona un país';
  static const String formScreenSelectState = 'Selecciona un estado';
  static const String formScreenSelectCity = 'Ciudad';
  static const String formScreenCountryStateCityRequired =
      'Selecciona país, estado y ciudad antes de agregar una dirección';
  static const String formScreenAddressAdded =
      'Dirección agregada correctamente';
  static const String formScreenAddAddress = 'Agregar dirección';
  static const String formScreenDataRequired =
      'Por favor completa todos los campos obligatorios';
  static const String formScreenSuccessMessage =
      'Usuario guardado exitosamente';
  static const String formScreenSaveUserData = 'Guardar usuario';
  static const String formScreenAddressEmpty = 'No hay direcciones agregadas';
  static const String formScreenViewAddress = 'Ver direcciones agregadas';

  //Strings home_screen.dart
  static const String homeScreenTitle = 'Lista de usuarios';
  static const String homeScreenAddUser = 'Registrar usuario';

  //Strings user_address_screen.dart
  static const String userAddressScreenTitle = 'Direcciones del usuario';
  static const String userAddressScreenNoAddresses = 'No hay direcciones';

}
