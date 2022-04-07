import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/item_provider.dart';
import 'package:grocery/providers/order_provider.dart';
import 'package:grocery/providers/user_provider.dart';
import 'package:grocery/screens/additemscreen/add_item_screen.dart';
import 'package:grocery/screens/cart/cart_screen.dart';
import 'package:grocery/screens/home/home_screen.dart';
import 'package:grocery/screens/order_screen/order_screen.dart';
import 'package:grocery/screens/profile_screen/profile.dart';
import 'package:grocery/screens/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  bool tt = true;
  ThemeData night = ThemeData(
    cardColor: Colors.grey,
    shadowColor: Colors.white70,
    bottomAppBarColor: Colors.blueGrey,
    primaryColor: Colors.teal,
    backgroundColor: Color(0XFF3B3C53),
  );
  ThemeData light = ThemeData(
    bottomAppBarColor: Colors.white70,
    shadowColor: Colors.black,
    primaryColor: Colors.teal,
    backgroundColor: Colors.white70,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthMethods()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ItemsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),

      ],
      child: MaterialApp(
        title: 'Grocery',
        //  color: const Color(0x3B3C53),
        debugShowCheckedModeBanner: false,
        home: ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Home();
                  } else {
                    return Welcome();
                  }
                });
          },
        ),
        theme: night,
        routes: {
          Home.id: (context) => Home(),
          CartScreen.id: (context) => CartScreen(),
          Profile.id: (context) => Profile(),
          OrdersScreen.id: (context) => OrdersScreen(),

        },
      ),
    );
  }
}
