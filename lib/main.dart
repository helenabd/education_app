import 'package:education_app/core/core.dart';
import 'package:education_app/firebase_options.dart';
import 'package:education_app/src/dashboard/providers/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp(
        title: 'Education App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch(accentColor: Colours.primaryColor),
          fontFamily: Fonts.poppins,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
