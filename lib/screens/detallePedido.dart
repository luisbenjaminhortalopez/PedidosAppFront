import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

/** Order Detail Window */
class DetallePedidoScreen extends StatefulWidget {
  final String customerName;
  final String customerAddress;
  final String customerMail;
  final double lat;
  final double lng;
  final bool isSentMailOrder;
  final bool isSentDeliveryMail;
  final bool deliveryStatus;
  final DateTime creationDate;
  final String orderId;

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
    required this.orderId,
  });

  @override
  State<DetallePedidoScreen> createState() => _DetallePedidoScreenState();
}

class _DetallePedidoScreenState extends State<DetallePedidoScreen> {
  bool _isUpdating = false;
  late bool _currentDeliveryStatus;

  @override
  void initState() {
    super.initState();
    _currentDeliveryStatus = widget.deliveryStatus;
  }

  Future<void> _markAsDelivered() async {
    setState(() {
      _isUpdating = true;
    });

    final url = 'http://localhost:3001/api/orders/delivered/${widget.orderId}';
    try {
      final response = await http.put(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _currentDeliveryStatus = true;
          _isUpdating = false;
        });

        Navigator.pop(context, {'id': widget.orderId, 'deliveryStatus': _currentDeliveryStatus});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El pedido ha sido marcado como entregado.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Error al marcar el pedido como entregado.');
      }
    } catch (e) {
      setState(() {
        _isUpdating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm').format(widget.creationDate);

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
                      'Cliente: ${widget.customerName}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Dirección: ${widget.customerAddress}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Correo: ${widget.customerMail}',
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
                    const SizedBox(height: 8.0),
                    Text(
                      'Estado del pedido: ${_currentDeliveryStatus ? "Entregado" : "No entregado"}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: _currentDeliveryStatus
                            ? const Color(0xFF21BF73) // Verde para entregado
                            : const Color(0xFFFF4C29), // Rojo para no entregado
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _isUpdating
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _currentDeliveryStatus ? null : _markAsDelivered,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF21BF73),
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                            ),
                            child: Text(
                              _currentDeliveryStatus
                                  ? 'Pedido Entregado'
                                  : 'Marcar como Entregado',
                              style: const TextStyle(fontSize: 16.0),
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
