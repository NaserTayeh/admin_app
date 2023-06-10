import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatelessWidget {
  Category category;
  EditCategory(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Category"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.categoryFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    provider.pickImageForCategory();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: provider.imageFile == null
                        ? Image.network(
                            category.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            provider.imageFile!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  controller: provider.catNameArController,
                  label: 'Category Arabic name',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  controller: provider.catNameEnController,
                  label: 'Category English name',
                  validation: provider.requiredValidation,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.updateCategory(category);
                    },
                    child: const Text('Update Category'),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
