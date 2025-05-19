import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productNameTEController =
  TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _qualityTEController = TextEditingController();
  bool _inProgress = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add NEw Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(key: _formkey, child: _buildNewProductForm()),
        ),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Column(
      children: [
        TextFormField(
          controller: _productNameTEController,
          decoration: const InputDecoration(
            hintText: "Name",
            labelText: "Product Name",
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Enter a valid Product name";
            }
            return null;
          },
        ),
        TextFormField(
          controller: _unitPriceTEController,
          decoration: const InputDecoration(
            hintText: "Unit Price",
            labelText: "Unit price",
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Enter a valid unit price";
            }
            return null;
          },
        ),
        TextFormField(
          controller: _imageTEController,
          decoration: const InputDecoration(
            hintText: "Image",
            labelText: "Product Image",
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Enter a valid product image";
            }
            return null;
          },
        ),
        TextFormField(
          controller: _codeTEController,
          decoration: const InputDecoration(
            hintText: "Product code",
            labelText: "Product code",
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Enter a valid Product code";
            }
            return null;
          },
        ),
        TextFormField(
          controller: _qualityTEController,
          decoration: const InputDecoration(
            hintText: "Quantity",
            labelText: "Quantity",
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Enter a valid quantity";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _inProgress
            ? Center(child: CircularProgressIndicator())
            : ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
          ),
          onPressed: _onTapAddProductButton,
          child: const Text(" Add Product"),
        ),
      ],
    );
  }

  void _onTapAddProductButton() {
    if (_formkey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
    Map<String, dynamic> requestBody = {
      "img": _imageTEController.text,
      "ProductCode": _codeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _qualityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _clearTextFields();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("New product added")));
    }
    _inProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _productNameTEController.clear();
    _qualityTEController.clear();
    _unitPriceTEController.clear();
    _codeTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _qualityTEController.dispose();
    _unitPriceTEController.dispose();
    _codeTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
