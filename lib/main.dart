import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therhappy/authentication/auth.dart';
import 'package:therhappy/authentication/login.dart';
import 'package:therhappy/authentication/utils.dart';
import 'package:therhappy/firebase_options.dart';
import 'package:therhappy/model/routes.dart';
import 'package:therhappy/pages/nav.dart';
import 'package:therhappy/provider/notes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cera Pro',
          colorScheme:
              ColorScheme.dark(background: Color.fromARGB(255, 18, 18, 18)),
          useMaterial3: true,
        ),
        initialRoute: MyRoutes.mainRoute,
        routes: {
          MyRoutes.mainRoute: (context) => MainPage(),
          MyRoutes.navRoute: (context) => NavBar(),
          MyRoutes.loginRoute: (context) => LoginPage()
        },
      ),
    );
  }
}
