import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/models/user_data.dart';
import '../SignIn/sign_in.dart';
import 'dart:io';

class Dashboard extends StatefulWidget {
  final UserData u;
  const Dashboard({Key? key, required this.u}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _imageViewSelfie() {
    if (widget.u.photoSelfie == null) {
      return Container(
        margin: const EdgeInsets.all(20),
        width: 250,
        height: 250,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
              fit: BoxFit.fill),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(15),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: Image.file(File(widget.u.photoSelfie!.toString())).image,
              fit: BoxFit.fill),
        ),
      );
    }
  }
  final user = FirebaseAuth.instance.currentUser!;
  String token = "";
  @override
  void initState() {
    widget.u.id = user.uid;
    setToken();
    debugPrint(token);
    super.initState();
  }

  Future<void> setToken() async {
    token = await user.getIdToken(false);
  }
  Future<String> getToken() async {
    return token = await user.getIdToken(false);
  }
  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance

    return Scaffold(
      appBar: AppBar(title: const Text("bienvenue a Autoteck")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              user.photoURL != null
                  ? Image.network("${user.photoURL}")
                  : Container(),
              user.displayName != null
                  ? Text("${user.displayName}")
                  : Container(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("First Name: ${widget.u.nom}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("Last Name: ${widget.u.prenom}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("Email: ${widget.u.email}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("Password: ${widget.u.motDePasse}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("token: ${user.getIdToken()}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("uid: ${user.uid}"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("uid from object: ${getToken()}"),
              ),
              _imageViewSelfie(),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () async{
                  await userCredentials.refresh();
                  print("token\n");
                  print(userCredentials.token);
                  print("uid \n");
                  print(userCredentials.uid);
                  // Signing out the user
                context.read<AuthBloc>().add(SignOutRequested());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
