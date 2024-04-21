
class BookingM {
  BookingM({
      bool? error, 
      String? message,
    BookingData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  BookingM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? BookingData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  BookingData? _data;
BookingM copyWith({  bool? error,
  String? message,
  BookingData? data,
}) => BookingM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  BookingData? get data => _data;

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

class BookingData {
  BookingData({
      num? bookingId, 
      String? orderId, 
      bool? isLive,}){
    _bookingId = bookingId;
    _orderId = orderId;
    _isLive = isLive;
}

  BookingData.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _orderId = json['order_id'];
    _isLive = json['is_live'];
  }
  num? _bookingId;
  String? _orderId;
  bool? _isLive;
  BookingData copyWith({  num? bookingId,
  String? orderId,
  bool? isLive,
}) => BookingData(  bookingId: bookingId ?? _bookingId,
  orderId: orderId ?? _orderId,
  isLive: isLive ?? _isLive,
);
  num? get bookingId => _bookingId;
  String? get orderId => _orderId;
  bool? get isLive => _isLive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['order_id'] = _orderId;
    map['is_live'] = _isLive;
    return map;
  }

}