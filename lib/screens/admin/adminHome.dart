import 'package:restu/constants.dart';
import 'package:restu/screens/admin/OrdersScreen.dart';
import 'package:restu/screens/admin/addProduct.dart';
import 'package:restu/screens/admin/manageProduct.dart';
import 'package:flutter/material.dart';
import 'package:restu/widgets/custom_logo.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: CustomLogo()),
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}
