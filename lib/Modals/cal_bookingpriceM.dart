/// error : false
/// message : "Booking Price"
/// data : {"price":324,"due_amount":1836,"commission":"15","coupen_id":"2"}

class CalBookingpriceM {
  CalBookingpriceM({
      bool? error, 
      String? message,
    CalBookingpriceData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  CalBookingpriceM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? CalBookingpriceData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  CalBookingpriceData? _data;
CalBookingpriceM copyWith({  bool? error,
  String? message,
  CalBookingpriceData? data,
}) => CalBookingpriceM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  CalBookingpriceData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// price : 324
/// due_amount : 1836
/// commission : "15"
/// coupen_id : "2"

class CalBookingpriceData {
  CalBookingpriceData({
      num? price, 
      num? dueAmount, 
      String? commission, 
      String? coupenId,}){
    _price = price;
    _dueAmount = dueAmount;
    _commission = commission;
    _coupenId = coupenId;
}

  CalBookingpriceData.fromJson(dynamic json) {
    _price = json['price'];
    _dueAmount = json['due_amount'];
    _commission = json['commission'].toString();
    _coupenId = json['coupen_id'];
  }
  num? _price;
  num? _dueAmount;
  String? _commission;
  String? _coupenId;
  CalBookingpriceData copyWith({  num? price,
  num? dueAmount,
  String? commission,
  String? coupenId,
}) => CalBookingpriceData(  price: price ?? _price,
  dueAmount: dueAmount ?? _dueAmount,
  commission: commission ?? _commission,
  coupenId: coupenId ?? _coupenId,
);
  num? get price => _price;
  num? get dueAmount => _dueAmount;
  String? get commission => _commission;
  String? get coupenId => _coupenId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['due_amount'] = _dueAmount;
    map['commission'] = _commission;
    map['coupen_id'] = _coupenId;
    return map;
  }

}