import 'package:flutter/material.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
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
      initialDate: _selectedDate ?? DateTime.now(), // Default ke hari ini
      firstDate: DateTime(1900), // Batas tahun bawah
      lastDate: DateTime(2100),  // Batas tahun atas
      builder: (context, child) {
        // Mewarnai kalender agar sesuai tema Cokelat
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.brown.shade600, // Warna header kalender
              onPrimary: Colors.white,
              onSurface: Colors.brown.shade900, // Warna angka tanggal
            ),
          ),
          child: child!,
        );
      },
    );

    // Kalau user pilih tanggal (tidak klik cancel), update UI dan hitung weton
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _hasilWeton = hitungHariPasaran(picked);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Weton', style: TextStyle(fontWeight: FontWeight.bold),),
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
            borderRadius: BorderRadius.circular(24)
          ),
          child: Padding(
            padding: const EdgeInsetsGeometry.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ikon Klaender dengan tema Coklat
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.dark_mode_outlined, size: 60, color: Colors.deepOrange.shade600,),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Cek Hari Pasaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, 
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 30,),

                // Menampilkan tanggal yang dipilih
                Text(
                  'Tanggal Pilihan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  _selectedDate == null ? 'Belum ada tanggal dipilih' : '${_selectedDate!.day} / ${_selectedDate!.month} / ${_selectedDate!.year}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _selectedDate == null ? Colors.grey.shade400 : Colors.deepOrange.shade800, 
                  ),
                ),
                const SizedBox(height: 24,),

                // tombol buka kalender
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange.shade600,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => _pilihTanggal(context), 
                    label: const Text(
                      'Pilih Tanggal',
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 1,
                      ),
                    
                    ),
                  
                  ),
                ),
                const SizedBox(height: 32,),
                const Divider(color: Colors.black12,),
                const SizedBox(height: 24,),

                // kotak hasil weton
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16,),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.deepOrange.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hari Pasaran',
                        style: TextStyle(
                          color: Colors.deepOrange.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Text(
                        _hasilWeton,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color:  _hasilWeton == '-' ? Colors.deepOrange.shade300 : Colors.deepOrange.shade900,
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