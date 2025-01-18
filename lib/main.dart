import 'package:flutter/material.dart';
import 'package:lab2_211084/screens/favorite_jokes.dart';
import 'package:lab2_211084/screens/jokes_from_type.dart';
import 'package:lab2_211084/services/local_notification_service.dart';
import 'models/joke.dart';
import 'screens/home.dart';
import 'screens/random_joke.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final notificationService = LocalNotificationService();
  notificationService.initialize();
  notificationService.scheduleDailyNotification();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging _messaging;
  List<Joke> favoriteJokes = [];

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }


  void _setupFirebaseMessaging() {
    _messaging = FirebaseMessaging.instance;

    // Request permissions for iOS
    _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Foreground Notification: ${message.notification!.title}');
        // Display or process the notification
      }
    });

    // Handle when the app is opened via a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.data}');
      // Navigate or perform any required action
    });
  }


  /// Adds a joke to the favorites list
  void addToFavorites(BuildContext context, Joke joke) {
    if (!favoriteJokes.contains(joke)) {
      setState(() {
        favoriteJokes.add(joke);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${joke.setup} added to favorites!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${joke.setup} is already in favorites!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(
          onFavorite: (joke) => addToFavorites(context, joke),
          favoriteJokes: favoriteJokes,
        ),
        '/random-joke': (context) => RandomJoke(
          onFavorite: (joke) => addToFavorites(context, joke),
        ),
        '/favorites': (context) => FavoritesScreen(
          favoriteJokes: favoriteJokes,
        ),
        '/jokes': (context) =>  JokesFromType(
          jokes: const [],
          onFavorite: (joke) => addToFavorites(context, joke),
        ),

      },
    );
  }
}