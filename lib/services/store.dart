import 'package:restu/constants.dart';
import 'package:restu/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Store {

  final Firestore _firestore = Firestore.instance;
  addProduct(Product product){
    _firestore.collection(ProductsCollection).add({
      Product_Name: product.pName,
      ProductDescription: product.pDescription,
      ProductLocation: product.pLocation,
      ProductPrice: product.pPrice
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(ProductsCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(Orders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(Orders)
        .document(documentId)
        .collection(Order_Details)
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(ProductsCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(ProductsCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(Orders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(Order_Details).document().setData({
        Product_Name: product.pName,
        ProductPrice: product.pPrice,
        ProductQuantity: product.pQuantity,
        ProductLocation: product.pLocation,
        ProductCategory: product.pCategory
      });
    }
  }
}


