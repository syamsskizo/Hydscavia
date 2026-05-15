import 'package:flutter_application_1/features/admin/domain/models/models.dart';

// ═══════════════════════════════════════════════════════════════════
//  DUMMY DATA — Brand Official Store Admin Dashboard
//  Semua data mock lengkap untuk development & demo.
// ═══════════════════════════════════════════════════════════════════

class DummyData {
  // ── PRODUCTS ────────────────────────────────────────────────────
  static final List<Product> products = [
    Product(
      id: 'PRD-001',
      name: 'Kemeja Batik Modern Slim Fit',
      category: 'Pakaian',
      price: 285000,
      originalPrice: 380000,
      stock: 24,
      imageUrl: 'https://picsum.photos/seed/batik1/300/300',
      description:
          'Kemeja batik motif modern dengan potongan slim fit, cocok untuk formal & kasual.',
      createdAt: DateTime(2024, 10, 5),
    ),
    Product(
      id: 'PRD-002',
      name: 'Tas Kulit Genuine Crossbody',
      category: 'Aksesori',
      price: 520000,
      originalPrice: 650000,
      stock: 3,
      imageUrl: 'https://picsum.photos/seed/bag1/300/300',
      description:
          'Tas kulit asli dengan desain crossbody minimalis. Tersedia dalam 3 warna.',
      createdAt: DateTime(2024, 10, 12),
    ),
    Product(
      id: 'PRD-003',
      name: 'Sneakers Canvas Original',
      category: 'Sepatu',
      price: 445000,
      stock: 8,
      imageUrl: 'https://picsum.photos/seed/shoe1/300/300',
      description:
          'Sneakers canvas lokal premium dengan sol karet tebal anti-slip.',
      createdAt: DateTime(2024, 11, 1),
    ),
    Product(
      id: 'PRD-004',
      name: 'Parfum Oud Arabia 100ml',
      category: 'Kecantikan',
      price: 390000,
      originalPrice: 490000,
      stock: 2,
      imageUrl: 'https://picsum.photos/seed/parfum1/300/300',
      description:
          'Wangi oud arab yang tahan lama hingga 12 jam. Kemasan premium gift box.',
      createdAt: DateTime(2024, 11, 8),
    ),
    Product(
      id: 'PRD-005',
      name: 'Sarung Tangan Kulit Motor',
      category: 'Aksesori',
      price: 175000,
      stock: 0,
      imageUrl: 'https://picsum.photos/seed/glove1/300/300',
      description:
          'Sarung tangan motor kulit sintetis dengan pelindung knuckle.',
      createdAt: DateTime(2024, 11, 15),
    ),
    Product(
      id: 'PRD-006',
      name: 'Topi Baseball Branded',
      category: 'Aksesori',
      price: 145000,
      stock: 18,
      imageUrl: 'https://picsum.photos/seed/cap1/300/300',
      description:
          'Topi baseball dengan logo brand bordir, bahan twill premium.',
      createdAt: DateTime(2024, 12, 1),
    ),
    Product(
      id: 'PRD-007',
      name: 'Kaos Oversize Graphic Print',
      category: 'Pakaian',
      price: 185000,
      originalPrice: 230000,
      stock: 35,
      imageUrl: 'https://picsum.photos/seed/tshirt1/300/300',
      description:
          'Kaos oversize bahan cotton combed 30s dengan motif graphic art lokal.',
      createdAt: DateTime(2024, 12, 5),
    ),
    Product(
      id: 'PRD-008',
      name: 'Jam Tangan Analog Minimalis',
      category: 'Aksesori',
      price: 875000,
      stock: 6,
      imageUrl: 'https://picsum.photos/seed/watch1/300/300',
      description:
          'Jam tangan analog dengan dial minimalis, tali kulit coklat, water resistant 3ATM.',
      createdAt: DateTime(2024, 12, 10),
    ),
  ];

