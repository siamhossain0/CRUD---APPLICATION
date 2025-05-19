import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _qualityTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  void initState() {
    _productNameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _imageTEController.text = widget.product.productImage;
    _codeTEController.text = widget.product.productCode;
    _qualityTEController.text = widget.product.quantity;
    _totalPriceTEController.text = widget.product.totalPrice;

    _qualityTEController.addListener(_calculateTotalPrice);
    _unitPriceTEController.addListener(_calculateTotalPrice);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
      body:
          _inProgress
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(key: _formkey, child: _buildNewProductForm()),
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
        ),
        TextFormField(
          controller: _unitPriceTEController,
          decoration: const InputDecoration(
            hintText: "Unit Price",
            labelText: "Unit price",
          ),
        ),
        TextFormField(
          controller: _imageTEController,
          decoration: const InputDecoration(
            hintText: "Image",
            labelText: "Product image",
          ),
        ),
        TextFormField(
          controller: _codeTEController,
          decoration: const InputDecoration(
            hintText: "Product code",
            labelText: "Product code",
          ),
        ),
        TextFormField(
          controller: _qualityTEController,
          decoration: const InputDecoration(
            hintText: "Quantity",
            labelText: "Quantity",
          ),
        ),
        TextFormField(
          controller: _totalPriceTEController,
          readOnly: true,
          decoration: const InputDecoration(
            hintText: "Total price",
            labelText: "Total Price",
          ),
        ),

        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.red.shade100,
          ),
          onPressed: _onTapAddProductButton,
          child: const Text("UPDATE"),
        ),
      ],
    );
  }

  void _onTapAddProductButton() {
    if (_formkey.currentState!.validate()) {
      updateProduct(widget.product.id);
    }
  }
  void _calculateTotalPrice(){
    final qty = int.tryParse(_qualityTEController.text)?? 0;
    final unitPrice = int.tryParse(_unitPriceTEController.text)?? 0;
    final total =qty*unitPrice;
    _totalPriceTEController.text = total.toString();
  }

  Future<void> updateProduct(String id) async {
    _inProgress = true;
    setState(() {});
    Uri url = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/$id");
    Map<String, dynamic> requestBody = {
      "img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _productNameTEController.text.trim(),
      "Qty": _qualityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _unitPriceTEController.text.trim(),
    };
    Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update data Successfully.")),
      );
      setState(() {});
      Navigator.pop(context);
    }
    _inProgress = false;
    setState(() {});
  }

  void _cleanText() {
    _productNameTEController.clear();
    _qualityTEController.clear();
    _unitPriceTEController.clear();
    _codeTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();

    setState(() {});
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _qualityTEController.removeListener(_calculateTotalPrice);
    _unitPriceTEController.removeListener(_calculateTotalPrice);
    _qualityTEController.dispose();
    _unitPriceTEController.dispose();
    _codeTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
