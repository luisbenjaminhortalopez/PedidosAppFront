import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pedidos_app/widgets/menuDrawer.dart';
import 'detallePedido.dart';

class Order {
  final String id;
  final String customerName;
  final bool deliveryStatus;
  final String customerAddress;
  final String customerMail;
  final double lat;
  final double lng;
  final bool isSentMailOrder;
  final bool isSentDeliveryMail;
  final DateTime creationDate;

  Order({
    required this.id,
    required this.customerName,
    required this.deliveryStatus,
    required this.customerAddress,
    required this.customerMail,
    required this.lat,
    required this.lng,
    required this.isSentMailOrder,
    required this.isSentDeliveryMail,
    required this.creationDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      customerName: json['customerName'],
      deliveryStatus: json['deliveryStatus'],
      customerAddress: json['customerAddress'],
      customerMail: json['customerMail'],
      lat: json['lat'],
      lng: json['lng'],
      isSentMailOrder: json['isSentMailOrder'],
      isSentDeliveryMail: json['isSentDeliveryMail'],
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    const String url = 'http://localhost:3001/api/orders';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _orders = data.map((orderJson) => Order.fromJson(orderJson)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: const Color(0xFF1B1B2F),
        foregroundColor: const Color(0xFFF4F4F8),
      ),
      drawer: const MenuDrawer(),
      body: Container(
        color: const Color(0xFF162447),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pedidos:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _orders.length,
                        itemBuilder: (context, index) {
                          final order = _orders[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFF1F4068),
                            child: ListTile(
                              title: Text(
                                'Pedido de ${order.customerName}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Status: ${order.deliveryStatus ? 'Entregado' : 'No entregado'}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              onTap: () async {
                                final updatedOrder = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetallePedidoScreen(
                                      customerName: order.customerName,
                                      customerAddress: order.customerAddress,
                                      customerMail: order.customerMail,
                                      lat: order.lat,
                                      lng: order.lng,
                                      isSentMailOrder: order.isSentMailOrder,
                                      isSentDeliveryMail: order.isSentDeliveryMail,
                                      deliveryStatus: order.deliveryStatus,
                                      creationDate: order.creationDate,
                                      orderId: order.id,
                                    ),
                                  ),
                                );

                                if (updatedOrder != null && updatedOrder['deliveryStatus'] != null) {
                                  setState(() {
                                    _orders[index] = Order(
                                      id: order.id,
                                      customerName: order.customerName,
                                      deliveryStatus: updatedOrder['deliveryStatus'],
                                      customerAddress: order.customerAddress,
                                      customerMail: order.customerMail,
                                      lat: order.lat,
                                      lng: order.lng,
                                      isSentMailOrder: order.isSentMailOrder,
                                      isSentDeliveryMail: order.isSentDeliveryMail,
                                      creationDate: order.creationDate,
                                    );
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
