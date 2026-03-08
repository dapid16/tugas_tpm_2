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
    double tinggi = double.tryParse(_tinggiController.text) ?? 0; 
    
    double tinggiSisiTegak = sqrt(pow(sisi / 2, 2) + pow(tinggi, 2));

    double luasAlas = sisi * sisi;
    double luas = luasAlas + (4 * (0.5 * sisi * tinggiSisiTegak));
    double volume = luasAlas * tinggi * (1 / 3);

    setState(() {
      _hasilLuas = luas.toStringAsFixed(2);
      _hasilVolume = volume.toStringAsFixed(2); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Luas & Volume Piramida')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.change_history, size: 80, color: Colors.orange),
                const SizedBox(height: 20),
                
                const Text(
                  'Kalkulator Limas Segi Empat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _sisiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Sisi Alas',
                    prefixIcon: const Icon(Icons.square_foot),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _tinggiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tinggi Piramida',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _hitungPiramida,
                    icon: const Icon(Icons.calculate, color: Colors.white),
                    label: const Text(
                      'Hitung Dimensi',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 16),
                
                // Kotak Hasil
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Luas Permukaan', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilLuas,
                              style: const TextStyle(
                                fontSize: 22, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.orange
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 40, width: 1, color: Colors.orange.shade200),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Volume', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilVolume,
                              style: const TextStyle(
                                fontSize: 22, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.deepOrange
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}