class DataServiceResponse {
  static final getCountriesResponse = {
    'data': [
      {'country': 'Colombia'},
      {'country': 'Mexico'},
    ]
  };
  static final getStatesResponse = {
    'data': {
      'name': 'Colombia',
      'states': [
        {'name': 'Antioquia'},
        {'name': 'Cundinamarca'},
      ]
    }
  };
  static final getCitiesResponse = {
    'data': ['Medellin', 'Envigado']
  };
}
