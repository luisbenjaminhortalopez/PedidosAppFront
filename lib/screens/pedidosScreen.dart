import 'package:flutter/material.dart';
import 'package:pedidos_app/widgets/PedidoCard.dart';
import 'package:pedidos_app/widgets/menuDrawer.dart';



class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PendingOrdersScreenState createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PedidosScreen> {
  bool _filterDelivered = false;
  bool _filterNotDelivered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos Pendientes'),
      ),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrar por:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: _filterDelivered,
                  onChanged: (value) {
                    setState(() {
                      _filterDelivered = value!;
                    });
                  },
                ),
                const Text('Entregados'),
                const SizedBox(width: 16),
                Checkbox(
                  value: _filterNotDelivered,
                  onChanged: (value) {
                    setState(() {
                      _filterNotDelivered = value!;
                    });
                  },
                ),
                const Text('No entregados'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Puedes ajustar el número de tarjetas
                itemBuilder: (context, index) {
                  return OrderCard(
                    orderId: 'Pedido #${index + 1}',
                    customerName: 'Cliente ${index + 1}',
                    product: 'Producto ${index + 1}',
                    status: index % 2 == 0 ? 'Entregado' : 'No entregado',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}