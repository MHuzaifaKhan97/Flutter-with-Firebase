import 'package:auth_firestore_getx/modules/product/controller/add_product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  final productController = Get.put(AddProductController());
  String name;
  String price;
  EditProductScreen({required this.name, required this.price});
  @override
  Widget build(BuildContext context) {
    productController.nameController.text = name;
    productController.priceController.text = price;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product',
            style: TextStyle(fontSize: 28, color: Colors.white)),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextField(
              controller: productController.nameController,
              decoration: InputDecoration(labelText: 'Enter Product Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: productController.priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Product Price'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(45),
                  primary: Colors.orange[400]),
              onPressed: () async {
                await productController.editProduct(Get.arguments);
              },
              child: Text(
                'Edit Product',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
