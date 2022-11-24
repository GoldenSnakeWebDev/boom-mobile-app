import 'package:flutter/material.dart';

class FrensScreen extends StatelessWidget {
  const FrensScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frens"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemBuilder: (context, index) {
          return const ListTile();
        }),
      ),
    );
  }
}
