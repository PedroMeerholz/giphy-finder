abstract class Request {
  Request(this._search, this._offset);

  String? _search;
  String? _offset;

  String get returnSearchValue => _search!;

  String get returnOffsetValue => _offset!;
}
