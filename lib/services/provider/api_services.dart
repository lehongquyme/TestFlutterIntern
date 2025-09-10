import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/address.dart';

class ApiServices {
  final String locationIqKey = 'pk.b0a2c27553133b84d108deacdeba7ad5';
///Tim kiem dia chi
  Future<List<Address>> search(String query) async {
    if (query.isEmpty) return [];
    try {
      final results = await _searchLocationIq(query);
      if (results.isNotEmpty) return results;
      return await _searchNominatim(query);
    } catch (_) {
      return await _searchNominatim(query);
    }
  }
// tim kiem bang LocationsIq
  Future<List<Address>> _searchLocationIq(String query) async {
    final url = Uri.parse( 'https://us1.locationiq.com/v1/search?key=$locationIqKey&q=$query&format=json');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final List data = await json.decode(response.body);
      return data.map((e) => Address.fromLocationIqJson(e)).toList();
    } else {
      throw Exception('Loi khi tim kiem dia chi bang LocationIq : ${response.statusCode}');
    }
  }
    //Tim kiem bang OpenStreetMap Nominatim
  Future<List<Address>> _searchNominatim(String query) async {
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json');
    final response = await http.get(url, headers: {'Accept-Language': 'vi','User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36'});
    if (response.statusCode == 200) {
      final List data = await json.decode(response.body);
      return data.map((e) => Address.fromNominatimJson(e)).toList();
    } else {
      throw Exception('Loi khi tim kiem dia chi bang Nominatim : ${response.statusCode}');
    }
  }

}
