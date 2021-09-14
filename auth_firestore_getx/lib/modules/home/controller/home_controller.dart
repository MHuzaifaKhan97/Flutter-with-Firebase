import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference products = firestore.collection('products');
    return products.get();
  }

  // Realtime changes
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');
    return products.orderBy("time").snapshots();
  }

  deleteProduct(String docId) async {
    DocumentReference product = firestore.collection('products').doc(docId);
    try {
      await product.delete();
      Get.defaultDialog(
        title: "Product Deleted",
        content: Text("Product Succesfully Deleted"),
        confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Okay')),
      );
    } on FirebaseException catch (e) {
      Get.defaultDialog(title: 'Error', content: Text(e.message.toString()));
    }
  }
}
