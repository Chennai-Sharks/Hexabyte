import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'layout/nav_layout.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hexabyte/screens/intermediate_screen/intermediate_screen.dart';

import 'theme_provider/theme_provider_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(Utils.backendUrl);

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'HexaByte',
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
            Locale('fa', ''),
            Locale('fr', ''),
            Locale('ja', ''),
            Locale('pt', ''),
            Locale('sk', ''),
            Locale('pl', ''),
          ],
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
          ],
          home: IntermediateScreen(),
          // If you wanna go to Home page straight away, comment the above line and uncomment
          // the below line.
          // home: NavigationLayout(),
        );
      },
    );
  }
}
