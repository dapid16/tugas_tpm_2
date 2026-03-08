import 'package:flutter/material.dart';

class SumInputPage extends StatefulWidget {
  const SumInputPage({super.key});

  @override
  State<SumInputPage> createState() => _SumInputPageState();
}

class _SumInputPageState extends State<SumInputPage> {
  final _angkaController = TextEditingController();
  
  String _hasilTotal = '0';
  String _banyakDigit = '0';
  String _rincian = '-';

  void _hitungTotal() {
    String input = _angkaController.text;
    int total = 0;
    List<String> rincianList = [];

    // Loop buat misahin tiap angka dan dijumlahin
    for (int i = 0; i < input.length; i++) {
      int? angka = int.tryParse(input[i]);
      if (angka != null) {
        total += angka;
        rincianList.add(angka.toString());
      }
    }

    setState(() {
      _hasilTotal = total.toString();
      _banyakDigit = rincianList.length.toString();
      // Gabungin list pakai tanda tambah buat pamer UI
      _rincian = rincianList.isNotEmpty ? rincianList.join(' + ') : '-';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Jumlah Total Angka')),
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
                const Icon(Icons.add_circle, size: 80, color: Colors.teal),
                const SizedBox(height: 20),
                
                const Text(
                  'Kalkulator Digit Angka',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Deret Angka (Cth: 1234)',
                    prefixIcon: const Icon(Icons.pin),
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
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _hitungTotal,
                    icon: const Icon(Icons.functions, color: Colors.white),
                    label: const Text(
                      'Hitung Sekarang',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 16),
                
                // Kotak khusus buat nampilin hasil biar eksklusif
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50, // Latar belakang transparan dikit
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Rincian Perhitungan:', 
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _rincian,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, letterSpacing: 2),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white), // Garis putih pembatas
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Banyak Digit', style: TextStyle(color: Colors.grey)),
                              Text(
                                _banyakDigit,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Total Jumlah', style: TextStyle(color: Colors.grey)),
                              Text(
                                _hasilTotal,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                              ),
                            ],
                          ),
                        ],
                      )
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