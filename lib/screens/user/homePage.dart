import 'package:restu/constants.dart';
import 'package:restu/models/product.dart';
import 'package:restu/screens/login_screen.dart';
import 'package:restu/screens/user/CartScreen.dart';
import 'package:restu/screens/user/productInfo.dart';
import 'package:restu/services/store.dart';
import 'package:restu/widgets/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restu/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:restu/widgets/custom_logo.dart';

import '../../functions.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  final _store = Store();
  List<Product> _products;
  @override



  Widget build(BuildContext context) {

    Widget image_carousel = new Container(
      height: 200.0,
      child:  new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('img/RESTUSHOPLOGO.png'),
          //AssetImage('img/img1.jpg'),
          //AssetImage('img/img2.jpg'),
          //AssetImage('images/w4.jpeg'),
          //AssetImage('images/m2.jpg'),
        ],
        autoplay: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );




    return Material(
      child: Scaffold(
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              // header
              new UserAccountsDrawerHeader(accountName: Text('MAJID HANDER'), accountEmail: Text('majidhanedrd24@gmail.com'),currentAccountPicture: GestureDetector(child: new CircleAvatar(backgroundColor: Colors.blueGrey,child: Icon(Icons.person,color: Colors.white,),),
              ),
                decoration: new BoxDecoration(
                    color: Colors.orange
                ),),
              //BODY

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));

                } ,
                child: ListTile(
                  title: Text('Home page'),
                  leading: Icon(Icons.home,color: Colors.orange,),

                ),
              ),

              InkWell(
                onTap: (){} ,
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person,color: Colors.orange),

                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new CartScreen()));
                } ,
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_basket,color: Colors.orange),

                ),
              ),

              InkWell(
                onTap: (){} ,
                child: ListTile(
                  title: Text('Favorite'),
                  leading: Icon(Icons.favorite,color: Colors.orange),

                ),
              ),
              Divider(),

              InkWell(
                onTap: (){} ,
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),

                ),
              ),

              InkWell(
                onTap: (){

                } ,
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help,color: Colors.blue),

                ),
              ),

              InkWell(
                onTap: (){

                  _auth.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);

                } ,
                child: ListTile(
                  title: Text('Log Out'),
                  leading: Icon(Icons.logout,color: Colors.red),

                ),
              ),


            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('RESTU SHOP'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_basket, size: 30,color: Colors.white,),
                onPressed: ()=>Navigator.of(context).pushNamed(CartScreen.id))
          ],

        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = [];
                for (var doc in snapshot.data.documents) {
                  var data = doc.data;
                  products.add(Product(
                      pId: doc.documentID,
                      pPrice: data[ProductPrice],
                      pName: data[Product_Name],
                      pDescription: data[ProductDescription],
                      pLocation: data[ProductLocation],
                      pCategory: data[ProductCategory]));
                }

                return GridView.builder(


                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductInfo.id,
                            arguments: products[index]);
                      },

                      child: Stack(
                        children: <Widget>[

                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                color: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        products[index].pName,
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                      SizedBox(
                                        height:5,
                                      ),

                                      Text('\$ ${products[index].pPrice}',style:
                                      TextStyle(color: Colors.white),)



                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: products.length,
                );
              } else {
                return Center(child: Text('Loading...'));
              }
            },
          ),
        ),
      ),
    );
  }
}