  // ── CUSTOMERS ───────────────────────────────────────────────────
  static final List<Customer> customers = [
    Customer(
      id: 'CST-001',
      name: 'Andi Pratama',
      email: 'andi.pratama@gmail.com',
      phone: '081234567890',
      city: 'Jakarta',
      totalOrders: 12,
      totalSpent: 3_850_000,
      joinedAt: DateTime(2024, 3, 15),
      avatarInitials: 'AP',
    ),
    Customer(
      id: 'CST-002',
      name: 'Sari Dewi Rahayu',
      email: 'saridewi@yahoo.com',
      phone: '082198765432',
      city: 'Surabaya',
      totalOrders: 7,
      totalSpent: 2_120_000,
      joinedAt: DateTime(2024, 5, 22),
      avatarInitials: 'SD',
    ),
    Customer(
      id: 'CST-003',
      name: 'Budi Santoso',
      email: 'budi.santoso@gmail.com',
      phone: '085678901234',
      city: 'Bandung',
      totalOrders: 3,
      totalSpent: 875_000,
      joinedAt: DateTime(2024, 7, 8),
      avatarInitials: 'BS',
    ),
    Customer(
      id: 'CST-004',
      name: 'Maya Kusuma',
      email: 'maya.kusuma@outlook.com',
      phone: '087712345678',
      city: 'Yogyakarta',
      totalOrders: 20,
      totalSpent: 6_240_000,
      joinedAt: DateTime(2024, 1, 30),
      avatarInitials: 'MK',
    ),
    Customer(
      id: 'CST-005',
      name: 'Rizky Fauzan',
      email: 'rizky.fauzan@gmail.com',
      phone: '089956781234',
      city: 'Medan',
      totalOrders: 5,
      totalSpent: 1_445_000,
      joinedAt: DateTime(2024, 9, 14),
      avatarInitials: 'RF',
    ),
    Customer(
      id: 'CST-006',
      name: 'Nadia Fitriani',
      email: 'nadia.fit@gmail.com',
      phone: '081398765432',
      city: 'Jakarta',
      totalOrders: 15,
      totalSpent: 4_590_000,
      joinedAt: DateTime(2024, 2, 5),
      avatarInitials: 'NF',
    ),
  ];

  // ── ORDERS ──────────────────────────────────────────────────────
  static final List<Order> orders = [
    Order(
      id: 'ORD-2025-001',
      customerId: 'CST-001',
      customerName: 'Andi Pratama',
      items: [
        OrderItem(
          productId: 'PRD-001',
          productName: 'Kemeja Batik Modern Slim Fit',
          qty: 1,
          price: 285000,
        ),
        OrderItem(
          productId: 'PRD-006',
          productName: 'Topi Baseball Branded',
          qty: 2,
          price: 145000,
        ),
      ],
      status: OrderStatus.shipped,
      trackingNumber: 'JNE-992837461',
      courier: 'JNE',
      totalAmount: 575000,
      createdAt: DateTime(2025, 1, 10, 9, 30),
      shippingAddress: 'Jl. Sudirman No. 45, Jakarta Pusat 10210',
    ),
    Order(
      id: 'ORD-2025-002',
      customerId: 'CST-004',
      customerName: 'Maya Kusuma',
      items: [
        OrderItem(
          productId: 'PRD-008',
          productName: 'Jam Tangan Analog Minimalis',
          qty: 1,
          price: 875000,
        ),
      ],
      status: OrderStatus.delivered,
      trackingNumber: 'SICEPAT-772819302',
      courier: 'SiCepat',
      totalAmount: 875000,
      createdAt: DateTime(2025, 1, 8, 14, 15),
      shippingAddress: 'Jl. Malioboro No. 12, Yogyakarta 55213',
    ),
    Order(
      id: 'ORD-2025-003',
      customerId: 'CST-002',
      customerName: 'Sari Dewi Rahayu',
      items: [
        OrderItem(
          productId: 'PRD-004',
          productName: 'Parfum Oud Arabia 100ml',
          qty: 2,
          price: 390000,
        ),
      ],
      status: OrderStatus.pending,
      totalAmount: 780000,
      createdAt: DateTime(2025, 1, 12, 11, 0),
      shippingAddress: 'Jl. Raya Darmo No. 77, Surabaya 60264',
    ),
    Order(
      id: 'ORD-2025-004',
      customerId: 'CST-006',
      customerName: 'Nadia Fitriani',
      items: [
        OrderItem(
          productId: 'PRD-002',
          productName: 'Tas Kulit Genuine Crossbody',
          qty: 1,
          price: 520000,
        ),
        OrderItem(
          productId: 'PRD-007',
          productName: 'Kaos Oversize Graphic Print',
          qty: 2,
          price: 185000,
        ),
      ],
      status: OrderStatus.processing,
      totalAmount: 890000,
      createdAt: DateTime(2025, 1, 13, 8, 45),
      shippingAddress: 'Jl. Kemang Raya No. 33, Jakarta Selatan 12730',
    ),
    Order(
      id: 'ORD-2025-005',
      customerId: 'CST-005',
      customerName: 'Rizky Fauzan',
      items: [
        OrderItem(
          productId: 'PRD-003',
          productName: 'Sneakers Canvas Original',
          qty: 1,
          price: 445000,
        ),
      ],
      status: OrderStatus.cancelled,
      totalAmount: 445000,
      createdAt: DateTime(2025, 1, 6, 16, 20),
      shippingAddress: 'Jl. Gatot Subroto No. 100, Medan 20112',
    ),
    Order(
      id: 'ORD-2025-006',
      customerId: 'CST-003',
      customerName: 'Budi Santoso',
      items: [
        OrderItem(
          productId: 'PRD-001',
          productName: 'Kemeja Batik Modern Slim Fit',
          qty: 1,
          price: 285000,
        ),
      ],
      status: OrderStatus.delivered,
      trackingNumber: 'ANTERAJA-441927830',
      courier: 'AnterAja',
      totalAmount: 285000,
      createdAt: DateTime(2025, 1, 4, 10, 0),
      shippingAddress: 'Jl. Dago No. 55, Bandung 40135',
    ),
  ];

