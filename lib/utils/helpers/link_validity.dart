import 'package:http/http.dart' as http;

/// The linkValidity function takes a string and tries an http request with it.
/// If the link is available, the function will return the received string, if not,
/// the function will return null.
Future<String?> linkValidity(String? link) async {
  if (link == null) return null;

  try {
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) return link;
    return null;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
