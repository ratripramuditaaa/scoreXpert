import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Dashboard/card_balance_widget.dart';
import 'package:flutter_application_1/screen/Dashboard/action_button_widget.dart';
import 'package:flutter_application_1/screen/Dashboard/list_anggota.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Ratri Pramudita',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/funny.jpeg'), // Penulisan yang benar
            radius: 50,  // Contoh ukuran
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Panggil widget CardBalance dengan argumen initialCustomerCount
            const CardBalanceWidget(initialCustomerCount: 2), // Tambahkan argumen yang sesuai
            SizedBox(height: 30),
            // Panggil widget ActionButtons
            const ActionButtonsWidget(),
            SizedBox(height: 50),
            // Panggil widget SendMoneySection
            const ListAnggota(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
