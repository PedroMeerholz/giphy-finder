import 'dart:convert';
import 'package:http/http.dart' as http;

class TrendRequest {
  Future<Map> trendGifs() async {
    Map<String, String> apiParams = {
      'api_key': 'BSkGxzPR0dcyeP526vb7xtocV3BT9BLu',
      'limit': '25',
      'rating': 'g'
    };
    Uri url = Uri.http('api.giphy.com', '/v1/gifs/trending', apiParams);
    http.Response response = await http.get(url);

    return json.decode(response.body);
  }
}
