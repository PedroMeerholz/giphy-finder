import 'dart:convert';

import 'package:giphy_finder/request/request.dart';
import 'package:http/http.dart' as http;

class SearchRequest extends Request {
  SearchRequest(super.search, super.offset);

  Future<Map> searchGifs() async {
    Map<String, String> apiParams = {
      'api_key': 'BSkGxzPR0dcyeP526vb7xtocV3BT9BLu',
      'q': super.returnSearchValue,
      'limit': '50',
      'offset': super.returnOffsetValue,
      'rating': 'g',
      'lang': 'en'
    };
    Uri url = Uri.http('api.giphy.com', '/v1/gifs/search', apiParams);
    http.Response response = await http.get(url);

    return json.decode(response.body);
  }
}
