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

  static final List<_MenuData> _menus = [
    _MenuData('Daftar Kelompok', Icons.group_rounded, const Color(0xFFEDE7F6), const Color(0xFF6A1B9A), const GroupPage(), 'Info anggota'),
    _MenuData('Kalkulator', Icons.calculate_rounded, const Color(0xFFE3F2FD), const Color(0xFF1565C0), const CalculatorPage(), 'Hitung cepat'),
    _MenuData('Ganjil & Prima', Icons.tag_rounded, const Color(0xFFE8F5E9), const Color(0xFF2E7D32), const NumberCheckPage(), 'Cek bilangan'),
    _MenuData('Total Angka', Icons.add_circle_outline_rounded, const Color(0xFFFFF3E0), const Color(0xFFE65100), const SumInputPage(), 'Jumlah input'),
    _MenuData('Piramida', Icons.change_history_rounded, const Color(0xFFFCE4EC), const Color(0xFFAD1457), const PyramidPage(), 'Pola segitiga'),
    _MenuData('Stopwatch', Icons.timer_rounded, const Color(0xFFE0F7FA), const Color(0xFF00695C), const StopwatchPage(), 'Pengukur waktu'),
    _MenuData('Hitung Weton', Icons.nights_stay_rounded, const Color(0xFFF3E5F5), const Color(0xFF6A1B9A), const WetonPage(), 'Hari Jawa'),
    _MenuData('Hitung Umur', Icons.cake_rounded, const Color(0xFFE8EAF6), const Color(0xFF283593), const AgeCalculatorPage(), 'Kalkulator usia'),
  ];

  Widget _buildMenuCard(BuildContext context, _MenuData menu) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => Navigator.push(context, _fadeRoute(menu.page)),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: menu.iconColor.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: menu.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(menu.icon, color: menu.iconColor, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                menu.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A237E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                menu.subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHijriCard(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => Navigator.push(context, _fadeRoute(const HijriConverterPage())),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1A237E).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.mosque_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hijri Converter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Konversi kalender Hijriyah',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
    Color? iconColor,
  }) {
    final color = iconColor ?? const Color(0xFF3949AB);
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, _fadeRoute(page));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    );
  }

  PageRoute _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      
      // AppBar bawaan dibuang biar custom header lebih fleksibel
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.account_circle_rounded, size: 36, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text('Menu Navigasi',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    const Text('Pilih fitur yang diinginkan',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _buildDrawerItem(context, icon: Icons.group_rounded, title: 'Daftar Kelompok', page: const GroupPage(), iconColor: const Color(0xFF6A1B9A)),
                  _buildDrawerItem(context, icon: Icons.calculate_rounded, title: 'Kalkulator', page: const CalculatorPage(), iconColor: const Color(0xFF1565C0)),
                  _buildDrawerItem(context, icon: Icons.tag_rounded, title: 'Ganjil Genap & Prima', page: const NumberCheckPage(), iconColor: const Color(0xFF2E7D32)),
                  _buildDrawerItem(context, icon: Icons.add_circle_outline_rounded, title: 'Jumlah Total Angka', page: const SumInputPage(), iconColor: const Color(0xFFE65100)),
                  _buildDrawerItem(context, icon: Icons.change_history_rounded, title: 'Piramida', page: const PyramidPage(), iconColor: const Color(0xFFAD1457)),
                  _buildDrawerItem(context, icon: Icons.timer_rounded, title: 'Stopwatch', page: const StopwatchPage(), iconColor: const Color(0xFF00695C)),
                  const Divider(height: 24),
                  _buildDrawerItem(context, icon: Icons.nights_stay_rounded, title: 'Hitung Pasaran', page: const WetonPage(), iconColor: const Color(0xFF6A1B9A)),
                  _buildDrawerItem(context, icon: Icons.cake_rounded, title: 'Hitung Umur', page: const AgeCalculatorPage(), iconColor: const Color(0xFF283593)),
                  _buildDrawerItem(context, icon: Icons.mosque_rounded, title: 'Hijri Converter', page: const HijriConverterPage(), iconColor: const Color(0xFF1A237E)),
                  const Divider(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.logout_rounded, color: Colors.red.shade600, size: 18),
                ),
                title: Text('Logout', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.w600, fontSize: 14)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),

      body: Column(
        children: [
          // === STICKY CUSTOM HEADER SECTION ===
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              // Jarak atas nyesuain status bar (poni HP) ditambah dikit margin
              top: MediaQuery.of(context).padding.top + 16, 
              left: 24,
              right: 24,
              bottom: 24, // Jarak bawah dibikin ngepas sama tulisan
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol Menu (Garis Tiga)
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Jarak dari tombol menu ke teks
                const Text(
                  'Selamat datang 👋',
                  style: TextStyle(color: Colors.white60, fontSize: 13)
                ),
                const SizedBox(height: 4),
                const Text(
                  'Menu Utama',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)
                ),
              ],
            ),
          ),

          // === SCROLLABLE MENU SECTION ===
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // === GRID MENU ===
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildMenuCard(context, _menus[index]),
                      childCount: _menus.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.05,
                    ),
                  ),
                ),

                // === HIJRI CONVERTER - FULL WIDTH ===
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).padding.bottom + 24),
                  sliver: SliverToBoxAdapter(
                    child: _buildHijriCard(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data class untuk menu item
class _MenuData {
  final String title;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Widget page;
  final String subtitle;

  const _MenuData(this.title, this.icon, this.iconBg, this.iconColor, this.page, this.subtitle);
}