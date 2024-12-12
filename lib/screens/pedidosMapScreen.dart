import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidosMapScreen extends StatefulWidget {
  const PedidosMapScreen({super.key});

  @override
  State<PedidosMapScreen> createState() => _PedidosMapScreenState();
}

class _PedidosMapScreenState extends State<PedidosMapScreen> {
  late GoogleMapController mapController;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    const url = 'http://localhost:3001/api/orders';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> orders = jsonDecode(response.body);

        setState(() {
          _markers.clear();
          for (var order in orders) {
            final double? lat = order['lat'] is num ? order['lat'].toDouble() : null;
            final double? lng = order['lng'] is num ? order['lng'].toDouble() : null;
            final String customerName = order['customerName'] ?? 'Cliente desconocido';
            final String customerAddress = order['customerAddress'] ?? 'Dirección no proporcionada';

            // Validar que lat y lng sean válidos
            if (lat != null &&
                lng != null &&
                lat >= -90 &&
                lat <= 90 &&
                lng >= -180 &&
                lng <= 180) {
              _markers.add(
                Marker(
                  markerId: MarkerId('$lat,$lng'),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(
                    title: customerName,
                    snippet: customerAddress,
                  ),
                ),
              );
            } else {
              debugPrint('Pedido con coordenadas inválidas: lat=$lat, lng=$lng');
            }
          }
        });
      } else {
        throw Exception('Error al obtener los pedidos: ${response.statusCode}');
      }
    } catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Pedidos'),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.126724, -101.685444),
          zoom: 13,
        ),
        markers: Set<Marker>.of(_markers),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchOrders,
        backgroundColor: const Color(0xFF21BF73),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}


//Se coloco el metodo que acciona la camara para el uso de la aplicacion 