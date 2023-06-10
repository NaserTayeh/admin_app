import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/components/category_widget.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Categories'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? Center(
                child: Text('No Categories Found'),
              )
            : ListView.builder(
                itemCount: provider.allCategories!.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(provider.allCategories![index]);
                });
      }),
    );
  }
}
