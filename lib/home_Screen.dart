import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos desde Firebase'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('persona').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var document = data.docs[index].data() as Map<String, dynamic>;
              String nombre = document['nombre'] ?? 'No especificado';
              int edad = document['edad'] ?? 0;

              return ListTile(
                title: Text('Nombre: $nombre'),
                subtitle: Text('Edad: $edad'),
              );
            },
          );
        },
      ),
    );
  }
}

