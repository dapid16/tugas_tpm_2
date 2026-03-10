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

  @override
  void dispose() {
    _sisiController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: const Text('Luas & Volume Piramida', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 5,
          shadowColor: Colors.blue.shade100,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.change_history, size: 80, color: Colors.orange),
                ),
                const SizedBox(height: 20),
                
                Text(
                  'Kalkulator Limas Segi Empat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 24),
                
                TextField(
                  controller: _sisiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Panjang Sisi Alas',
                    hintText: 'masukan Nilai Sisi',
                    prefixIcon: const Icon(Icons.square_foot),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.orange.shade400, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _tinggiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tinggi Piramida',
                    hintText: 'masukan Nilai Tinggi',
                    prefixIcon: const Icon(Icons.height),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.orange.shade400, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _hitungPiramida,
                    icon: const Icon(Icons.calculate, color: Colors.black87,),
                    label: const Text(
                      'Hitung Dimensi',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black87 ,letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.black12,),
                const SizedBox(height: 24),
                
                // Kotak Hasil
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('LUAS PERMUKAAN', style: TextStyle(color: Colors.orange.shade800, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilLuas,
                              style: const TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.orange
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 40, width: 1, color: Colors.orange.shade300),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Volume', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilVolume,
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.deepOrange.shade600,
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