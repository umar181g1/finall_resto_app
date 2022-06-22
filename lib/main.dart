import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:finall_resto_app/data/api_call.dart';
import 'package:finall_resto_app/provider/db_provider.dart';
import 'package:finall_resto_app/provider/list_detail_provider.dart';
import 'package:finall_resto_app/provider/scheduling_provider.dart';
import 'package:finall_resto_app/ui/detail_page_scren.dart';
import 'package:finall_resto_app/ui/fav_screen.dart';
import 'package:finall_resto_app/ui/home_screen.dart';
import 'package:finall_resto_app/ui/search_resto.dart';
import 'package:finall_resto_app/ui/setting_screen.dart';
import 'package:finall_resto_app/until/background_service.dart';
import 'package:finall_resto_app/until/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'common/navigation.dart';
import 'db/database_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoListProvider>(
          create: (_) => RestoListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restoran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        navigatorKey: navigatorKey,
        routes: {
          DetailPageList.routeName: (context) => DetailPageList(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPageScreen.routeName: (context) => const SearchPageScreen(),
          ResFavoritePage.routeName: (context) => const ResFavoritePage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
