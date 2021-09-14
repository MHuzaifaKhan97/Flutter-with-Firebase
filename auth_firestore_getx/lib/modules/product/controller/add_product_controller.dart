import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    super.onClose();
  }

  add() async {
    CollectionReference products = firestore.collection('products');

    try {
      String dateNow = DateTime.now().toString();
      print(dateNow);
      if (nameController.text == "") {
        Get.snackbar('Warning', 'Please enter product name',
            colorText: Colors.white,
            backgroundColor: Colors.orange[400],
            snackPosition: SnackPosition.BOTTOM);
      }
      if (priceController.text == "") {
        Get.snackbar('Warning', 'Please enter product name',
            colorText: Colors.white,
            backgroundColor: Colors.orange[400],
            snackPosition: SnackPosition.BOTTOM);
      } else {
        await products.add({
          "name": nameController.text,
          "price": priceController.text,
          "time": dateNow
        });
        Get.defaultDialog(
          title: "Product Added",
          content: Text("Product Succesfully Added"),
          confirm: ElevatedButton(
              onPressed: () {
                nameController.clear();
                priceController.clear();
                Get.back();
                Get.back();
              },
              child: Text('Okay')),
        );
      }
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          content: Text(e.message.toString()),
          onConfirm: () => Get.back(),
          textConfirm: "Okay");
    }
  }

  editProduct(String docId) async {
    DocumentReference product = firestore.collection('products').doc(docId);

    try {
      await product
          .update({"name": nameController.text, "price": priceController.text});
      Get.defaultDialog(
        title: "Product Updated",
        content: Text("Product Succesfully Updated"),
        confirm: ElevatedButton(
            onPressed: () {
              nameController.clear();
              priceController.clear();
              Get.back();
              Get.back();
            },
            child: Text('Okay')),
      );
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          content: Text(e.message.toString()),
          onConfirm: () => Get.back(),
          textConfirm: "Okay");
    }
  }

  // Future<DocumentSnapshot<Object?>> getDataByID(String docId) async {
  //   DocumentReference product =
  //       await firestore.collection('products').doc(docId);
  //   return product.get();
  // }

}
