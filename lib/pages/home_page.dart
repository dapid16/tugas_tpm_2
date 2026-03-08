import 'package:flutter/material.dart';
import 'package:tugas2mobilee/pages/pyramid_page.dart'; // Biarin import bawaan lu
import 'login_page.dart';
import 'calculator_page.dart';
import 'number_check_page.dart';
import 'sum_input_page.dart';
import 'stopwatch_page.dart';
import 'group_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi helper biar kita gampang bikin kotak menu tanpa nulis ulang kodenya
  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell( // InkWell ini biar Card-nya ngasih efek animasi pas diklik
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue), // Icon dibikin gede
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Warna background disamain kayak login
      appBar: AppBar(title: const Text('Menu Utama')),
      
      // Drawer (Sidebar) tetep dipertahanin persis kayak sebelumnya
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Daftar Kelompok'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Kalkulator'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CalculatorPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.numbers),
              title: const Text('Ganjil Genap & Prima'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NumberCheckPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Jumlah Total Angka'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SumInputPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.change_history),
              title: const Text('Piramida'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PyramidPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Stopwatch'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StopwatchPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      
      // Ini dia sulapnya bro, body-nya kita ubah jadi GridView!
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Artinya 2 kotak ke samping
          crossAxisSpacing: 16, // Jarak antar kotak kiri-kanan
          mainAxisSpacing: 16, // Jarak antar kotak atas-bawah
          children: [
            // Tinggal panggil fungsi helpernya buat masing-masing menu
            _buildMenuCard(context, 'Daftar Kelompok', Icons.group, const GroupPage()),
            _buildMenuCard(context, 'Kalkulator', Icons.calculate, const CalculatorPage()),
            _buildMenuCard(context, 'Ganjil & Prima', Icons.numbers, const NumberCheckPage()),
            _buildMenuCard(context, 'Total Angka', Icons.add_circle_outline, const SumInputPage()),
            _buildMenuCard(context, 'Piramida', Icons.change_history, const PyramidPage()),
            _buildMenuCard(context, 'Stopwatch', Icons.timer, const StopwatchPage()),
          ],
        ),
      ),
    );
  }
}