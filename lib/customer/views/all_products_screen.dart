import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/customer/views/components/product_customer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatelessWidget {
  Category category;
  AllProductsScreen(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name + " Products"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Expanded(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : ListView.builder(
                itemCount: provider.allProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  return ProductCustomerWidget(provider.allProducts![index]);
                });
      }),
    );
  }
}
