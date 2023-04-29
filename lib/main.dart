import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';
import 'package:flutter_driver/driver_extension.dart';



void main() {
  enableFlutterDriverExtension();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<DarkThemeProvider>(context);
        return MaterialApp(
        title: 'VCharge',
        debugShowCheckedModeBanner: false,
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
            backgroundColor: Colors.blue
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Colors.amberAccent
          ),
          textTheme: Typography.whiteRedwoodCity,
          appBarTheme: const AppBarTheme(
            color: Colors.brown
          )
        ),
        home: const HomeScreen(),
      );
      }
    )
    );
  }
}
