import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  static const _bgPage = Color(0xFF0F0F1A);
  static const _bgCard = Color(0xFF1A1A2E);
  static const _grad1 = Color(0xFF4A148C);
  static const _grad2 = Color(0xFF6A1B9A);

  Widget _buildMemberCard(String name, String nim, IconData icon, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: accentColor.withOpacity(0.5)),
          ),
          child: Icon(icon, size: 28, color: accentColor),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 17, 
            fontWeight: FontWeight.bold, 
            color: Colors.white, 
            letterSpacing: 0.5
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            children: [
              Icon(Icons.badge_rounded, size: 16, color: accentColor.withOpacity(0.8)),
              const SizedBox(width: 6),
              Text(
                'NIM: $nim',
                style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ),
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
        title: const Text('Daftar Kelompok',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
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
                  color: _grad2.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.groups_rounded, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 24),
          
          const Text(
            'Anggota Tim',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Informasi anggota kelompok penyusun project.',
            style: TextStyle(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(height: 32),

          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _buildMemberCard('Muhammad David Firdaus', '123230039', Icons.person_rounded, Colors.blue.shade400),
                _buildMemberCard('Muhammad Abid Dewantoro', '123230093', Icons.person_rounded, Colors.orange.shade400),
                _buildMemberCard('Alfonsus Sitanggang', '123230100', Icons.person_rounded, Colors.teal.shade400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}