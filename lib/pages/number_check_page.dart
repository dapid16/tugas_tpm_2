import 'package:flutter/material.dart';

class NumberCheckPage extends StatefulWidget {
  const NumberCheckPage({super.key});

  @override
  State<NumberCheckPage> createState() => _NumberCheckPageState();
}

class _NumberCheckPageState extends State<NumberCheckPage> {
  final _angkaController = TextEditingController();
  String _hasilGanjilGenap = '';
  String _hasilPrima = '';

  void _cekAngka() {
    int? angka = int.tryParse(_angkaController.text);

    if (angka == null) {
      setState(() {
        _hasilGanjilGenap = 'Error: Masukkan angka bulat yang valid!';
        _hasilPrima = '';
      });
      return;
    }

    String ganjilGenap = (angka % 2 == 0) ? 'Genap' : 'Ganjil';

    String prima = 'Bilangan Prima';
    if (angka <= 1) {
      prima = 'Bukan Bilangan Prima'; 
    } else {
      // Cek apakah angka bisa dibagi oleh bilangan lain selain 1 dan dirinya sendiri
      for (int i = 2; i <= angka ~/ 2; i++) {
        if (angka % i == 0) {
          prima = 'Bukan Bilangan Prima';
          break;
        }
      }
    }

    // Update UI
    setState(() {
      _hasilGanjilGenap = 'Angka $angka adalah bilangan $ganjilGenap';
      _hasilPrima = 'Angka $angka adalah $prima';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Ganjil/Genap & Prima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan Angka Bulat'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cekAngka,
              child: const Text('Cek Angka'),
            ),
            const SizedBox(height: 30),
            Text(
              _hasilGanjilGenap,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _hasilPrima,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}