  // ── REVIEWS ─────────────────────────────────────────────────────
  static final List<Review> reviews = [
    Review(
      id: 'RVW-001',
      customerId: 'CST-001',
      customerName: 'Andi Pratama',
      productId: 'PRD-001',
      productName: 'Kemeja Batik Modern Slim Fit',
      rating: 5,
      comment:
          'Kualitas sangat bagus, jahitan rapi, warna sesuai foto. Pengiriman cepat!',
      createdAt: DateTime(2025, 1, 11),
      isReplied: true,
    ),
    Review(
      id: 'RVW-002',
      customerId: 'CST-004',
      customerName: 'Maya Kusuma',
      productId: 'PRD-008',
      productName: 'Jam Tangan Analog Minimalis',
      rating: 5,
      comment:
          'Jam tangannya elegan banget, cocok buat kerja formal. Packaging mewah.',
      createdAt: DateTime(2025, 1, 9),
      isReplied: false,
    ),
    Review(
      id: 'RVW-003',
      customerId: 'CST-002',
      customerName: 'Sari Dewi Rahayu',
      productId: 'PRD-002',
      productName: 'Tas Kulit Genuine Crossbody',
      rating: 4,
      comment:
          'Tas bagus dan bahan kulit asli. Hanya saja tali agak kaku di awal pemakaian.',
      createdAt: DateTime(2025, 1, 7),
      isReplied: false,
    ),
    Review(
      id: 'RVW-004',
      customerId: 'CST-006',
      customerName: 'Nadia Fitriani',
      productId: 'PRD-007',
      productName: 'Kaos Oversize Graphic Print',
      rating: 3,
      comment:
          'Bahan oke, tapi size agak kecil dari ekspektasi. Minta tolong update size guide.',
      createdAt: DateTime(2025, 1, 5),
      isReplied: false,
    ),
    Review(
      id: 'RVW-005',
      customerId: 'CST-003',
      customerName: 'Budi Santoso',
      productId: 'PRD-003',
      productName: 'Sneakers Canvas Original',
      rating: 4,
      comment: 'Nyaman dipakai seharian. Sol tebal dan tidak licin. Worth it!',
      createdAt: DateTime(2025, 1, 3),
      isReplied: true,
    ),
  ];

  // ── BLOG POSTS ──────────────────────────────────────────────────
  static final List<BlogPost> blogPosts = [
    BlogPost(
      id: 'BLG-001',
      title: '5 Tips Padu Padan Batik untuk Tampilan Modern',
      content:
          '''Batik bukan lagi sebatas formalitas. Kini, kemeja batik bisa dipadukan dengan celana chino, sneakers, dan bahkan topi baseball untuk gaya kasual yang tetap elegan...

Di artikel ini, kami akan membahas 5 cara kreatif memakai batik dalam kehidupan sehari-hari yang bisa membuat penampilan Anda tampak lebih stylish dan modern.

**1. Batik + Celana Chino**
Kombinasi klasik yang tidak pernah salah. Pilih batik motif geometris dengan warna netral...''',
      author: 'Tim Kreatif Brand',
      category: 'Fashion Tips',
      thumbnailUrl: 'https://picsum.photos/seed/blog1/600/300',
      status: BlogStatus.published,
      createdAt: DateTime(2025, 1, 5),
      publishedAt: DateTime(2025, 1, 5),
    ),
    BlogPost(
      id: 'BLG-002',
      title: 'Panduan Merawat Produk Kulit Agar Awet',
      content:
          '''Produk kulit asli memerlukan perawatan khusus agar tetap awet dan terlihat premium. Berikut panduan lengkap dari Brand Official untuk merawat tas, sepatu, dan aksesori kulit Anda...''',
      author: 'Customer Care Team',
      category: 'Perawatan Produk',
      thumbnailUrl: 'https://picsum.photos/seed/blog2/600/300',
      status: BlogStatus.published,
      createdAt: DateTime(2025, 1, 8),
      publishedAt: DateTime(2025, 1, 8),
    ),
    BlogPost(
      id: 'BLG-003',
      title: 'Koleksi Terbaru: Summer Series 2025',
      content:
          '''Kami dengan bangga mempersembahkan koleksi terbaru Brand Official — Summer Series 2025! Terinspirasi dari keindahan alam Indonesia, koleksi ini menampilkan warna-warna cerah...''',
      author: 'Tim Kreatif Brand',
      category: 'New Collection',
      thumbnailUrl: 'https://picsum.photos/seed/blog3/600/300',
      status: BlogStatus.draft,
      createdAt: DateTime(2025, 1, 13),
    ),
  ];

