import 'package:flutter/material.dart';

class NumberCheckPage extends StatefulWidget {
  const NumberCheckPage({super.key});

  @override
  State<NumberCheckPage> createState() => _NumberCheckPageState();
}

class _NumberCheckPageState extends State<NumberCheckPage> {
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  static const _grad1 = Color(0xFF1B5E20); 
  static const _grad2 = Color(0xFF4CAF50);

  final _angkaController = TextEditingController();
  
  String _hasilGanjilGenap = '-';
  String _hasilPrima = '-';

  @override
  void dispose() {
    _angkaController.dispose();
    super.dispose();
  }

  void _cekAngka() {
    String text = _angkaController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Angkanya wajib diisi dulu ya!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    int? angka = int.tryParse(text);

    if (angka == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Input harus berupa angka bulat yang valid (tanpa koma)!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    String ganjilGenap = (angka % 2 == 0) ? 'Genap' : 'Ganjil';
    
    String prima = 'Prima'; 
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
      backgroundColor: _bgPage,
      appBar: AppBar(
        backgroundColor: _bgPage,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white60, size: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cek Ganjil & Prima',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Material(
          color: _bgCard,
          borderRadius: BorderRadius.circular(28),
          elevation: 8,
          shadowColor: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [_grad1, _grad2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _grad2.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.tag_rounded, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 24),
                
                const Text(
                  'Analisis Angka',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cek apakah angka tersebut ganjil/genap dan termasuk bilangan prima atau tidak.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white54),
                ),
                const SizedBox(height: 32),
                
                // Input Field
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Masukkan Angka',
                    labelStyle: const TextStyle(color: Colors.white54),
                    hintText: 'Contoh : 7',
                    hintStyle: const TextStyle(color: Colors.white24),
                    prefixIcon: const Icon(Icons.numbers_rounded, color: Colors.white54),
                    filled: true,
                    fillColor: _bgPage, 
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: _grad2, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Button Cek
                SizedBox(
                  width: double.infinity, 
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: _grad2.withOpacity(0.4),
                    ),
                    onPressed: _cekAngka,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_grad1, _grad2],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.search_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Cek Sekarang',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.white10, height: 1), 
                const SizedBox(height: 32),
                
                // Kotak Hasil
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                  decoration: BoxDecoration(
                    color: _grad2.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _grad2.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Kotak Ganjil/Genap
                      Expanded(
                        child: Column(
                          children: [
                            const Text('STATUS', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            const SizedBox(height: 12),
                            Text(
                              _hasilGanjilGenap,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: _hasilGanjilGenap == 'Genap' ? Colors.blue.shade400 : (_hasilGanjilGenap == 'Ganjil' ? Colors.orange.shade400 : Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Garis pemisah di tengah
                      Container(height: 50, width: 1, color: Colors.white10),
                      
                      // Kotak Prima
                      Expanded(
                        child: Column(
                          children: [
                            const Text('JENIS', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            const SizedBox(height: 12),
                            Text(
                              _hasilPrima,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: _hasilPrima == 'Prima' ? Colors.green.shade400 : (_hasilPrima == 'Bukan Prima' ? Colors.red.shade400 : Colors.white),
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