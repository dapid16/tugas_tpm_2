import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriConverterPage extends StatefulWidget {
  const HijriConverterPage({super.key});

  @override
  State<HijriConverterPage> createState() => _HijriConverterPageState();
}

class _HijriConverterPageState extends State<HijriConverterPage> {

  DateTime? selectedDate;
  String result = "Pilih tanggal terlebih dahulu";

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {

      HijriCalendar hijri = HijriCalendar.fromDate(picked);

      setState(() {
        selectedDate = picked;
        result =
            "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Hijriyah"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: pilihTanggal,
                child: const Text("Pilih Tanggal Masehi"),
              ),

              const SizedBox(height: 20),

              Text(
                selectedDate == null
                    ? "Belum ada tanggal"
                    : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              const Text(
                "Tanggal Hijriyah",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                result,
                style: const TextStyle(fontSize: 22),
              )

            ],
          ),
        ),
      ),
    );
  }
}