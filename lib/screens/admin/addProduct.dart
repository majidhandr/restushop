import 'package:restu/models/product.dart';
import 'package:restu/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:restu/services/store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category, _imageLocation;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _globalKey,
        child: ListView(
          children:[
            SizedBox(height: MediaQuery.of(context).size.height * .2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'Product Category',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _imageLocation = value;
                  },
                  hint: 'Product Location',
                ),

                SizedBox(
                  height: 20,
                ),

                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                  ImagePicker.pickImage(source: ImageSource.gallery);
                  },
                  color: Colors.orange,
                  child: Text(
                    'Add Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();

                      _store.addProduct(Product(
                          pName: _name,
                          pPrice: _price,
                          pDescription: _description,
                          pLocation: _imageLocation,
                          pCategory: _category));
                    }
                  },
                  child: Text('Add Product'),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}




