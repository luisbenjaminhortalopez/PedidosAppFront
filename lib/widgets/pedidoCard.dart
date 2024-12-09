import 'package:flutter/material.dart';
import 'package:pedidos_app/screens/detallePedido.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallePedidoScreen(
              orderId: orderId,
              customerName: customerName,
              product: product,
              status: status,
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF1E1E2C), 
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0xFF4E4E61), width: 1), 
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700), 
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Cliente: $customerName',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, 
                ),
              ),
              Text(
                'Producto: $product',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'Estado: $status',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
