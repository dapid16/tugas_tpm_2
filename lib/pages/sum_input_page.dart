import 'package:flutter/material.dart';

class SumInputPage extends StatefulWidget {
  const SumInputPage({super.key});

  @override
  State<SumInputPage> createState() => _SumInputPageState();
}

class _SumInputPageState extends State<SumInputPage> {
  // ── Warna tema dark disamain sama Calculator & Home ─────────
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  // Warna aksen oranye sesuai dengan icon di HomePage
  static const _grad1 = Color(0xFFE65100); 
  static const _grad2 = Color(0xFFFF9800);

  final _inputController = TextEditingController();
  
  String _banyakKarakter = '0';
  String _banyakKata = '0'; 

  @override
  void dispose(){
    _inputController.dispose();
    super.dispose();
  }

  void _hitungKarakter() {
    String input = _inputController.text;

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Teksnya jangan dikosongin dong!'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return; 
    }

    setState(() {
      _banyakKarakter = input.length.toString();
      
      if (input.trim().isEmpty) {
        _banyakKata = '0';
      } else {
        _banyakKata = input.trim().split(RegExp(r'\s+')).length.toString();
      }
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
        title: const Text('Penghitung Karakter',
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
                // Icon Header (Gradient Orange)
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
                        color: _grad1.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.text_snippet_rounded, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 24),
                
                const Text(
                  'Analisis Teks Paragraf',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hitung jumlah karakter dan kata dari teks yang kamu ketikkan atau tempel di bawah ini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white54),
                ),
                const SizedBox(height: 32),
                
                // --- INI TEXTFIELD YANG UDAH DIKUNCI TINGGINYA & BISA DI-SCROLL DALEMNYA ---
                SizedBox(
                  height: 150, // Kunci tingginya di sini
                  child: TextField(
                    controller: _inputController,
                    maxLines: null, 
                    expands: true, 
                    textAlignVertical: TextAlignVertical.top, 
                    keyboardType: TextInputType.multiline, 
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      alignLabelWithHint: true, 
                      labelText: 'Ketik atau Paste Teks di Sini',
                      labelStyle: const TextStyle(color: Colors.white54),
                      hintText: 'Contoh: Pada suatu hari, hiduplah seorang programmer...',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: _bgPage, // Background textfield gelap
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
                ),
                const SizedBox(height: 24),
                
                // Tombol Hitung
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // Biar gradient full
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: _grad1.withOpacity(0.4),
                    ),
                    onPressed: _hitungKarakter,
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
                            Icon(Icons.analytics_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Hitung Sekarang',
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
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _grad2.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _grad2.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'HASIL ANALISIS', 
                        style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('TOTAL KARAKTER', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 12),
                              Text(
                                _banyakKarakter,
                                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.orange.shade400),
                              ),
                            ],
                          ),
                          Container(height: 50, width: 1, color: Colors.white10),
                          Column(
                            children: [
                              const Text('JUMLAH KATA', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 12),
                              Text(
                                _banyakKata,
                                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white),
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