import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
 const OrderCard({super.key, 
    required this.orderId,
    required this.customerName,
    required this.product,
    required this.status,
  });
    final String orderId;
  final String customerName;
  final String product;
  final String status;

  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderId,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
           const  SizedBox(height: 8.0),
            Text('Cliente: $customerName'),
            Text('Producto: $product'),
            Text('Estado: $status'),
          ],
        ),
      ),
    );
  }
}