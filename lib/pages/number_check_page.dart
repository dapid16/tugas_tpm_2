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

  @override
  void dispose() {
    _angkaController.dispose();
    super.dispose();
  }

  void _cekAngka() {
    int? angka = int.tryParse(_angkaController.text);

    if (angka == null) {
      setState(() {
        _hasilGanjilGenap = 'Error';
        _hasilPrima = 'Tidak Valid';
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
      appBar: AppBar(
        title: const Text('Cek Ganjil & Prima', style: TextStyle(fontWeight: FontWeight.bold),),
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
                // Icon ungu buat pemanis
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.psychology, size: 60, color: Colors.purple.shade600)
                ),
                const SizedBox(height: 20),
                
                Text(
                  'Analisis Angka Bulat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Angka',
                    hintText: 'Contoh : 7',
                    prefixIcon: const Icon(Icons.tag), // Icon hashtag
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.purple.shade400),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity, 
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      foregroundColor: Colors.white, // Tema ungu
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _cekAngka,
                    icon: const Icon(Icons.search, color: Colors.white),
                    label: const Text(
                      'Cek Sekarang',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.black12,), 
                const SizedBox(height: 24),
                
                // Ini layout kiri-kanan buat nampilin hasil biar rapi
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Kotak Kiri: Ganjil/Genap
                      Expanded(
                        child: Column(
                          children: [
                            Text('Status', style: TextStyle(color: Colors.purple.shade300, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilGanjilGenap,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // Warnanya ganti-ganti tergantung hasil
                                color: _hasilGanjilGenap == 'Genap' ? Colors.blue.shade700 : (_hasilGanjilGenap == 'Ganjil' ? Colors.orange.shade700 : Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Garis pemisah di tengah
                      Container(height: 40, width: 1, color: Colors.purple.shade200),
                      
                      // Kotak Kanan: Prima
                      Expanded(
                        child: Column(
                          children: [
                            Text('JENIS', style: TextStyle(color: Colors.purple.shade300, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 8),
                            Text(
                              _hasilPrima,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _hasilPrima == 'Prima' ? Colors.green.shade700 : Colors.red.shade600,
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