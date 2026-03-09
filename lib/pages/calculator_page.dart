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

  @override
  void dispose(){
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

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


      appBar: AppBar(
        title: const Text('Kalkulator',style: TextStyle(fontWeight: FontWeight.bold),),
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
                // Icon pemanis di atas
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.calculate, size: 60, color: Colors.blue.shade700),
                ),
                const SizedBox(height: 24),
                
                TextField(
                  controller: _angka1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Angka Pertama',
                    hintText: '0',
                    prefixIcon: const Icon(Icons.looks_one), // Icon angka 1
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Melengkung
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _angka2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Angka Kedua',
                    hintText: '0',
                    prefixIcon: const Icon(Icons.looks_two), // Icon angka 2
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                Row(
                  children: [
                    // Expanded bikin tombolnya otomatis bagi dua ruang yang sama besar
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _hitung('tambah'),
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 16), // Jarak antar tombol
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.orange.shade600, // Warnanya beda
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _hitung('kurang'),
                        icon: const Icon(Icons.remove,),
                        label: const Text('Kurang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.black12,), // Garis pembatas sebelum hasil
                const SizedBox(height: 24),
                
                const Text(
                  'Hasil Perhitungan',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 12,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200,),
                  ),
                  child: Text(
                    _hasil,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48, // Angka hasil dibikin super gede
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700, // Warna ijo biar ngejreng
                    ),
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