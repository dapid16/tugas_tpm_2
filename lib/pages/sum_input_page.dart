import 'package:flutter/material.dart';

class SumInputPage extends StatefulWidget {
  const SumInputPage({super.key});

  @override
  State<SumInputPage> createState() => _SumInputPageState();
}

class _SumInputPageState extends State<SumInputPage> {
  final _angkaController = TextEditingController();
  String _hasilTotal = '0';

  void _hitungTotal() {
    String input = _angkaController.text;

    List<String> listAngkaStr = input.replaceAll(',', ' ').split(RegExp(r'\s+'));

    double total = 0;

    for (String angkaStr in listAngkaStr) {
      double angka = double.tryParse(angkaStr) ?? 0;
      total += angka;
    }

    setState(() {
      _hasilTotal = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jumlah Total Angka')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Masukkan deretan angka dipisah spasi atau koma (Contoh: 10 20 30 atau 1,2,3)',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _angkaController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Input Deretan Angka',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitungTotal,
              child: const Text('Hitung Total'),
            ),
            const SizedBox(height: 30),
            Text(
              'Total Jumlah: $_hasilTotal',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}