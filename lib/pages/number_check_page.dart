import 'package:flutter/material.dart';

class NumberCheckPage extends StatefulWidget {
  const NumberCheckPage({super.key});

  @override
  State<NumberCheckPage> createState() => _NumberCheckPageState();
}

class _NumberCheckPageState extends State<NumberCheckPage> {
  final _angkaController = TextEditingController();
  
  // Kasih nilai default strip biar layarnya kelihatan bersih pas baru dibuka
  String _hasilGanjilGenap = '-';
  String _hasilPrima = '-';

  void _cekAngka() {
    int? angka = int.tryParse(_angkaController.text);

    if (angka == null) {
      setState(() {
        _hasilGanjilGenap = 'Error';
        _hasilPrima = 'Input tidak valid';
      });
      return; 
    }

    String ganjilGenap = (angka % 2 == 0) ? 'Genap' : 'Ganjil';
    
    String prima = 'Prima'; // Disingkat biar muat di kotak
    if (angka <= 1) {
      prima = 'Bukan Prima'; 
    } else {
      for (int i = 2; i <= angka ~/ 2; i++) {
        if (angka % i == 0) {
          prima = 'Bukan Prima';
          break; 
        }
      }
    }

    setState(() {
      _hasilGanjilGenap = ganjilGenap;
      _hasilPrima = prima;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Background seragam
      appBar: AppBar(title: const Text('Cek Ganjil & Prima')),
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
                // Icon ungu buat pemanis
                const Icon(Icons.psychology, size: 80, color: Colors.purple),
                const SizedBox(height: 20),
                
                const Text(
                  'Analisis Angka Bulat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Angka',
                    prefixIcon: const Icon(Icons.tag), // Icon hashtag
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
                      backgroundColor: Colors.purple, // Tema ungu
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _cekAngka,
                    icon: const Icon(Icons.search, color: Colors.white),
                    label: const Text(
                      'Cek Sekarang',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(), 
                const SizedBox(height: 16),
                
                // Ini layout kiri-kanan buat nampilin hasil biar rapi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Kotak Kiri: Ganjil/Genap
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Status', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(
                            _hasilGanjilGenap,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              // Warnanya ganti-ganti tergantung hasil
                              color: _hasilGanjilGenap == 'Genap' ? Colors.blue : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Garis pemisah di tengah
                    Container(height: 40, width: 1, color: Colors.grey.shade300),
                    
                    // Kotak Kanan: Prima
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Jenis', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(
                            _hasilPrima,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _hasilPrima == 'Prima' ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}