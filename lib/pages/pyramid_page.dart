import 'package:flutter/material.dart';
import 'dart:math';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  // ── Warna tema dark disamain sama Calculator & Home ─────────
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  // Warna aksen Pink/Magenta sesuai icon di HomePage
  static const _grad1 = Color(0xFF880E4F); 
  static const _grad2 = Color(0xFFD81B60);

  final _sisiController = TextEditingController();
  final _tinggiController = TextEditingController();

  String _tipePiramida = 'Segi Empat'; 
  String _hasilVolume = '0';
  String _hasilLuas = '0';

  @override
  void dispose() {
    _sisiController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  void _hitungPiramida() {
    String textSisi = _sisiController.text.trim();
    String textTinggi = _tinggiController.text.trim();

    if (textSisi.isEmpty || textTinggi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Panjang sisi dan tinggi piramida wajib diisi semua!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return; 
    }

    double? sisi = double.tryParse(textSisi);
    double? tinggi = double.tryParse(textTinggi);

    if (sisi == null || tinggi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Input harus berupa angka yang valid!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (sisi <= 0 || tinggi <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ukuran bangun ruang harus lebih besar dari 0!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    double luasAlas = 0;
    double luasPermukaan = 0;
    double volume = 0;

    if (_tipePiramida == 'Segi Empat') {
      luasAlas = sisi * sisi;
      double tinggiSisiTegak = sqrt(pow(sisi / 2, 2) + pow(tinggi, 2));
      luasPermukaan = luasAlas + (4 * (0.5 * sisi * tinggiSisiTegak));
      volume = (1 / 3) * luasAlas * tinggi;

    } else if (_tipePiramida == 'Segitiga') {
      luasAlas = (sqrt(3) / 4) * pow(sisi, 2);
      double apotemaAlas = (sisi * sqrt(3)) / 6;
      double tinggiSisiTegak = sqrt(pow(apotemaAlas, 2) + pow(tinggi, 2));
      luasPermukaan = luasAlas + (3 * (0.5 * sisi * tinggiSisiTegak));
      volume = (1 / 3) * luasAlas * tinggi;
    }

    setState(() {
      _hasilLuas = luasPermukaan.toStringAsFixed(2);
      _hasilVolume = volume.toStringAsFixed(2); 
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
        title: const Text('Luas & Volume Piramida',
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
                // Icon Header (Gradient Pink/Magenta)
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
                        color: _grad1.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.change_history_rounded, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 24),
                
                Text(
                  'Kalkulator Limas $_tipePiramida',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hitung dimensi luas permukaan dan volume dari bangun ruang piramida.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white54),
                ),
                const SizedBox(height: 32),

                // --- DROPDOWN BUAT MILIH TIPE PIRAMIDA ---
                DropdownButtonFormField<String>(
                  value: _tipePiramida,
                  dropdownColor: _bgCard, // Biar background dropdown tetep dark
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white54),
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Piramida',
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.category_rounded, color: Colors.white54),
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
                  items: ['Segi Empat', 'Segitiga'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Piramida $value'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _tipePiramida = newValue!;
                      _hasilLuas = '0';
                      _hasilVolume = '0';
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // --- INPUT SISI ---
                TextField(
                  controller: _sisiController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    labelText: _tipePiramida == 'Segi Empat' ? 'Panjang Sisi Persegi (Alas)' : 'Panjang Sisi Segitiga (Alas)',
                    labelStyle: const TextStyle(color: Colors.white54),
                    hintText: 'Masukkan nilai sisi',
                    hintStyle: const TextStyle(color: Colors.white24),
                    prefixIcon: const Icon(Icons.square_foot_rounded, color: Colors.white54),
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
                const SizedBox(height: 16),
                
                // --- INPUT TINGGI ---
                TextField(
                  controller: _tinggiController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Tinggi Piramida (Limas)',
                    labelStyle: const TextStyle(color: Colors.white54),
                    hintText: 'Masukkan nilai tinggi',
                    hintStyle: const TextStyle(color: Colors.white24),
                    prefixIcon: const Icon(Icons.height_rounded, color: Colors.white54),
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
                
                // --- TOMBOL HITUNG ---
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
                      shadowColor: _grad1.withOpacity(0.4),
                    ),
                    onPressed: _hitungPiramida,
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
                            Icon(Icons.calculate_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Hitung Dimensi',
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
                
                // --- KOTAK HASIL ---
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
                      Expanded(
                        child: Column(
                          children: [
                            const Text('LUAS PERMUKAAN', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 12),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                _hasilLuas,
                                style: TextStyle(
                                  fontSize: 26, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.pink.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 50, width: 1, color: Colors.white10),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('VOLUME TOTAL', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 12),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                _hasilVolume,
                                style: const TextStyle(
                                  fontSize: 26, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.white,
                                ),
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