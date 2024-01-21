import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_demo/config/injection/di.dart';
import 'package:todo_demo/config/navigation/app_route.dart';
import 'package:todo_demo/features/todo/src/todo_details/bloc/todo_details_bloc.dart';
import 'package:todo_demo/features/todo/src/todo_list/bloc/todo_bloc.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;

void backgroundNotificationMessageReceive(message) {
  print("Background Notification Message");
}

void notificationMessageReceive(message) {
  print("Notification Message");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await DI.init();

  channel = const AndroidNotificationChannel(
    'todo_notification', // id
    'Todo Notifications', // title
    description:
        'This channel is used for general notifications.', // description
    importance: Importance.high,
    playSound: true,
    showBadge: true,
    enableLights: true,
    enableVibration: true,
    ledColor: Colors.green,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(const TodoDemo());
}

class TodoDemo extends StatefulWidget {
  const TodoDemo({super.key});

  @override
  State<TodoDemo> createState() => _TodoDemoState();
}

class _TodoDemoState extends State<TodoDemo> {
  final _route = AppRoute();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationMessageReceive,
        onDidReceiveNotificationResponse: notificationMessageReceive,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.get<TodoBloc>()),
        BlocProvider(create: (_) => di.get<TodoDetailsBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _route.config(
          deepLinkBuilder: (deepLink) {
            return deepLink;
          },
        ),
      ),
    );
  }
}
