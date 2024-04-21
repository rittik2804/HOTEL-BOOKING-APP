// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instamojo/instamojo.dart';


class InstamojoScreen extends StatefulWidget {
  final String? orderid;
  bool isLive;

  InstamojoScreen(
      {Key? key,  this.orderid,required this.isLive})
      : super(key: key);

  @override
  _InstamojoScreenState createState() => _InstamojoScreenState();
}

class _InstamojoScreenState extends State<InstamojoScreen>
    implements InstamojoPaymentStatusListener {
  @override
  void initState() {
    print('-----id--------------id------------${widget.orderid}');
    print('-----isLive--------------isLive------------${widget.isLive}');
    super.initState();
  }
  var data;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: SafeArea(
            child: Instamojo(
              isConvenienceFeesApplied: false,
              listener: this,
              environment: widget.isLive == true ? Environment.PRODUCTION : Environment.TEST,
              apiCallType: ApiCallType.startPayment(orderId: widget.orderid),
              stylingDetails: StylingDetails(
                  buttonStyle: ButtonStyling(
                      buttonColor: Colors.amber,
                      buttonTextStyle: const TextStyle(
                        color: Colors.black,
                      )),
                  listItemStyle: ListItemStyle(
                      borderColor: Colors.grey,
                      textStyle: const TextStyle(color: Colors.black, fontSize: 18),
                      subTextStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
                  loaderColor: Colors.amber,
                  inputFieldTextStyle: InputFieldTextStyle(
                      textStyle: const TextStyle(color: Colors.black, fontSize: 18),
                      hintTextStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      labelTextStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
                  alertStyle: AlertStyle(
                    headingTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
                    messageTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
                    positiveButtonTextStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 10),
                    negativeButtonTextStyle:
                    const TextStyle(color: Colors.amber, fontSize: 10),
                  )),
            )
        )
    );
  }

  @override
  void paymentStatus({Map<String, String>? status}) {
    print('status----------$status');
    Navigator.pop(context,status);
  }
}

print(String message) {
  debugPrint(message);
}

class DataModel {
  String name = '';
  String email = '';
  String number = '';
  String amount = '';
  String description = '';
  bool isLive = false;
}