  // ── VOUCHERS ─────────────────────────────────────────────────────
  static final List<Voucher> vouchers = [
    Voucher(
      id: 'VCH-001',
      code: 'WELCOME20',
      description: 'Diskon 20% untuk pembelian pertama',
      type: DiscountType.percentage,
      value: 20,
      minPurchase: 200000,
      usageLimit: 500,
      usedCount: 312,
      expiryDate: DateTime(2025, 3, 31),
    ),
    Voucher(
      id: 'VCH-002',
      code: 'HEMAT50K',
      description: 'Potongan Rp 50.000 untuk pembelian min. Rp 500.000',
      type: DiscountType.fixed,
      value: 50000,
      minPurchase: 500000,
      usageLimit: 200,
      usedCount: 87,
      expiryDate: DateTime(2025, 2, 28),
    ),
    Voucher(
      id: 'VCH-003',
      code: 'FLASH30',
      description: 'Flash sale 30% semua produk pakaian',
      type: DiscountType.percentage,
      value: 30,
      minPurchase: 100000,
      usageLimit: 100,
      usedCount: 100,
      expiryDate: DateTime(2025, 1, 1),
      isActive: false,
    ),
    Voucher(
      id: 'VCH-004',
      code: 'HARNAS2025',
      description: 'Hari Nasional: diskon 17% semua kategori',
      type: DiscountType.percentage,
      value: 17,
      minPurchase: 150000,
      usageLimit: 1000,
      usedCount: 0,
      expiryDate: DateTime(2025, 8, 17),
    ),
  ];

  // ── NOTIFICATIONS ───────────────────────────────────────────────
  static final List<AppNotification> notifications = [
    AppNotification(
      id: 'NTF-001',
      title: 'Pesanan Baru!',
      message: 'ORD-2025-003 dari Sari Dewi Rahayu senilai Rp 780.000',
      type: NotificationType.newOrder,
      createdAt: DateTime(2025, 1, 12, 11, 0),
    ),
    AppNotification(
      id: 'NTF-002',
      title: 'Stok Hampir Habis',
      message: 'Parfum Oud Arabia 100ml — sisa 2 unit!',
      type: NotificationType.lowStock,
      createdAt: DateTime(2025, 1, 12, 9, 30),
    ),
    AppNotification(
      id: 'NTF-003',
      title: 'Stok Habis',
      message: 'Sarung Tangan Kulit Motor — stok 0! Segera restock.',
      type: NotificationType.lowStock,
      createdAt: DateTime(2025, 1, 11, 15, 0),
      isRead: true,
    ),
    AppNotification(
      id: 'NTF-004',
      title: 'Review Baru',
      message: 'Maya Kusuma memberikan rating ⭐⭐⭐⭐⭐ untuk Jam Tangan Analog',
      type: NotificationType.review,
      createdAt: DateTime(2025, 1, 9, 16, 45),
      isRead: true,
    ),
    AppNotification(
      id: 'NTF-005',
      title: 'Pesanan Baru!',
      message: 'ORD-2025-004 dari Nadia Fitriani senilai Rp 890.000',
      type: NotificationType.newOrder,
      createdAt: DateTime(2025, 1, 13, 8, 45),
    ),
  ];

  // ── MONTHLY SALES DATA ───────────────────────────────────────────
  static final List<MonthlySales> monthlySales = [
    MonthlySales(month: 'Agu', revenue: 18_500_000, orders: 48),
    MonthlySales(month: 'Sep', revenue: 22_300_000, orders: 57),
    MonthlySales(month: 'Okt', revenue: 19_800_000, orders: 52),
    MonthlySales(month: 'Nov', revenue: 35_600_000, orders: 91),
    MonthlySales(month: 'Des', revenue: 48_200_000, orders: 124),
    MonthlySales(month: 'Jan', revenue: 28_750_000, orders: 73),
  ];

  // ── SUMMARY STATS ────────────────────────────────────────────────
  static double get totalRevenue =>
      monthlySales.fold(0, (sum, m) => sum + m.revenue);

  static int get totalOrders => orders.length;

  static int get totalCustomers => customers.length;

  static double get avgRating {
    if (reviews.isEmpty) return 0;
    return reviews.fold(0.0, (sum, r) => sum + r.rating) / reviews.length;
  }

  static int get lowStockCount => products.where((p) => p.isLowStock).length;

  static int get unreadNotifications =>
      notifications.where((n) => !n.isRead).length;
}
