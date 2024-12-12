import 'package:flutter/material.dart';
import 'package:pedidos_app/screens/pedidosScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Registro de Pedido',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme:const TextTheme(
          //bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home:  const PedidosScreen(),
    );
  }
}



