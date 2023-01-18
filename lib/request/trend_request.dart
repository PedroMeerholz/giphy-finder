import 'dart:convert';

import 'package:giphy_finder/request/request.dart';
import 'package:http/http.dart' as http;

class TrendRequest extends Request {
  TrendRequest(super.search, super.offset);

  Future<Map> trendGifs() async {
    Map<String, dynamic> apiParams = {
      'api_key': 'BSkGxzPR0dcyeP526vb7xtocV3BT9BLu',
      'limit': '20',
      'rating': 'g'
    };
    Uri url = Uri.http('api.giphy.com', '/v1/gifs/trending', apiParams);
    http.Response response = await http.get(url);

    return json.decode(response.body);
  }
}
