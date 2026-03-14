import 'package:flutter/material.dart';

class AgeCalculatorPage extends StatefulWidget {
  const AgeCalculatorPage({super.key});

  @override
  State<AgeCalculatorPage> createState() => _AgeCalculatorPageState();
}

class _AgeCalculatorPageState extends State<AgeCalculatorPage> {
  DateTime? selectedDate;

  int hour = 0;
  int minute = 0;
  int second = 0;

  String result = "Pilih tanggal lahir";

  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void hitungUmur() {
    if (selectedDate == null) {
      setState(() {
        result = "Tanggal lahir belum dipilih";
      });
      return;
    }

    DateTime birthDate = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      hour,
      minute,
      second,
    );

    DateTime now = DateTime.now();

    if (birthDate.isAfter(now)) {
      setState(() {
        result = "Tanggal lahir tidak boleh di masa depan";
      });
      return;
    }

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      days += 30;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    Duration diff = now.difference(birthDate);

    int hours = diff.inHours % 24;
    int minutes = diff.inMinutes % 60;
    int seconds = diff.inSeconds % 60;

    setState(() {
      result =
          "$years Tahun\n"
          "$months Bulan\n"
          "$days Hari\n"
          "$hours Jam\n"
          "$minutes Menit\n"
          "$seconds Detik";
    });
  }

  Widget buildDropdown(
    String label,
    int max,
    int value,
    Function(int?) onChanged,
  ) {
    return Column(
      children: [
        Text(label),
        DropdownButton<int>(
          value: value,
          items: List.generate(max + 1, (index) {
            return DropdownMenuItem(
              value: index,
              child: Text(index.toString()),
            );
          }),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Umur")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            ElevatedButton(
              onPressed: pilihTanggal,
              child: const Text("Pilih Tanggal Lahir"),
            ),

            const SizedBox(height: 10),

            Text(
              selectedDate == null
                  ? "Belum dipilih"
                  : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDropdown("Jam", 23, hour, (val) {
                  setState(() {
                    hour = val!;
                  });
                }),

                buildDropdown("Menit", 59, minute, (val) {
                  setState(() {
                    minute = val!;
                  });
                }),

                buildDropdown("Detik", 59, second, (val) {
                  setState(() {
                    second = val!;
                  });
                }),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: hitungUmur,
              child: const Text("Hitung Umur"),
            ),

            const SizedBox(height: 30),

            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
