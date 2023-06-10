import 'package:firebase_app/data_repositories/auth_helper.dart';
import 'package:firebase_app/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  navigationFun(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Provider.of<AuthProvider>(context, listen: false).checkUser();
  }

  @override
  Widget build(BuildContext context) {
    navigationFun(context);
    // TODO: implement build
    return Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }
}
