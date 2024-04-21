/// error : false
/// message : "My Bookings."
/// data : [{"id":"1","user_name":"Ufuf Hdhd","user_id":"6","user_type":"1","hotel_id":"2","room_id":"2","room_type":"1","meal_type":"1","first_name":"Ufuf","last_name":"Hdhd","email":"dipanshushav108@gmail.com","contact_number":"1234567890","address":"delhi bus","start_date_time":"2023-03-07 00:00:00","end_date_time":"2023-03-08 00:00:00","checked_in_date":null,"check_in_payment":null,"checkedout_date":null,"check_out_payment":null,"not_paid_reason":null,"total_no_rooms":"1","total_no_adults":"1","total_no_children":"0","total_no_infant":"0","booking_amount":"200.00","due_amount":"800.00","booking_id":"319825702","created_at":"2023-03-07 12:01:24","status":"2","cancel_reason":"vjbiviib","cancel_on":"2023-03-07 15:06:37","payment_status":"1","hotel_name":"hotel taj","main_image":"uploads/main_images/b45a3a0fea26d54abe585e573c50175a.jpeg","room_name":"Executive Room","start_date":"07/03/2023","end_date":"08/03/2023","start_time":"12:00 AM","end_time":"12:00 AM","total_guests":"1"},{"id":"11","user_name":"dh zv","user_id":"6","user_type":"1","hotel_id":"3","room_id":"3","room_type":"1","meal_type":"1","first_name":"dh","last_name":"zv","email":"trew@gmail.com","contact_number":"4664595946","address":"goa","start_date_time":"2023-03-07 00:00:00","end_date_time":"2023-03-07 00:00:00","checked_in_date":null,"check_in_payment":null,"checkedout_date":null,"check_out_payment":null,"not_paid_reason":null,"total_no_rooms":"1","total_no_adults":"1","total_no_children":"0","total_no_infant":"0","booking_amount":"100.00","due_amount":"300.00","booking_id":"1607696450","created_at":"2023-03-07 16:51:31","status":"2","cancel_reason":"hdhd","cancel_on":"2023-03-07 16:52:23","payment_status":"1","hotel_name":"Hotel radisson","main_image":"uploads/main_images/aff47bf6b3ad9cffcc47c998a31979aa.jpeg","room_name":"Suite Room","start_date":"07/03/2023","end_date":"07/03/2023","start_time":"12:00 AM","end_time":"12:00 AM","total_guests":"1"}]

