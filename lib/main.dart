import 'package:autotec/Authentication/data/models/user_data.dart';
import 'package:autotec/car_rental/presentation/date_time_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Authentication/bloc/bloc/auth_bloc.dart';
import 'Authentication/data/repositories/auth_repository.dart';
import 'Authentication/presentation/first_screens/intro.dart';
import 'car_rental/presentation/home_page.dart';

var userCred ;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  userCred = userCredentials();
  await Firebase.initializeApp();
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
          theme: ThemeData(fontFamily: 'Poppins'),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return  Map();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                //return SignIn();
                return const Intro();
              }),
        ),
      ),
    );
  }
}
