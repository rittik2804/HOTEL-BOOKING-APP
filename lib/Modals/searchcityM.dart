

class SearchcityM {
  SearchcityM({
      bool? error, 
      String? message, 
      List<SearchcityData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SearchcityM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchcityData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<SearchcityData>? _data;
SearchcityM copyWith({  bool? error,
  String? message,
  List<SearchcityData>? data,
}) => SearchcityM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<SearchcityData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Bombuflat"
/// state_id : "1"

class SearchcityData {
  SearchcityData({
      String? id, 
      String? name, 
      String? stateId,}){
    _id = id;
    _name = name;
    _stateId = stateId;
}

  SearchcityData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _stateId = json['state_id'];
  }
  String? _id;
  String? _name;
  String? _stateId;
  SearchcityData copyWith({  String? id,
  String? name,
  String? stateId,
}) => SearchcityData(  id: id ?? _id,
  name: name ?? _name,
  stateId: stateId ?? _stateId,
);
  String? get id => _id;
  String? get name => _name;
  String? get stateId => _stateId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['state_id'] = _stateId;
    return map;
  }

}