import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    var androidSetup = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSetup = const DarwinInitializationSettings();
    var setupControl = InitializationSettings(android: androidSetup, iOS: iosSetup);
    await flp.initialize(setupControl, onDidReceiveNotificationResponse: notificationSelect);
  }

  Future<void> notificationSelect(NotificationResponse notificationResponse) async{
    var payload = notificationResponse.payload;

    if(payload != null){
      print("Notification selected: $payload");
    }
  }

  Future<void> showNotification() async {
    var androidNotifDetail = const AndroidNotificationDetails(
        "id",
        "name",
        channelDescription: "channelDescription",
        priority: Priority.high,
        importance: Importance.max);

    var iosNotifDetail = const DarwinNotificationDetails();
    var notifDetail = NotificationDetails(android: androidNotifDetail, iOS: iosNotifDetail);
    
    await flp.show(1, "Title", "Notification body", notifDetail, payload: "Payload");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showNotification();
                }, child: const Text("Send notification")),
          ],
        ),
      ),
    );
  }
}
