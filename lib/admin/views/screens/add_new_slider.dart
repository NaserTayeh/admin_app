import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewSliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Slider'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                provider.pickImageForCategory();
              },
              child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey,
                  child: provider.imageFile == null
                      ? Center(
                          child: Icon(Icons.camera),
                        )
                      : Image.file(
                          provider.imageFile!,
                          fit: BoxFit.cover,
                        )),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    controller: provider.sliderTitleController,
                    label: 'Slider Title',
                    validation: provider.requiredValidation,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          provider.AddNewSlider();
                        },
                        child: Text('Add New Slider')),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
