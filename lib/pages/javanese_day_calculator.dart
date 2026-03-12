import 'package:flutter/material.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Weton', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(),
    );
  }
}