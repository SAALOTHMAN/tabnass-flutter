// import 'package:flutter/material.dart';
// import 'package:nfc_attendance/pages/HomePage.dart';
// import 'package:nfc_attendance/pages/NFCReaderPage.dart';

// class bottom_bar extends StatefulWidget {
//   @override
//   _bottom_barState createState() => _bottom_barState();
// }

// class _bottom_barState extends State<bottom_bar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if (index == 0) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => NFCReaderPage()),
//       );
//     } else if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: Center(
//         child: Text('Page $_selectedIndex'),
//       ),
      
//     );
//   }
// }
