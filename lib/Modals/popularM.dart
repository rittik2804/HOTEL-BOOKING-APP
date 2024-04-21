/// error : false
/// message : "Popular Destinations"
/// data : [{"name":"Agra","path":"/uploads/popular_destinations/taj.jpg"},{"name":"Delhi","path":"/uploads/popular_destinations/delhi.jpg"},{"name":"Goa","path":"/uploads/popular_destinations/goa.jpg"},{"name":"Mumbai","path":"/uploads/popular_destinations/mumbai.jpg"},{"name":"Uttarakhan","path":"/uploads/popular_destinations/uttarakhan.jpg"}]

class PopularM {
  PopularM({
      bool? error, 
      String? message, 
      List<PopularData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PopularM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PopularData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<PopularData>? _data;
PopularM copyWith({  bool? error,
  String? message,
  List<PopularData>? data,
}) => PopularM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<PopularData>? get data => _data;

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

/// name : "Agra"
/// path : "/uploads/popular_destinations/taj.jpg"

class PopularData {
  PopularData({
      String? name, 
      String? path,}){
    _name = name;
    _path = path;
}

  PopularData.fromJson(dynamic json) {
    _name = json['name'];
    _path = json['path'];
  }
  String? _name;
  String? _path;
  PopularData copyWith({  String? name,
  String? path,
}) => PopularData(  name: name ?? _name,
  path: path ?? _path,
);
  String? get name => _name;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['path'] = _path;
    return map;
  }

}