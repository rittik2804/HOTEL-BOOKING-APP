

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNoti {
  static final FlutterLocalNotificationsPlugin _notiplugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(context) {
    final InitializationSettings initializesettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notiplugin.initialize(
      initializesettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        print('The App bar is clicked------------------------onDidReceiveNotificationResponse-----------------');
        print('The Response in the notification is ----------------------onDidReceiveNotificationResponse----------------${notificationResponse.payload.toString()}');
      },
    );
  }

  // this method is for showing notification in forground.
  static void diplay(RemoteMessage message) async {
    try {
      print('The _notiplugin is Called---------------------diplay----------message------------');
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final sound = 'incoming_ring.mp3';
      final NotificationDetails notificationdetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'najara_stays', // id
          'najara_stays',
          importance: Importance.high,
          priority: Priority.max,
          fullScreenIntent: true,
           setAsGroupSummary: true,
          channelShowBadge: true,
          ongoing: true,
          styleInformation: BigTextStyleInformation(''),
        ),
      );
      String rawJson = message.data['message'];
      print('The Raw Json Body is -------------message------------------${rawJson}');
      await _notiplugin.show(0,
        message.data['title'],
        message.notification!.body,
        notificationdetails,
        payload: rawJson,
      );
    } on Exception catch (e) {
      print(
        'LLLLLLLL $e',
      );
    }
  }
}