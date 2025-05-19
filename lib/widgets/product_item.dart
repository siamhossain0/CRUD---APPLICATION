import 'package:api_intregation/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../screens/product_list_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _inProgress =false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      tileColor: Colors.purple.shade50,
      leading: SizedBox(
        height: 70,
        width: 50,
        child: Image.network(
          widget.product.productImage,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.image_outlined),
        ),
      ),

      title: Text(
        widget.product.productName,
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code :${widget.product.productCode} "),
          Text("Price : \$${widget.product.unitPrice}"),
          Text("Quantity: ${widget.product.quantity}"),
          Text("Total cost : \$${widget.product.totalPrice}"),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateProductScreen(product:widget.product,);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                label: Text("Edit"),
              ),
              TextButton.icon(
                onPressed: () =>_onTapDeleteProduct(),
                icon: Icon(Icons.delete_outline, color: Colors.red),
                label: Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapDeleteProduct(){
    showDialog(context: context, builder:(BuildContext context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      backgroundColor: Colors.grey.shade100,
      title: const Text("Delete!"),
      content: const Text("Are you want to delete this product?"),
      actions: [
        ElevatedButton.icon(onPressed: (){
          Navigator.pop(context);
          setState((){});
        },icon: const Icon(Icons.cancel,color: Colors.redAccent,),
            label:const Text("cancel")
        ),
        ElevatedButton.icon(onPressed: (){
          deleteProduct();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProductListScreen(),
    ),
    );
          setState(() {

          });
    },
            icon: const Icon(Icons.check,color: Colors.green,),
            label: const Text("Proceed"),
        style: ElevatedButton.styleFrom(backgroundColor:Colors.green.shade100),)
      ],
    )
    );
  }

  Future<void> deleteProduct() async{
    _inProgress =true;
    setState(() {
    });
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}");
    Response response = await get(uri);

    print(response);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully product deleted.")));
      setState(() {
      });
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product delete failed.")));
      setState(() {
      });
    }
    _inProgress =false;
    setState(() {

    });


  }
}
