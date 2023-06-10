import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/main_admin_screen.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/providers/auth_provider.dart';
import 'package:firebase_app/customer/views/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerMainPage extends StatefulWidget {
  @override
  State<CustomerMainPage> createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {
  int currentIndex = 0;

  updateIndex(x, v) {
    currentIndex = x;
    setState(() {});
  }

  goToWebsite(String url) async {
    // "whatsapp://send?phone=$number&text=${Uri.encodeFull('message')}"
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        actions: [
          IconButton(
              onPressed: () {
                // search delegate
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout)),
          Provider.of<AuthProvider>(context).loggedUser!.isAdmin
              ? IconButton(
                  onPressed: () {
                    AppRouter.appRouter.goToWidget(MainAdminScreen());
                  },
                  icon: Icon(Icons.settings))
              : SizedBox()
        ],
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.allSliders == null
                  ? SizedBox(
                      height: 220,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: 220,
                              onPageChanged: updateIndex,
                              autoPlay: true,
                              viewportFraction: 1),
                          items: provider.allSliders!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    // goToWebsite(i.url!);
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration:
                                          BoxDecoration(color: Colors.amber),
                                      child: Image.network(
                                        i.imageUrl!,
                                        fit: BoxFit.cover,
                                      )),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(provider.allSliders!.length,
                              (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              height: index == currentIndex ? 10 : 8,
                              width: index == currentIndex ? 10 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == currentIndex
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
              Expanded(
                child: provider.allCategories == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Categories',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemCount: provider.allCategories!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          provider.getAllProducts(
                                              provider
                                                  .allCategories![index].id!,
                                              provider
                                                  .allCategories![index].name);
                                          AppRouter.appRouter.goToWidget(
                                              AllProductsScreen(provider
                                                  .allCategories![index]));
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            provider
                                                .allCategories![index].imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
