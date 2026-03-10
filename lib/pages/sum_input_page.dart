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

  @override
  void dispose(){
    _angkaController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: const Text('Jumlah Total Angka', style: TextStyle(fontWeight: FontWeight.bold),),
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
                    color: Colors.teal.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add_circle, size: 60, color: Colors.teal.shade600),
                ),
                const SizedBox(height: 20),
                
                Text(
                  'Kalkulator Digit Angka',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey.shade800),
                ),
                const SizedBox(height: 24),
                
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Deret Angka',
                    hintText: '(Cth: 1234)',
                    prefixIcon: const Icon(Icons.pin),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal.shade400),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _hitungTotal,
                    icon: const Icon(Icons.functions, color: Colors.white),
                    label: const Text(
                      'Hitung Sekarang',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.black12,),
                const SizedBox(height: 24),
                
                // Kotak khusus buat nampilin hasil biar eksklusif
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50, // Latar belakang transparan dikit
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Rincian Perhitungan:', 
                        style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _rincian,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, 
                          letterSpacing: 2,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.teal.shade200, thickness: 1,), // Garis putih pembatas
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('BANYAK DIGIT', style: TextStyle(color: Colors.teal.shade600, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 8,),
                              Text(
                                _banyakDigit,
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                              ),
                            ],
                          ),
                          Container(height: 40, width: 1, color: Colors.teal.shade200,),
                          Column(
                            children: [
                              Text('TOTAL JUMLAH', style: TextStyle(color: Colors.teal.shade600, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 8,),
                              Text(
                                _hasilTotal,
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
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