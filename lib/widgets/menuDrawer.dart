import 'package:flutter/material.dart';


class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration:  BoxDecoration(
              color: Colors.blueGrey,
            ),
            child:  Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Menú'),
            onTap: () {
              Navigator.pop(context); // Cierra el menú
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_forward),
            title: const Text('Pantalla 2'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.pending_actions),
            title: const Text('Pedidos Pendientes'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => PendingOrdersScreen()));
            },
          ),
        ],
      ),
    );
  }
}
