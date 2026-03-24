import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:async';
import 'dart:ui';

class HijriConverterPage extends StatefulWidget {
  const HijriConverterPage({super.key});

  @override
  State<HijriConverterPage> createState() => _HijriConverterPageState();
}

class _HijriConverterPageState extends State<HijriConverterPage> {
  // ── Warna tema disamain sama Calculator & Home ───────────────
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  static const _grad1 = Color(0xFF1A237E);
  static const _grad2 = Color(0xFF3949AB);

  DateTime currentTime = DateTime.now();
  HijriCalendar currentHijri = HijriCalendar.now();
  Timer? _timer;

  DateTime? selectedDate;
  HijriCalendar? convertedHijri;

  final List<String> namaBulan = [
    '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
        currentHijri = HijriCalendar.now(); 
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        // Tema kalender disesuaikan jadi dark mode elegan
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
        convertedHijri = HijriCalendar.fromDate(picked);
      });
    }
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:"
           "${dt.minute.toString().padLeft(2, '0')}:"
           "${dt.second.toString().padLeft(2, '0')}";
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
        title: const Text('Hijri Converter',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // CARD 1: JAM & KALENDER LIVE (Gradient Home)
            // ==========================================
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_grad1, _grad2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: _grad1.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "Waktu Saat Ini",
                    style: TextStyle(color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  // Jam Live
                  Text(
                    _formatTime(currentTime),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(height: 1, color: Colors.white.withOpacity(0.15)),
                  const SizedBox(height: 20),
                  
                  // Tanggal Masehi Live
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.calendar_today_rounded, color: Colors.white70, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${currentTime.day} ${namaBulan[currentTime.month]} ${currentTime.year}",
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Tanggal Hijriyah Live
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.mosque_rounded, color: Colors.white70, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${currentHijri.hDay} ${currentHijri.longMonthName} ${currentHijri.hYear} H",
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ==========================================
            // CARD 2: KONVERTER TANGGAL MANUAL (Dark Card)
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: const Text(
                "Konversi Tanggal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            Material(
              color: _bgCard,
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: pilihTanggal,
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _grad2.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.edit_calendar_rounded, color: _grad2, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Pilih Tanggal Masehi", style: TextStyle(color: Colors.white54, fontSize: 13)),
                                const SizedBox(height: 6),
                                Text(
                                  selectedDate == null
                                      ? "Ketuk untuk memilih"
                                      : "${selectedDate!.day} ${namaBulan[selectedDate!.month]} ${selectedDate!.year}",
                                  style: TextStyle(
                                    fontSize: selectedDate == null ? 15 : 17,
                                    fontWeight: selectedDate == null ? FontWeight.w500 : FontWeight.w600,
                                    color: selectedDate == null ? _grad2 : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: Colors.white24),
                        ],
                      ),
                      
                      if (convertedHijri != null) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(color: Colors.white10, height: 1),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _grad2.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _grad2.withOpacity(0.3)),
                          ),
                          child: Column(
                            children: [
                              const Text("Hasil Konversi Hijriyah", style: TextStyle(color: _grad2, fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              Text(
                                "${convertedHijri!.hDay} ${convertedHijri!.longMonthName} ${convertedHijri!.hYear} H",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}