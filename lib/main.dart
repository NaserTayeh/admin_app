import 'dart:developer';

import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/admin/views/screens/display_categories.dart';
import 'package:firebase_app/admin/views/screens/main_admin_screen.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/customer/views/customer_main_page.dart';
import 'package:firebase_app/data_repositories/auth_helper.dart';
import 'package:firebase_app/auth/providers/auth_provider.dart';
import 'package:firebase_app/auth/screens/sign_in_screen.dart';
import 'package:firebase_app/auth/screens/splach_screen.dart';
import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

/*
ecommerce app
users:
1- admin user:
- add new product
- edit products
- delete products
- display all products
- display all orders
- accept or reject orders

2- customer user:
- display all products
- add product to cart
- remove product from cart
- edit product quantity in cart\
- checkout 
- add product to favourite
- share product to friend


*/
/*
1- give the ability to textfield to be invisable or hidden using obscuretext
2- use textEditingController to get the textfield content
3- define the type of keyboard for each used textfield in your code
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        ),
      ],
      child: MaterialApp(
          navigatorKey: AppRouter.appRouter.navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.

            primarySwatch: Colors.blue,
          ),
          home: SplachScreen()
          // MainAdminScreen()
          // SplachScreen()
          // CustomMap(),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TextEditingController> controllers = [TextEditingController()];
  TextEditingController emailCOntroller = TextEditingController();
  TextEditingController passwordCOntroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Required field";
                } else if (!(isEmail(v))) {
                  return "Incorrect email syntax";
                }
              },
              controller: emailCOntroller,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Required field";
                } else if (v.length <= 6) {
                  return 'Error, the password must be larger than 6 letters';
                }
              },
              controller: passwordCOntroller,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid) {
                    AuthHelper.authHelper
                        .signUp(emailCOntroller.text, passwordCOntroller.text);
                  }
                },
                child: Text('Add New Auther')),
          ],
        ),
      ),
    );
  }
}
