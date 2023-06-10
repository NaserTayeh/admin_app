import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/models/slider.dart';
import 'package:firebase_app/auth/models/app_user.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //register
  addNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  //login
  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('users').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateTheUser(AppUser appUser) async {
    await firestore.collection('users').doc(appUser.id).update(appUser.toMap());
  }

  //// admin methods
  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());

      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteCategoey(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Category>?> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<Category> categories = catsSnapshot.docs.map((doc) {
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// products functions
  Future<String?> addNewProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('categories')
              .doc(product.catId)
              .collection(product.category)
              .add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllProducts(String catId, catName) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('categories')
        .doc(catId)
        .collection(catName)
        .get();
    return querySnapshot.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
  }

  Future<bool?> deleteProduct(Product product) async {}

  Future<bool?> updateProduct(
    Product product,
  ) async {
    await firestore
        .collection('categories')
        .doc(product.catId)
        .collection(product.category)
        .doc(product.id)
        .update(product.toMap());
  }

  Future<String?> addNewSlider(Slider slider) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore.collection('sliders').add(slider.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<Slider>?> getAllSliders() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('sliders').get();
    return querySnapshot.docs.map((e) {
      Slider slider = Slider.fromMap(e.data());
      slider.id = e.id;
      return slider;
    }).toList();
  }
}
