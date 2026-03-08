import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  // Fungsi helper biar gampang nambahin anggota tanpa nulis kode panjang-panjang
  Widget _buildMemberCard(String name, String nim, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.2), // Latar belakang icon transparan dikit
          child: Icon(icon, size: 30, color: color),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'NIM: $nim',
            style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Daftar Anggota Kelompok')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Icon(Icons.groups, size: 80, color: Colors.blueAccent),
          const SizedBox(height: 16),
          const Text(
            'Tim Developer',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          
          // Tinggal panggil fungsinya. Nama lu udah gue pasang di paling atas!
          _buildMemberCard('Muhammad David Firdaus', '123230039', Icons.person, Colors.blue),
          _buildMemberCard('Muhammad Abid Dewantoro', '123230093', Icons.person, Colors.orange),
          _buildMemberCard('Alfonsus Sitanggang', '123230100', Icons.person, Colors.teal),
        ],
      ),
    );
  }
}