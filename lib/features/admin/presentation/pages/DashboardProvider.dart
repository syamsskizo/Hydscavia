import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/admin/domain/entities/dummydata.dart';
import 'package:flutter_application_1/features/admin/domain/models/models.dart';

// ─── Navigation Enum ──────────────────────────────────────────────────────────
enum DashboardPage {
  overview,
  inventory,
  blog,
  orders,
  marketing,
  customers,
  financial,
}

// ─── Main Dashboard Provider ──────────────────────────────────────────────────
class DashboardProvider extends ChangeNotifier {
  DashboardPage _currentPage = DashboardPage.overview;
  bool _sidebarCollapsed = false;

  DashboardPage get currentPage => _currentPage;
  bool get sidebarCollapsed => _sidebarCollapsed;

  void navigateTo(DashboardPage page) {
    _currentPage = page;
    notifyListeners();
  }

  void toggleSidebar() {
    _sidebarCollapsed = !_sidebarCollapsed;
    notifyListeners();
  }
}

// ─── Inventory Provider ───────────────────────────────────────────────────────
class InventoryProvider extends ChangeNotifier {
  final List<Product> _products = List.from(DummyData.products);
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  List<Product> get products => _filtered;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<String> get categories => [
    'Semua',
    ...{..._products.map((p) => p.category)},
  ];

  List<Product> get _filtered {
    var result = _products.toList();
    if (_selectedCategory != 'Semua') {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      result = result
          .where(
            (p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.id.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
    return result;
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product updated) {
    final index = _products.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _products[index] = updated;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}

// ─── Order Provider ───────────────────────────────────────────────────────────
class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = List.from(DummyData.orders);
  OrderStatus? _filterStatus;

  List<Order> get orders => _filterStatus == null
      ? _orders
      : _orders.where((o) => o.status == _filterStatus).toList();

  OrderStatus? get filterStatus => _filterStatus;

  void setFilter(OrderStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final o = _orders.firstWhere((o) => o.id == orderId);
    o.status = status;
    o.updatedAt = DateTime.now();
    notifyListeners();
  }

  void setTracking(String orderId, String tracking, String courier) {
    final o = _orders.firstWhere((o) => o.id == orderId);
    o.trackingNumber = tracking;
    o.courier = courier;
    o.status = OrderStatus.shipped;
    o.updatedAt = DateTime.now();
    notifyListeners();
  }
}

// ─── Blog Provider ────────────────────────────────────────────────────────────
class BlogProvider extends ChangeNotifier {
  final List<BlogPost> _posts = List.from(DummyData.blogPosts);

  List<BlogPost> get posts => _posts;

  void addPost(BlogPost post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void updatePost(BlogPost updated) {
    final i = _posts.indexWhere((p) => p.id == updated.id);
    if (i != -1) {
      _posts[i] = updated;
      notifyListeners();
    }
  }

  void deletePost(String id) {
    _posts.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void togglePublish(String id) {
    final i = _posts.indexWhere((p) => p.id == id);
    if (i != -1) {
      final post = _posts[i];
      post.status = post.status == BlogStatus.published
          ? BlogStatus.draft
          : BlogStatus.published;
      if (post.status == BlogStatus.published) {
        post.publishedAt = DateTime.now();
      }
      notifyListeners();
    }
  }
}

// ─── Marketing Provider ───────────────────────────────────────────────────────
class MarketingProvider extends ChangeNotifier {
  final List<Voucher> _vouchers = List.from(DummyData.vouchers);

  List<Voucher> get vouchers => _vouchers;

  void addVoucher(Voucher voucher) {
    _vouchers.insert(0, voucher);
    notifyListeners();
  }

  void toggleVoucher(String id) {
    final i = _vouchers.indexWhere((v) => v.id == id);
    if (i != -1) {
      _vouchers[i].isActive = !_vouchers[i].isActive;
      notifyListeners();
    }
  }

  void deleteVoucher(String id) {
    _vouchers.removeWhere((v) => v.id == id);
    notifyListeners();
  }
}

// ─── Notification Provider ────────────────────────────────────────────────────
class NotificationProvider extends ChangeNotifier {
  final List<AppNotification> _notifications = List.from(
    DummyData.notifications,
  );

  List<AppNotification> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAllRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void markRead(String id) {
    final i = _notifications.indexWhere((n) => n.id == id);
    if (i != -1) {
      _notifications[i].isRead = true;
      notifyListeners();
    }
  }
}
