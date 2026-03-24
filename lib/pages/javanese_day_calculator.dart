import 'package:flutter/material.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  static const _grad1 = Color(0xFF4A148C); 
  static const _grad2 = Color(0xFF7B1FA2);

  DateTime? _selectedDate;
  String _hasilWeton = "-";

  String hitungHariPasaran(DateTime tanggal) {
    List<String> listHari = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
    List<String> listPasaran = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

    DateTime referenceDate = DateTime(1970, 1, 1);
    int selisihHari =  tanggal.difference(referenceDate).inDays;
    
    int indeksHari = (selisihHari + 3) % 7;
    int indeksPasaran = (selisihHari + 3) %  5;

    if (indeksHari < 0) indeksHari += 7;
    if (indeksPasaran < 0) indeksPasaran += 5;

    return "${listHari[indeksHari]} ${listPasaran[indeksPasaran]}";
  }

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), 
      lastDate: DateTime(2100),  
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

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _hasilWeton = hitungHariPasaran(picked);
      });
    }
  }

  String _formatTanggalIndo(DateTime date) {
    final List<String> namaBulan = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return "${date.day} ${namaBulan[date.month]} ${date.year}";
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
        title: const Text('Hitung Weton',
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
                        color: _grad1.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.nights_stay_rounded, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 24),
                
                const Text(
                  'Cek Hari Pasaran Jawa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pilih tanggal masehi untuk mengetahui hari dan pasaran jawanya.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white54),
                ),
                const SizedBox(height: 32),

                // --- INPUT TANGGAL YANG DIPILIH ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _bgPage,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'TANGGAL MASUKAN',
                        style: TextStyle(fontSize: 11, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded, 
                            color: _selectedDate == null ? Colors.white24 : _grad2,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _selectedDate == null ? 'Belum dipilih' : _formatTanggalIndo(_selectedDate!),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedDate == null ? Colors.white38 : Colors.white, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- PILIH TANGGAL ---
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
                    onPressed: () => _pilihTanggal(context), 
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
                            Icon(Icons.edit_calendar_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Pilih Tanggal',
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

                // --- KOTAK HASIL WETON ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _grad2.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _grad2.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'HASIL WETON',
                        style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _hasilWeton,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color:  _hasilWeton == '-' ? Colors.white24 : Colors.purple.shade300,
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