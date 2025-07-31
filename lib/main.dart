import 'package:flutter/material.dart';
import 'package:gigfind/Screens/home_screen.dart';
import 'package:gigfind/Screens/login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gigfind/Screens/note_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: [
    //GoRoute(path: '/', builder: (context, state) => Login_Screen()),
    // GoRoute(path: '/Home_Screen', builder: (context, state) => Home_Screen()),
    GoRoute(path: '/', builder: (context, state) => Note_Screen()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'GigFind', routerConfig: _router);
  }
}