class MybookingM {
  MybookingM({
      bool? error, 
      String? message, 
      List<MybookingData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  MybookingM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MybookingData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<MybookingData>? _data;
MybookingM copyWith({  bool? error,
  String? message,
  List<MybookingData>? data,
}) => MybookingM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<MybookingData>? get data => _data;

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
/// user_name : "Ufuf Hdhd"
/// user_id : "6"
/// user_type : "1"
/// hotel_id : "2"
/// room_id : "2"
/// room_type : "1"
/// meal_type : "1"
/// first_name : "Ufuf"
/// last_name : "Hdhd"
/// email : "dipanshushav108@gmail.com"
/// contact_number : "1234567890"
/// address : "delhi bus"
/// start_date_time : "2023-03-07 00:00:00"
/// end_date_time : "2023-03-08 00:00:00"
/// checked_in_date : null
/// check_in_payment : null
/// checkedout_date : null
/// check_out_payment : null
/// not_paid_reason : null
/// total_no_rooms : "1"
/// total_no_adults : "1"
/// total_no_children : "0"
/// total_no_infant : "0"
/// booking_amount : "200.00"
/// due_amount : "800.00"
/// booking_id : "319825702"
/// created_at : "2023-03-07 12:01:24"
/// status : "2"
/// cancel_reason : "vjbiviib"
/// cancel_on : "2023-03-07 15:06:37"
/// payment_status : "1"
/// hotel_name : "hotel taj"
/// main_image : "uploads/main_images/b45a3a0fea26d54abe585e573c50175a.jpeg"
/// room_name : "Executive Room"
/// start_date : "07/03/2023"
/// end_date : "08/03/2023"
/// start_time : "12:00 AM"
/// end_time : "12:00 AM"
/// total_guests : "1"

class MybookingData {
  MybookingData({
      String? id, 
      String? userName, 
      String? userId, 
      String? userType, 
      String? hotelId, 
      String? roomId, 
      String? roomType, 
      String? mealType, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? contactNumber, 
      String? address, 
      String? startDateTime, 
      String? endDateTime, 
      dynamic checkedInDate, 
      dynamic checkInPayment, 
      dynamic checkedoutDate, 
      dynamic checkOutPayment, 
      dynamic notPaidReason, 
      String? totalNoRooms, 
      String? totalNoAdults, 
      String? totalNoChildren, 
      String? totalNoInfant, 
      String? bookingAmount, 
      String? dueAmount, 
      String? bookingId, 
      String? createdAt, 
      String? status, 
      String? cancelReason, 
      String? cancelOn, 
      String? paymentStatus, 
      String? hotelName, 
      String? mainImage, 
      String? roomName, 
      String? startDate, 
      String? endDate, 
      String? startTime, 
      String? endTime, 
      String? totalGuests,}){
    _id = id;
    _userName = userName;
    _userId = userId;
    _userType = userType;
    _hotelId = hotelId;
    _roomId = roomId;
    _roomType = roomType;
    _mealType = mealType;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _contactNumber = contactNumber;
    _address = address;
    _startDateTime = startDateTime;
    _endDateTime = endDateTime;
    _checkedInDate = checkedInDate;
    _checkInPayment = checkInPayment;
    _checkedoutDate = checkedoutDate;
    _checkOutPayment = checkOutPayment;
    _notPaidReason = notPaidReason;
    _totalNoRooms = totalNoRooms;
    _totalNoAdults = totalNoAdults;
    _totalNoChildren = totalNoChildren;
    _totalNoInfant = totalNoInfant;
    _bookingAmount = bookingAmount;
    _dueAmount = dueAmount;
    _bookingId = bookingId;
    _createdAt = createdAt;
    _status = status;
    _cancelReason = cancelReason;
    _cancelOn = cancelOn;
    _paymentStatus = paymentStatus;
    _hotelName = hotelName;
    _mainImage = mainImage;
    _roomName = roomName;
    _startDate = startDate;
    _endDate = endDate;
    _startTime = startTime;
    _endTime = endTime;
    _totalGuests = totalGuests;
}

  MybookingData.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _hotelId = json['hotel_id'];
    _roomId = json['room_id'];
    _roomType = json['room_type'];
    _mealType = json['meal_type'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _contactNumber = json['contact_number'];
    _address = json['address'];
    _startDateTime = json['start_date_time'];
    _endDateTime = json['end_date_time'];
    _checkedInDate = json['checked_in_date'];
    _checkInPayment = json['check_in_payment'];
    _checkedoutDate = json['checkedout_date'];
    _checkOutPayment = json['check_out_payment'];
    _notPaidReason = json['not_paid_reason'];
    _totalNoRooms = json['total_no_rooms'];
    _totalNoAdults = json['total_no_adults'];
    _totalNoChildren = json['total_no_children'];
    _totalNoInfant = json['total_no_infant'];
    _bookingAmount = json['booking_amount'];
    _dueAmount = json['due_amount'];
    _bookingId = json['booking_id'];
    _createdAt = json['created_at'];
    _status = json['status'];
    _cancelReason = json['cancel_reason'];
    _cancelOn = json['cancel_on'];
    _paymentStatus = json['payment_status'];
    _hotelName = json['hotel_name'];
    _mainImage = json['main_image'];
    _roomName = json['room_name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _totalGuests = json['total_guests'];
  }
  String? _id;
  String? _userName;
  String? _userId;
  String? _userType;
  String? _hotelId;
  String? _roomId;
  String? _roomType;
  String? _mealType;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _contactNumber;
  String? _address;
  String? _startDateTime;
  String? _endDateTime;
  dynamic _checkedInDate;
  dynamic _checkInPayment;
  dynamic _checkedoutDate;
  dynamic _checkOutPayment;
  dynamic _notPaidReason;
  String? _totalNoRooms;
  String? _totalNoAdults;
  String? _totalNoChildren;
  String? _totalNoInfant;
  String? _bookingAmount;
  String? _dueAmount;
  String? _bookingId;
  String? _createdAt;
  String? _status;
  String? _cancelReason;
  String? _cancelOn;
  String? _paymentStatus;
  String? _hotelName;
  String? _mainImage;
  String? _roomName;
  String? _startDate;
  String? _endDate;
  String? _startTime;
  String? _endTime;
  String? _totalGuests;
  MybookingData copyWith({  String? id,
  String? userName,
  String? userId,
  String? userType,
  String? hotelId,
  String? roomId,
  String? roomType,
  String? mealType,
  String? firstName,
  String? lastName,
  String? email,
  String? contactNumber,
  String? address,
  String? startDateTime,
  String? endDateTime,
  dynamic checkedInDate,
  dynamic checkInPayment,
  dynamic checkedoutDate,
  dynamic checkOutPayment,
  dynamic notPaidReason,
  String? totalNoRooms,
  String? totalNoAdults,
  String? totalNoChildren,
  String? totalNoInfant,
  String? bookingAmount,
  String? dueAmount,
  String? bookingId,
  String? createdAt,
  String? status,
  String? cancelReason,
  String? cancelOn,
  String? paymentStatus,
  String? hotelName,
  String? mainImage,
  String? roomName,
  String? startDate,
  String? endDate,
  String? startTime,
  String? endTime,
  String? totalGuests,
}) => MybookingData(  id: id ?? _id,
  userName: userName ?? _userName,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  hotelId: hotelId ?? _hotelId,
  roomId: roomId ?? _roomId,
  roomType: roomType ?? _roomType,
  mealType: mealType ?? _mealType,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  contactNumber: contactNumber ?? _contactNumber,
  address: address ?? _address,
  startDateTime: startDateTime ?? _startDateTime,
  endDateTime: endDateTime ?? _endDateTime,
  checkedInDate: checkedInDate ?? _checkedInDate,
  checkInPayment: checkInPayment ?? _checkInPayment,
  checkedoutDate: checkedoutDate ?? _checkedoutDate,
  checkOutPayment: checkOutPayment ?? _checkOutPayment,
  notPaidReason: notPaidReason ?? _notPaidReason,
  totalNoRooms: totalNoRooms ?? _totalNoRooms,
  totalNoAdults: totalNoAdults ?? _totalNoAdults,
  totalNoChildren: totalNoChildren ?? _totalNoChildren,
  totalNoInfant: totalNoInfant ?? _totalNoInfant,
  bookingAmount: bookingAmount ?? _bookingAmount,
  dueAmount: dueAmount ?? _dueAmount,
  bookingId: bookingId ?? _bookingId,
  createdAt: createdAt ?? _createdAt,
  status: status ?? _status,
  cancelReason: cancelReason ?? _cancelReason,
  cancelOn: cancelOn ?? _cancelOn,
  paymentStatus: paymentStatus ?? _paymentStatus,
  hotelName: hotelName ?? _hotelName,
  mainImage: mainImage ?? _mainImage,
  roomName: roomName ?? _roomName,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  totalGuests: totalGuests ?? _totalGuests,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get hotelId => _hotelId;
  String? get roomId => _roomId;
  String? get roomType => _roomType;
  String? get mealType => _mealType;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get contactNumber => _contactNumber;
  String? get address => _address;
  String? get startDateTime => _startDateTime;
  String? get endDateTime => _endDateTime;
  dynamic get checkedInDate => _checkedInDate;
  dynamic get checkInPayment => _checkInPayment;
  dynamic get checkedoutDate => _checkedoutDate;
  dynamic get checkOutPayment => _checkOutPayment;
  dynamic get notPaidReason => _notPaidReason;
  String? get totalNoRooms => _totalNoRooms;
  String? get totalNoAdults => _totalNoAdults;
  String? get totalNoChildren => _totalNoChildren;
  String? get totalNoInfant => _totalNoInfant;
  String? get bookingAmount => _bookingAmount;
  String? get dueAmount => _dueAmount;
  String? get bookingId => _bookingId;
  String? get createdAt => _createdAt;
  String? get status => _status;
  String? get cancelReason => _cancelReason;
  String? get cancelOn => _cancelOn;
  String? get paymentStatus => _paymentStatus;
  String? get hotelName => _hotelName;
  String? get mainImage => _mainImage;
  String? get roomName => _roomName;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get totalGuests => _totalGuests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['hotel_id'] = _hotelId;
    map['room_id'] = _roomId;
    map['room_type'] = _roomType;
    map['meal_type'] = _mealType;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['contact_number'] = _contactNumber;
    map['address'] = _address;
    map['start_date_time'] = _startDateTime;
    map['end_date_time'] = _endDateTime;
    map['checked_in_date'] = _checkedInDate;
    map['check_in_payment'] = _checkInPayment;
    map['checkedout_date'] = _checkedoutDate;
    map['check_out_payment'] = _checkOutPayment;
    map['not_paid_reason'] = _notPaidReason;
    map['total_no_rooms'] = _totalNoRooms;
    map['total_no_adults'] = _totalNoAdults;
    map['total_no_children'] = _totalNoChildren;
    map['total_no_infant'] = _totalNoInfant;
    map['booking_amount'] = _bookingAmount;
    map['due_amount'] = _dueAmount;
    map['booking_id'] = _bookingId;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    map['cancel_reason'] = _cancelReason;
    map['cancel_on'] = _cancelOn;
    map['payment_status'] = _paymentStatus;
    map['hotel_name'] = _hotelName;
    map['main_image'] = _mainImage;
    map['room_name'] = _roomName;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['total_guests'] = _totalGuests;
    return map;
  }

}