import 'package:http/http.dart' as http;

Future<bool> checkIfUrlExists(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    print('Error checking URL: $e');
    return false;
  }
}
