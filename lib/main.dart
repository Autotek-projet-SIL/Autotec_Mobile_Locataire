// ignore_for_file:  await_only_futures, prefer_typing_uninitialized_variables

import 'package:autotec/Authentication/first_screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/repositories/auth_repository.dart';
import 'package:autotec/car_rental/home_page.dart';
import 'package:autotec/Authentication/first_screens/home.dart';
import 'package:autotec/models/user_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userCred;
var initScreen;

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  userCred = UserCredentials();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  UserCredentials.setDeviceToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'poppins'),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Map();
                } else {
                  if (initScreen == 0 || initScreen == null) {
                    return OnBoarding();
                  }
                  return const Home();
                }
              }),
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
