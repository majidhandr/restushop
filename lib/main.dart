import 'package:restu/constants.dart';
import 'package:restu/models/product.dart';
import 'package:restu/provider/adminMode.dart';
import 'package:restu/provider/cartItem.dart';
import 'package:restu/provider/modelHud.dart';
import 'package:restu/screens/admin/OrdersScreen.dart';
import 'package:restu/screens/admin/addProduct.dart';
import 'package:restu/screens/admin/adminHome.dart';
import 'package:restu/screens/admin/editProduct.dart';
import 'package:restu/screens/admin/manageProduct.dart';
import 'package:restu/screens/admin/order_details.dart';
import 'package:restu/screens/login_screen.dart';
import 'package:restu/screens/signup_screen.dart';
import 'package:restu/screens/user/CartScreen.dart';
import 'package:restu/screens/user/homePage.dart';
import 'package:restu/screens/user/productInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(


              appBar:AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
              ),


              body: Center(
                child: Text(''),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data.getBool(KeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
              routes: {
                OrderDetails.id: (context) => OrderDetails(),
                OrdersScreen.id: (context) => OrdersScreen(),
                CartScreen.id: (context) => CartScreen(),
                ProductInfo.id: (context) => ProductInfo(),
                EditProduct.id: (context) => EditProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
              },
            ),
          );
        }
      },
    );
  }
}
