import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  // Fungsi helper biar gampang nambahin anggota tanpa nulis kode panjang-panjang
  Widget _buildMemberCard(String name, String nim, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue.shade100,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withValues(alpha: 0.15), // Latar belakang icon transparan dikit
          child: Icon(icon, size: 30, color: color),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(Icons.badge, size: 16, color: Colors.grey.shade500,),
              const SizedBox(width: 6,),
              Text(
                'NIM: $nim',
                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Daftar Anggota Kelompok', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 40),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.groups, size: 70, color: Colors.white,),
                ),
                const SizedBox(height: 16,),
                const Text(
                  'Kenalan dengan Kelompok Kami',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70,fontWeight: FontWeight.w500,),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              children: [
                // const Icon(Icons.groups, size: 80, color: Colors.blueAccent),
                // const SizedBox(height: 16),
                // const Text(
                //   'Tim Developer',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 30),
                
                // Tinggal panggil fungsinya. Nama lu udah gue pasang di paling atas!
                _buildMemberCard('Muhammad David Firdaus', '123230039', Icons.person, Colors.blue),
                _buildMemberCard('Muhammad Abid Dewantoro', '123230093', Icons.person, Colors.orange),
                _buildMemberCard('Alfonsus Sitanggang', '123230100', Icons.person, Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}