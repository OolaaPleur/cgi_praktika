class ApiConstants {
  // Base URL for the application
  static const String baseUrl = 'http://localhost:8080/api';

  // Endpoints
  static const String flightsEndpoint = '/flights';
  static const String imagesEndpoint = '/images';
  static const String imagesMediumEndpoint = '/images/medium';
  static const String seatsEndpoint = '/seats';

  // External APIs
  static const String companyPhotoUrlPattern =
      'https://cdn.brandfetch.io/{id}/w/400/h/400?c=1idfJcwgFO5WDGQF2Md';
}
