abstract class IPetsDataSource {
  Future<List<dynamic>> getDogs();
  Future<List<dynamic>> getCats();
}
