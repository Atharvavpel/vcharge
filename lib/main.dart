import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';
import 'package:flutter/services.dart';
import 'package:vcharge/view/LoginScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the binding
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
        ],
        child: Builder(builder: (BuildContext context) {
          final themeChanger = Provider.of<DarkThemeProvider>(context);
          return GetMaterialApp(
            title: 'VCharge',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            themeMode: themeChanger.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
              dividerColor: Colors.black,
            ),
            darkTheme: ThemeData(
                dividerColor: Colors.white,
                brightness: Brightness.dark,
                iconTheme: const IconThemeData(
                  color: Colors.green,
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.blue),
                drawerTheme:
                    const DrawerThemeData(backgroundColor: Colors.amberAccent),
                textTheme: Typography.whiteRedwoodCity,
                appBarTheme: const AppBarTheme(color: Colors.brown)),
            home: LoginScreen(),
          );
        }));
  }
}
