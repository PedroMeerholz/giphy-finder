import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchRequest {
  SearchRequest(this._search, this._offset);

  String _search;
  String _offset;

  Future<Map> searchGifs() async {
    Map<String, String> apiParams = {
      'api_key': 'BSkGxzPR0dcyeP526vb7xtocV3BT9BLu',
      'q': _search,
      'limit': '50',
      'offset': _offset,
      'rating': 'g',
      'lang': 'en'
    };
    Uri url = Uri.http('api.giphy.com', '/v1/gifs/search', apiParams);
    http.Response response = await http.get(url);

    return json.decode(response.body);
  }
}
