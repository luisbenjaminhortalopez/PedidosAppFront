import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetallePedidoScreen extends StatelessWidget {
  final String customerName;
  final String customerAddress;
  final String customerMail;
  final double lat;
  final double lng;
  final bool isSentMailOrder;
  final bool isSentDeliveryMail;
  final bool deliveryStatus;
  final DateTime creationDate;

  const DetallePedidoScreen({
    super.key,
    required this.customerName,
    required this.customerAddress,
    required this.customerMail,
    required this.lat,
    required this.lng,
    required this.isSentMailOrder,
    required this.isSentDeliveryMail,
    required this.deliveryStatus,
    required this.creationDate,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(creationDate);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cliente: $customerName',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Dirección: $customerAddress',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Correo: $customerMail',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Coordenadas: Latitud $lat, Longitud $lng',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Pedido creado: $formattedDate',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Correo de confirmación enviado: ${isSentMailOrder ? "Sí" : "No"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Correo de entrega enviado: ${isSentDeliveryMail ? "Sí" : "No"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Estado del pedido: ${deliveryStatus ? "Entregado" : "No entregado"}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: deliveryStatus
                            ? const Color(0xFF21BF73) // Verde para entregado
                            : const Color(0xFFFF4C29), // Rojo para no entregado
                      ),
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
