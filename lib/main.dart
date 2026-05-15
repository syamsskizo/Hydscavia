import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:flutter_application_1/core/theme/app_theme.dart';

// Import file provider & halaman utama Admin
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/admin_main_screen.dart';

void main() {
  runApp(
    // Nyalain semua mesin sekaligus di sini biar aman 100%
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()), 
        ChangeNotifierProvider(create: (context) => InventoryProvider()), 
        ChangeNotifierProvider(create: (context) => OrderProvider()), 
        ChangeNotifierProvider(create: (context) => BlogProvider()), 
        ChangeNotifierProvider(create: (context) => MarketingProvider()), 
        ChangeNotifierProvider(create: (context) => NotificationProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: AppTheme.dark,
      home: const AdminMainScreen(), // Langsung buka Layar Utama Admin
    );
  }
}