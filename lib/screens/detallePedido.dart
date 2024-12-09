import 'package:flutter/material.dart';

class DetallePedidoScreen extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String product;
  final String status;

  const DetallePedidoScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.product,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Pedido'),
        backgroundColor: const Color(0xFF1B1B2F),
        foregroundColor: const Color(0xFFF4F4F8),
      ),
      body: Container(
        color: const Color(0xFF162447), 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Card(
              color: const Color(0xFF1F4068), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      orderId,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Cliente: $customerName',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, 
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Producto: $product',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, 
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Estado: $status',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: status == 'Entregado'
                            ? const Color(0xFF21BF73) 
                            : const Color(0xFFFF4C29), 
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
