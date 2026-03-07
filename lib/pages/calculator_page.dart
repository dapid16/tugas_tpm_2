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
    // Ubah text input jadi angka (double), kalau gagal jadikan 0
    double angka1 = double.tryParse(_angka1Controller.text) ?? 0;
    double angka2 = double.tryParse(_angka2Controller.text) ?? 0;
    double hasilHitung = 0;

    setState(() {
      if (operasi == 'tambah') {
        hasilHitung = angka1 + angka2;
      } else if (operasi == 'kurang') {
        hasilHitung = angka1 - angka2;
      }
      _hasil = hasilHitung.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _angka1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Angka Pertama'),
            ),
            TextField(
              controller: _angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Angka Kedua'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _hitung('tambah'),
                  child: const Text('Tambah (+)'),
                ),
                ElevatedButton(
                  onPressed: () => _hitung('kurang'),
                  child: const Text('Kurang (-)'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Hasil: $_hasil',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}