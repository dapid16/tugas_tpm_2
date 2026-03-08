import 'package:flutter/material.dart';
import 'dart:math';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final _sisiController = TextEditingController();
  final _tinggiController = TextEditingController();

  String _hasilVolume = '0';
  String _hasilLuas = '0';

  void _hitungPiramida() {
    double sisi = double.tryParse(_sisiController.text) ?? 0;
    double tinggi = double.tryParse(_sisiController.text) ?? 0;
    double tinggiSisiTengak = sqrt(pow(sisi / 2, 2) + pow(tinggi, 2));

    double luasAlas = sisi * sisi;
    double luas = luasAlas + (4 * (0.5 * sisi * tinggiSisiTengak));
    double volume = luasAlas * tinggi * (1 / 3);

    setState(() {
      _hasilLuas = luas.toStringAsFixed(2);
      _hasilVolume = volume.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hitung Luas dan Volume Piramida')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Masukkan Nilai Tinggi dan Sisi Alas Piramida(Limas Segi Empat)',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sisiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sisi Alas',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tinggi Piramid',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _hitungPiramida,
              child: const Text('Hitung Total'),
            ),
            const SizedBox(height: 30),

            Text(
              'Luas Permukaan Piramida : $_hasilLuas',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            Text(
              'Volume Piramida : $_hasilVolume',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
    // TextField(
    //   controller: _sisiController,
    //   keyboardType: TextInputType.number,
    //   decoration: const InputDecoration(
    //   labelText: 'Sisi Alas',
    //   border: OutlineInputBorder(),
    // ),
    // )
  }
}
