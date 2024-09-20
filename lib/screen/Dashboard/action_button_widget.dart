import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/anggota_screen.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tombol Master Anggota
        _buildActionButton(
          Icons.receipt_long,
          'Master Anggota',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnggotaScreen()),
            );
          },
        ),
        // Tombol lainnya
        _buildActionButton(Icons.card_giftcard, 'Voucher', () {
          // Aksi untuk tombol Voucher
        }),
        _buildActionButton(Icons.receipt, 'Bill', () {
          // Aksi untuk tombol Bill
        }),
        _buildActionButton(Icons.more_horiz, 'More', () {
          // Aksi untuk tombol More
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
        ),
        SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}
