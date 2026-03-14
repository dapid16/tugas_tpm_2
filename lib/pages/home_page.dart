import 'package:flutter/material.dart';
import 'package:tugas2mobilee/pages/age_calculator.dart';
import 'package:tugas2mobilee/pages/hijriyah_page.dart';
import 'package:tugas2mobilee/pages/javanese_day_calculator.dart';
import 'package:tugas2mobilee/pages/pyramid_page.dart';
import 'login_page.dart';
import 'calculator_page.dart';
import 'number_check_page.dart';
import 'sum_input_page.dart';
import 'stopwatch_page.dart';
import 'group_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Utama',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Menu Navigasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.group, color: Colors.blue.shade700),
              title: const Text(
                'Daftar Kelompok',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroupPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate, color: Colors.blue.shade700),
              title: const Text(
                'Kalkulator',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalculatorPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers, color: Colors.blue.shade700),
              title: const Text(
                'Ganjil Genap & Prima',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NumberCheckPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_circle_outline,
                color: Colors.blue.shade700,
              ),
              title: const Text(
                'Jumlah Total Angka',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SumInputPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.change_history, color: Colors.blue.shade700),
              title: const Text(
                'Piramida',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PyramidPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.timer, color: Colors.blue.shade700),
              title: const Text(
                'Stopwatch',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StopwatchPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.dark_mode_outlined,
                color: Colors.blue.shade700,
              ),
              title: const Text(
                'Hitung Pasaran',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WetonPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.dark_mode_outlined,
                color: Colors.blue.shade700,
              ),
              title: const Text(
                'Hitung Umur',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgeCalculatorPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dark_mode_outlined,
                color: Colors.blue.shade700,
              ),
              title: const Text(
                'Hijri Converter',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HijriConverterPage(),
                  ),
                );
              },
            ),
            const Divider(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

      body: Stack(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
              children: [
                _buildMenuCard(
                  context,
                  'Daftar Kelompok',
                  Icons.group,
                  const GroupPage(),
                ),
                _buildMenuCard(
                  context,
                  'Kalkulator',
                  Icons.calculate,
                  const CalculatorPage(),
                ),
                _buildMenuCard(
                  context,
                  'Ganjil & Prima',
                  Icons.numbers,
                  const NumberCheckPage(),
                ),
                _buildMenuCard(
                  context,
                  'Total Angka',
                  Icons.add_circle_outline,
                  const SumInputPage(),
                ),
                _buildMenuCard(
                  context,
                  'Piramida',
                  Icons.change_history,
                  const PyramidPage(),
                ),
                _buildMenuCard(
                  context,
                  'Stopwatch',
                  Icons.timer,
                  const StopwatchPage(),
                ),
                _buildMenuCard(
                  context,
                  'Hitung Weton',
                  Icons.mode_night_outlined,
                  const WetonPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
