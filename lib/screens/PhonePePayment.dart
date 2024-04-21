import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:najara_stays/common/sharepre.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePayment extends StatefulWidget {

  const PhonePePayment({super.key,  });

  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {
  String environment = "PRODUCTION";
  String appId = "c24b25c7ce8f413798832061362dede5";
  String merchantId = "M1JANB3EQPGU";
  bool enableLogging = true;
  String slatKey = "6416a218-710c-4af1-a348-c2b33ebacc1d";
  String slatIndex = "1";
  String callbackUrl =
      "https://webhook.site/6145154b-a10b-451c-a19c-c63b368f8255";
  String body= "";
  String checksum= "";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";


  @override
  void initState() {
    super.initState();
    phonePeInit();
     // Timer(Duration(seconds: 5), () async => await startPgTransaction(widget.orderid));


  }

  void phonePeInit(){
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
      })
    })
        .catchError((error) {
      handleError(error);

      return <dynamic>{};
    });
  }
  void handleError(error){
    setState(() {
      result = error;
    });
  }

  startPgTransaction(){
    try {
      body =  getChecksum("orderid").toString();
      var response = PhonePePaymentSdk.startTransaction(
          body, callbackUrl, checksum, "",);
      response
          .then((val) => {
        setState(() {
          if (val != null) {
            print("REPONSE---$val");
            String status = val['status'].toString();
            String error = val['error'].toString();
            if (status == 'SUCCESS') {
              result = "Flow Completed - Status: Success!";
            } else {
              result =
              "Flow Completed - Status: $status and Error: $error";
            }
          } else {
            result = "Flow Incomplete";
          }
          // result = val;
        })
      })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  Future<String> getChecksum(orderid)async {
    final getUserId = GetUserDetail();

    var userId = await getUserId.getUserData('id');

    final reqData =  {
      "merchantId": merchantId,
    "merchantTransactionId": "31232131232312",
    "merchantUserId": "90223250",
    "amount":  1000,
    "mobileNumber": "9999999999",
    "callbackUrl": callbackUrl,
    "paymentInstrument": {
    "type": "PAY_PAGE",
    //   "type": "UPI_INTENT",
      // "targetApp": "com.phonepe.app"
  },
    "deviceContext": {
    "deviceOS": "ANDROID"
  }
  };
  String base64Body = base64.encode(utf8.encode(json.encode(reqData)));
  checksum = "${sha256.convert(utf8.encode(base64Body+apiEndPoint+slatKey)).toString()}###$slatIndex";
  return base64Body;
  }


  void getPackageSignatureForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getPackageSignatureForAndroid()
          .then((packageSignature) => {
        print("packageSignature:   $packageSignature"),
        setState(() {
          result = 'getPackageSignatureForAndroid - $packageSignature';
        })
      })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Container(
                child: ElevatedButton(onPressed: () {
                  startPgTransaction();
                },
                child: Text("Start Transaction")),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: ElevatedButton(
                      onPressed: getPackageSignatureForAndroid,
                      child:
                      const Text('Get Package Signature'))),
              SizedBox(height: 20,),
              InkWell(onTap: () async {
                await Clipboard.setData(ClipboardData(text: "$result"));

              }, child: Text("RESULT ${result}"))
            ],
          )),
    );
  }
}
// }
