import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';
import 'package:vcharge/view/Security/LoginScreen.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<bool> checkAuthToken() async {
    final storage = FlutterSecureStorage();
    final authToken = await storage.read(key: 'authToken');
    return authToken != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<DarkThemeProvider>(context);

        return FutureBuilder<bool>(
          future: checkAuthToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final initialRoute = snapshot.data == true ? '/home' : '/login';

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
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          backgroundColor: Colors.blue),
                  drawerTheme: const DrawerThemeData(
                      backgroundColor: Colors.amberAccent),
                  textTheme: Typography.whiteRedwoodCity,
                  appBarTheme: const AppBarTheme(color: Colors.brown),
                ),
                initialRoute: initialRoute,
                routes: {
                  '/login': (context) => LoginScreen(),
                  '/home': (context) {
                    if (snapshot.data == true) {
                      final login = Login('userName', 'password');
                      return HomeScreen(login: login);
                    } else {
                      return LoginScreen();
                    }
                  },
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }
}
