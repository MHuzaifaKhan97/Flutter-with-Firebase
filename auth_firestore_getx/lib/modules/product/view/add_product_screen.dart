import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:auth_firestore_getx/modules/forgot%20password/view/forgot_password_screen.dart';
import 'package:auth_firestore_getx/modules/login/controller/login_controller.dart';
import 'package:auth_firestore_getx/modules/product/controller/add_product_controller.dart';
import 'package:auth_firestore_getx/modules/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  final productController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextField(
                controller: productController.nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Enter Product Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: productController.priceController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Product Price'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    primary: Colors.orange[400]),
                onPressed: () async {
                  await productController.add();
                },
                child: Text(
                  'Add Product',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
