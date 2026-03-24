import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class AgeCalculatorPage extends StatefulWidget {
  const AgeCalculatorPage({super.key});

  @override
  State<AgeCalculatorPage> createState() => _AgeCalculatorPageState();
}

class _AgeCalculatorPageState extends State<AgeCalculatorPage> {
  // ── Warna tema dark disamain sama Calculator & Home ─────────
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  // Warna aksen Indigo sesuai icon di HomePage
  static const _grad1 = Color(0xFF283593); 
  static const _grad2 = Color(0xFF5C6BC0);

  DateTime? selectedDate;
  int hour = 0;
  int minute = 0;
  int second = 0;

  int? resYears, resMonths, resDays, resHours, resMinutes, resSeconds;
  String errorMessage = "Silakan pilih tanggal lahir Anda";

  // Variabel buat Jam Real-time
  DateTime currentTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Timer jalan tiap detik buat update jam atas & umur real-time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
        // Kalau tanggal lahir udah dipilih dan dihitung, update terus umurnya tiap detik!
        if (selectedDate != null && resYears != null) {
          _hitungUmurLogika(); 
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Fungsi helper buat bahasa Indonesia
  String _getHari(int weekday) {
    const hari = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return hari[weekday % 7];
  }

  String _getBulan(int month) {
    const bulan = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return bulan[month];
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: _grad2, 
              onPrimary: Colors.white,
              surface: _bgCard,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: _bgPage,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        resYears = null; 
        errorMessage = "Klik Hitung Umur untuk melihat hasil";
      });
    }
  }

  // Pisahin logika hitung biar bisa dipanggil sama Timer tiap detik
  void _hitungUmurLogika() {
    DateTime birthDate = DateTime(
      selectedDate!.year, selectedDate!.month, selectedDate!.day, hour, minute, second,
    );

    DateTime now = DateTime.now();

    if (birthDate.isAfter(now)) {
      errorMessage = "Waduh, tanggal lahir nggak boleh di masa depan!";
      resYears = null;
      return;
    }

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day; 
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    Duration diff = now.difference(birthDate);

    resYears = years;
    resMonths = months;
    resDays = days;
    resHours = diff.inHours % 24;
    resMinutes = diff.inMinutes % 60;
    resSeconds = diff.inSeconds % 60;
    errorMessage = "";
  }

  void hitungUmur() {
    if (selectedDate == null) {
      setState(() {
        errorMessage = "Oops! Tanggal lahir belum dipilih nih.";
        resYears = null;
      });
      return;
    }
    setState(() {
      _hitungUmurLogika();
    });
  }

  // Widget Dropdown disesuaikan buat Dark Mode
  Widget buildDropdown(String label, int max, int value, Function(int?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _bgPage,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value,
              dropdownColor: _bgCard,
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white54),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              items: List.generate(max + 1, (index) {
                return DropdownMenuItem(
                  value: index,
                  child: Text(index.toString().padLeft(2, '0')), 
                );
              }),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // Widget kotak hasil disesuaikan buat Dark Mode
  Widget _buildResultBox(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()], // Biar angka ga goyang pas ganti
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
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
        title: const Text('Kalkulator Umur',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // ==========================================
            // HEADER: JAM & TANGGAL REAL-TIME
            // ==========================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_grad1, _grad2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _grad1.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // INI YANG DI-FIX BRO: Nambahin currentTime.day
                  Text(
                    "${_getHari(currentTime.weekday)}, ${currentTime.day} ${_getBulan(currentTime.month)} ${currentTime.year}",
                    style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // KARTU UTAMA (FORM & HASIL)
            // ==========================================
            Material(
              color: _bgCard,
              borderRadius: BorderRadius.circular(28),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- INPUT TANGGAL ---
                    const Text("TANGGAL LAHIR", style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: pilihTanggal,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: _bgPage,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.cake_rounded, color: _grad2, size: 24),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                selectedDate == null
                                    ? "Ketuk untuk memilih tanggal"
                                    : "${selectedDate!.day} ${_getBulan(selectedDate!.month)} ${selectedDate!.year}",
                                style: TextStyle(
                                  fontSize: selectedDate == null ? 15 : 16,
                                  fontWeight: selectedDate == null ? FontWeight.w500 : FontWeight.w600,
                                  color: selectedDate == null ? Colors.white38 : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- INPUT WAKTU KELAHIRAN ---
                    const Text("WAKTU LAHIR (OPSIONAL)", style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _grad2.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _grad2.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildDropdown("JAM", 23, hour, (val) => setState(() => hour = val!)),
                          buildDropdown("MENIT", 59, minute, (val) => setState(() => minute = val!)),
                          buildDropdown("DETIK", 59, second, (val) => setState(() => second = val!)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

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
                        onPressed: hitungUmur,
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
                                Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Hitung Umur',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // --- AREA HASIL ---
                    if (resYears == null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(fontSize: 14, color: Colors.white38, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          const Divider(color: Colors.white10, height: 1),
                          const SizedBox(height: 24),
                          const Text(
                            "USIA KAMU SAAT INI",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _grad2, letterSpacing: 1.5),
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                            children: [
                              _buildResultBox("TAHUN", resYears.toString(), Colors.blue.shade400),
                              _buildResultBox("BULAN", resMonths.toString(), Colors.teal.shade400),
                              _buildResultBox("HARI", resDays.toString(), Colors.orange.shade400),
                              _buildResultBox("JAM", resHours.toString(), Colors.purple.shade300),
                              _buildResultBox("MENIT", resMinutes.toString(), Colors.pink.shade300),
                              _buildResultBox("DETIK", resSeconds.toString(), Colors.green.shade400),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}