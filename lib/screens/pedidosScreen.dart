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
        title: const Text('Pedidos '),
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
                'Filtrar por:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
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
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF1F4068), 
                  ),
                  const Text(
                    'Entregados',
                    style: TextStyle(color: Colors.white), 
                  ),
                  const SizedBox(width: 16),
                  Checkbox(
                    value: _filterNotDelivered,
                    onChanged: (value) {
                      setState(() {
                        _filterNotDelivered = value!;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF1F4068), 
                  ),
                  const Text(
                    'No entregados',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, 
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
      ),
    );
  }
}
