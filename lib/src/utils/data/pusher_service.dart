// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pusher_client/pusher_client.dart';
//
// class PusherService {
//   late PusherClient pusher;
//   late Channel channel;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   PusherService() {
//     _initializeNotifications();
//     pusher = PusherClient(
//       'your-app-key',
//       PusherOptions(
//         cluster: 'your-app-cluster',
//         encrypted: true,
//       ),
//       enableLogging: true,
//     );
//
//     channel = pusher.subscribe('private-user.${userId}'); // Replace with the actual user ID
//
//     channel.bind('Illuminate\\Notifications\\Events\\BroadcastNotificationCreated', (event) {
//       print('Notification received: ${event.data}');
//       _showNotification(event.data);
//     });
//
//     pusher.connect();
//   }
//
//   void _initializeNotifications() {
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> _showNotification(String message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'New Notification',
//       message,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
//
//   void disconnect() {
//     pusher.disconnect();
//   }
// }