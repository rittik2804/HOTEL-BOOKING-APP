/// error : false
/// message : "Coupon Code Applied Successfully"
/// data : {"amount":270}

class RedeemCouponM {
  RedeemCouponM({
      bool? error, 
      String? message,
    RedeemCouponData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  RedeemCouponM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? RedeemCouponData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  RedeemCouponData? _data;
RedeemCouponM copyWith({  bool? error,
  String? message,
  RedeemCouponData? data,
}) => RedeemCouponM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  RedeemCouponData? get data => _data;

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

/// amount : 270

class RedeemCouponData {
  RedeemCouponData({
      num? amount,}){
    _amount = amount;
}

  RedeemCouponData.fromJson(dynamic json) {
    _amount = json['amount'];
  }
  num? _amount;
  RedeemCouponData copyWith({  num? amount,
}) => RedeemCouponData(  amount: amount ?? _amount,
);
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    return map;
  }

}