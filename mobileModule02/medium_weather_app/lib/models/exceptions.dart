class SearchException implements Exception {
  @override
  String toString() {
    return 'Could not find any result for the supplied address.';
  }
}

class APIConnectionException implements Exception {
  @override
  String toString() {
    return 'The service connection is lost, please check your internet connection or try again later';
  }
}
