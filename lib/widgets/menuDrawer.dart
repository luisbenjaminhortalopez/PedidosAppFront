import 'package:flutter/material.dart';
import 'package:pedidos_app/screens/pedidosMapScreen.dart';
import 'package:pedidos_app/screens/pedidosScreen.dart';
import 'package:pedidos_app/screens/registrarPedidoScreen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF162447), 
        child: ListView(
          children: [
           const DrawerHeader(
              decoration:  BoxDecoration(
                color: Color(0xFF1F4068), 
              ),
              child:  Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: Colors.white),
              title: const Text(
                'Registrar pedido',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrarPedidoScreen()),
                );
              },
              tileColor: Colors.transparent, 
              hoverColor: const Color(0xFF1B1B2F), 
            ),
            const Divider(color: Color(0xFF1B1B2F)), 
            ListTile(
              leading: const Icon(Icons.pending_actions, color: Colors.white),
              title: const Text(
                'Pedidos pendientes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PedidosScreen()),
                );
              },
              tileColor: Colors.transparent,
              hoverColor: const Color(0xFF1B1B2F),
            ),
            const Divider(color: Color(0xFF1B1B2F)),
            ListTile(
              leading: const Icon(Icons.map_rounded, color: Colors.white),
              title: const Text(
                'Mapa de pedidos',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PedidosMapScreen()),
                );
              },
              tileColor: Colors.transparent,
              hoverColor: const Color(0xFF1B1B2F),
            ),
          ],
        ),
      ),
    );
  }
}
