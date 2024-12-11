import 'dart:convert'; // Para codificar y decodificar JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos_app/screens/pedidosScreen.dart';
import 'package:pedidos_app/widgets/menuDrawer.dart';

class RegistrarPedidoScreen extends StatelessWidget {
  RegistrarPedidoScreen({super.key});

  final _formKeyClientInfo = GlobalKey<FormState>();
  final _formKeyCoordinates = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  // Función para consumir la API
  Future<bool> createOrder({
    required double lat,
    required double lng,
    required String customerMail,
    required String customerName,
    required String customerAddress,
  }) async {
    const String apiUrl = 'http://localhost:3001/api/orders/createorder';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'lat': lat,
          'lng': lng,
          'customerMail': customerMail,
          'customerName': customerName,
          'customerAddress': customerAddress,
        }),
      );

      if (response.statusCode == 200) {
        print('Pedido creado con éxito: ${response.body}');
        return true;
      } else {
        print('Error al crear el pedido: ${response.statusCode}');
        print('Detalles: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1B1B2F);
    const accentColor = Color(0xFF5C7AEA);
    const textPrimary = Color(0xFFF4F4F8);
    const backgroundColor = Color(0xFF162447);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Pedido'),
        backgroundColor: primaryColor,
        foregroundColor: textPrimary,
      ),
      drawer: const MenuDrawer(),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información del cliente',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKeyClientInfo,
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Nombre del Cliente',
                      accentColor: accentColor,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                      label: 'Correo electrónico',
                      accentColor: accentColor,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                      label: 'Dirección del cliente',
                      accentColor: accentColor,
                      controller: _addressController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Coordenadas del pedido',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKeyCoordinates,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Latitud',
                        accentColor: accentColor,
                        controller: _latController,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildTextField(
                        label: 'Longitud',
                        accentColor: accentColor,
                        controller: _lngController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: textPrimary,
                  ),
                  onPressed: () async {
                    if (_formKeyClientInfo.currentState!.validate() &&
                        _formKeyCoordinates.currentState!.validate()) {
                      final lat = double.tryParse(_latController.text) ?? 0.0;
                      final lng = double.tryParse(_lngController.text) ?? 0.0;
                      final customerName = _nameController.text;
                      final customerMail = _emailController.text;
                      final customerAddress = _addressController.text;

                      final success = await createOrder(
                        lat: lat,
                        lng: lng,
                        customerMail: customerMail,
                        customerName: customerName,
                        customerAddress: customerAddress,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pedido registrado con éxito'),
                            backgroundColor: accentColor,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PedidosScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hubo un problema al registrar el pedido'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('ACEPTAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Color accentColor,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: accentColor),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        return null;
      },
    );
  }
}
