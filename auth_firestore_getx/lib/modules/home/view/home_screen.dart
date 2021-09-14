import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:auth_firestore_getx/modules/home/controller/home_controller.dart';
import 'package:auth_firestore_getx/modules/product/view/add_product_screen.dart';
import 'package:auth_firestore_getx/modules/product/view/edit_product_screen.dart';
import 'package:auth_firestore_getx/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',
            style: TextStyle(fontSize: 28, color: Colors.white)),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => authController.logout(),
              icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
      // REAL TME GET DATA
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: homeController.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot.data!.docs);
              var listOfProducts = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: listOfProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Get.to(
                          EditProductScreen(
                            name: (listOfProducts[index].data()
                                as Map<String, dynamic>)["name"],
                            price: (listOfProducts[index].data()
                                as Map<String, dynamic>)["price"],
                          ),
                          arguments: listOfProducts[index].id),
                      title: Text((listOfProducts[index].data()
                          as Map<String, dynamic>)["name"]),
                      subtitle: Text((listOfProducts[index].data()
                          as Map<String, dynamic>)["price"]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await homeController
                              .deleteProduct(listOfProducts[index].id);
                        },
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),

      // ONE TIME GET DATA

      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //     future: homeController.getData(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         print(snapshot.data!.docs);
      //         var listOfProducts = snapshot.data!.docs;
      //         return ListView.builder(
      //             itemCount: listOfProducts.length,
      //             itemBuilder: (context, index) {
      //               return ListTile(
      //                 title: Text((listOfProducts[index].data()
      //                     as Map<String, dynamic>)["name"]),
      //                 subtitle: Text((listOfProducts[index].data()
      //                     as Map<String, dynamic>)["price"]),
      //               );
      //             });
      //       }
      //       return Center(child: CircularProgressIndicator());
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddProductScreen()),
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[400],
      ),
    );
  }
}
