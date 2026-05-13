// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool notifyOrders = true;
//   bool notifyPromotions = false;
//   bool notifyPriceDrops = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(context),
//             const SizedBox(height: 12),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(
//                   left: AppConstants.defaultPadding,
//                   right: AppConstants.defaultPadding,
//                   bottom: 20,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _SectionTitle('Notifications'),
//                     _CardContainer(
//                       children: [
//                         _SwitchTile(
//                           icon: Icons.local_shipping_outlined,
//                           label: 'Order updates',
//                           subtitle: 'Get notified about your order status',
//                           value: notifyOrders,