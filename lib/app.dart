import 'package:api_intregation/screens/mybag.dart';
import 'package:api_intregation/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}
