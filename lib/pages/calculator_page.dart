import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();
  String _hasil = '0';

  void _hitung(String operasi) {
    double angka1 = double.tryParse(_angka1Controller.text) ?? 0;
    double angka2 = double.tryParse(_angka2Controller.text) ?? 0;
    double hasilHitung = 0;

    setState(() {
      if (operasi == 'tambah') {
        hasilHitung = angka1 + angka2;
      } else if (operasi == 'kurang') {
        hasilHitung = angka1 - angka2;
      }

      // Trik biar angkanya rapi. Kalau hasilnya bulat, ilangin .0 di belakangnya
      if (hasilHitung == hasilHitung.toInt()) {
        _hasil = hasilHitung.toInt().toString();
      } else {
        _hasil = hasilHitung.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Warna background seragam
      appBar: AppBar(title: const Text('Kalkulator')),
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
                // Icon pemanis di atas
                const Icon(Icons.calculate, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _angka1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Angka Pertama',
                    prefixIcon: const Icon(Icons.looks_one), // Icon angka 1
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Melengkung
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _angka2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Angka Kedua',
                    prefixIcon: const Icon(Icons.looks_two), // Icon angka 2
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                Row(
                  children: [
                    // Expanded bikin tombolnya otomatis bagi dua ruang yang sama besar
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _hitung('tambah'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Tambah', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16), // Jarak antar tombol
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.orange, // Warnanya beda
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _hitung('kurang'),
                        icon: const Icon(Icons.remove, color: Colors.white),
                        label: const Text('Kurang', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(), // Garis pembatas sebelum hasil
                const SizedBox(height: 16),
                
                const Text(
                  'Hasil Perhitungan',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  _hasil,
                  style: const TextStyle(
                    fontSize: 48, // Angka hasil dibikin super gede
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Warna ijo biar ngejreng
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