import 'dart:convert';
import 'package:http/http.dart' as http;
import 'crypto.dart';

Future<List<Crypto>> fetchCryptos() async {
  final response = await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((crypto) => Crypto.fromJson(crypto)).toList();
  } else {
    throw Exception('Failed to load crypto data');
  }
}
