import 'package:flutter/material.dart';
import 'package:pedidos_app/screens/pedidosScreen.dart';
import 'package:pedidos_app/widgets/menuDrawer.dart';

class RegistrarPedidoScreen extends StatelessWidget {
  RegistrarPedidoScreen({super.key});

  final _formKeyClientInfo = GlobalKey<FormState>();
  final _formKeyCoordinates = GlobalKey<FormState>();

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
                        label: 'Nombre del Cliente', accentColor: accentColor),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                        label: 'Correo electrónico', accentColor: accentColor),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                        label: 'Dirección del cliente',
                        accentColor: accentColor),
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
                          label: 'Latitud', accentColor: accentColor),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildTextField(
                          label: 'Longitud', accentColor: accentColor),
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
                  onPressed: () {
                    if (_formKeyClientInfo.currentState!.validate() &&
                        _formKeyCoordinates.currentState!.validate()) {
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

  Widget _buildTextField({required String label, required Color accentColor}) {
    return TextFormField(
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
