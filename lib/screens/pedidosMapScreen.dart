import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PedidosMapScreen extends StatefulWidget {
  const PedidosMapScreen({super.key});

  @override
  State<PedidosMapScreen> createState() => _PedidosMapScreenState();
}

class _PedidosMapScreenState extends State<PedidosMapScreen> {
  late GoogleMapController mapController;
 void onTap(LatLng position){
print (position.toString());
showDialog(context: context, builder: (BuildContext context){
return  AlertDialog(
  title: const Text("Agregar incidente"),
  actions: [
    TextButton(onPressed: (){
      Navigator.of(context).pop();
    }, child: const Text("Cancelar")),
    TextButton(onPressed: (){
      Navigator.of(context).pop();
    }, child: const Text("Aceptar"))
  ],
);
});
 }
  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      onMapCreated: (controller){
        mapController = controller;
      },
      initialCameraPosition: const CameraPosition
      (target: LatLng(21.126724, -101.685444), zoom: 13),
    onTap: onTap,
    );
  }
}