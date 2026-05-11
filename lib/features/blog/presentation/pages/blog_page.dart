import 'dart:async'; // Tambahan buat Timer auto-slide
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/blog/domain/entities/blog.dart';
import 'package:google_fonts/google_fonts.dart';

// Catatan: Pastiin class BlogBookmarks lo udah punya fungsi toggle() ya Syam!
// Kalau belum ada, tambahin fungsi ini di file tempat BlogBookmarks lo berada:
// static void toggle(String id) {
//   if (_bookmarkedIds.contains(id)) { _bookmarkedIds.remove(id); } else { _bookmarkedIds.add(id); }
// }

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    'All',
    'Trends',
    'Fashion',
    'Tech',
    'Health',
    'Bookmarks',
  ];
  String? _selectedTag;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  // --- CAROUSEL VARIABLES ---
  late PageController _pageController;
  int _currentCarouselPage = 0;
  Timer? _carouselTimer;

  final List<Blog> dummyBlogs = [
    Blog(
      id: '1',
      title: 'Top 5 Fashion Trends to Watch in 2025',
      imageUrl: 'assets/images/blog1.jpg',
      content:
          'Detailed article content goes here... Full breakdown of trends, silhouettes, color palettes.',
      tags: ['Trends', 'Fashion'],
      excerpt:
          'Discover the hottest fashion trends that will dominate the industry next year.',
      date: 'July 20, 2025',
      readTime: '4 min',
      author: 'Sophia Chen',
    ),
    Blog(
      id: '2',
      title: 'How to Choose the Perfect Sneakers',
      imageUrl: 'assets/images/blog2.jpg',
      content:
          'Detailed article content goes here... Cushioning systems, fit tips, and style picks.',
      tags: ['Tips', 'Fashion'],
      date: 'July 10, 2025',
      excerpt:
          'A comprehensive guide to finding sneakers that match your style and comfort needs.',
      readTime: '3 min',
      author: 'Marcus Johnson',
    ),
    Blog(
      id: '3',
      title: 'Tech Gadgets That Will Transform Your Shopping Experience',
      imageUrl: 'assets/images/blog3.jpg',
      content:
          'Detailed article content goes here... AR try-ons, AI stylists, smart carts.',
      tags: ['Tech', 'Trends'],
      date: 'June 28, 2025',
      excerpt:
          'Explore innovative technologies changing how we shop online and in-store.',
      readTime: '5 min',
      author: 'Alex Rivera',
    ),
    Blog(
      id: '4',
      title: 'Summer Wardrobe Essentials Under Budget',
      imageUrl: 'assets/images/hoodie.png',
      content: 'Build a versatile summer wardrobe without breaking the bank.',
      tags: ['Fashion', 'Tips', 'Health'],
      date: 'June 15, 2025',
      excerpt: 'Budget-friendly items that still look premium.',
      readTime: '6 min',
      author: 'Priya Nair',
    ),
    Blog(
      id: '5',
      title: 'Sustainable Fabrics You Should Know',
      imageUrl: 'assets/images/hoodie_2.png',
      content:
          'From Tencel to organic cotton, learn what makes fabrics sustainable.',
      tags: ['Trends', 'Fashion'],
      date: 'May 30, 2025',
      excerpt: 'Eco-friendly fabrics and how to shop smarter.',
      readTime: '7 min',
      author: "Liam O'Connor",
    ),
    Blog(
      id: '6',
      title: 'Smart Home Devices for Style Lovers',
      imageUrl: 'assets/images/tv_cabinet.png',
      content: 'Devices that blend interior design with smart functionality.',
      tags: ['Tech', 'Tips'],
      date: 'May 10, 2025',
      excerpt: 'Bring convenience and aesthetics together.',
      readTime: '4 min',
      author: 'Mina Park',
    ),
    Blog(
      id: '7',
      title: 'Athleisure: The Trend That Stays',
      imageUrl: 'assets/images/hoodie_3.png',
      content: 'Why athleisure keeps winning and how to style it in 2025.',
      tags: ['Trends', 'Fashion'],
      date: 'April 21, 2025',
      excerpt: 'Comfort meets style in everyday fits.',
      readTime: '5 min',
      author: 'Diego Marín',
    ),
    Blog(
      id: '8',
      title: "Buyer's Guide: Building Your First Smart Wardrobe",
      imageUrl: 'assets/images/wardrobe.png',
      content: 'Step-by-step guide to organizing and digitizing your closet.',
      tags: ['Tips', 'Tech'],
      date: 'April 02, 2025',
      excerpt: 'From inventory apps to outfit planners.',
      readTime: '6 min',
      author: 'Sara Ahmed',
    ),
    Blog(
      id: '9',
      title: 'Minimalist Fashion: Capsule Collection Ideas',
      imageUrl: 'assets/images/wardrobe1.png',
      content: 'Curate a capsule wardrobe that works for every season.',
      tags: ['Fashion', 'Tips'],
      date: 'March 15, 2025',
      excerpt: 'Do more with fewer, better pieces.',
      readTime: '8 min',
      author: 'Noah Bennett',
    ),
    Blog(
      id: '10',
      title: 'Future of Retail: AI Stylists Explained',
      imageUrl: 'assets/images/tv_cabinet_1.png',
      content: 'How AI stylists personalize recommendations and fit.',
      tags: ['Tech', 'Trends'],
      date: 'March 01, 2025',
      excerpt: 'The rise of AI in personal shopping.',
      readTime: '5 min',
      author: 'Emily Zhao',
    ),
  ];

  List<Blog> get filteredBlogs {
    List<Blog> blogs = dummyBlogs;

    if (_selectedTag != null) {
      blogs = blogs.where((blog) => blog.tags.contains(_selectedTag)).toList();
    } else if (_categories[_tabController.index] == 'Bookmarks') {
      blogs = blogs
          .where((blog) => BlogBookmarks.isBookmarked(blog.id))
          .toList();
    }

    if (_isSearching && _searchController.text.trim().isNotEmpty) {
      final query = _searchController.text.trim().toLowerCase();
      blogs = blogs.where((blog) {
        return blog.title.toLowerCase().contains(query) ||
            blog.excerpt.toLowerCase().contains(query) ||
            blog.author.toLowerCase().contains(query) ||
            blog.tags.any((t) => t.toLowerCase().contains(query));
      }).toList();
    }

    return blogs;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          final String selected = _categories[_tabController.index];
          _selectedTag = selected == 'All' || selected == 'Bookmarks'
              ? null
              : selected;
        });
      }
    });

    // --- SETUP AUTO-SLIDE CAROUSEL ---
    _pageController = PageController(initialPage: 0);
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentCarouselPage + 1;
        if (nextPage > 2) {
          // 2 karena kita bakal nampilin 3 artikel (index 0, 1, 2)
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel(); // Wajib dimatiin biar gak bocor memori
    _pageController.dispose();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.outfit(),
                autofocus: true,
                onChanged: (value) => setState(() {}),
              )
            : Text(
                "Discover",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.black,
            ),
          ),

          // --- INI DIA SHORTCUT BOOKMARKNYA ---
          IconButton(
            onPressed: () {
              // Pindah ke tab Bookmarks secara otomatis
              _tabController.animateTo(_categories.indexOf('Bookmarks'));
            },
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
          ),

          // ------------------------------------
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.normal,
          ),
          tabs: _categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return _buildBlogList(category);
        }).toList(),
      ),
    );
  }

  Widget _buildBlogList(String category) {
    List<Blog> displayBlogs = filteredBlogs;

    if (category != "All" && category != "Bookmarks" && !_isSearching) {
      displayBlogs = displayBlogs
          .where((b) => b.tags.contains(category))
          .toList();
    }

    if (displayBlogs.isEmpty) {
      return Center(
        child: Text(
          "No articles found.",
          style: GoogleFonts.outfit(color: Colors.grey),
        ),
      );
    }

    // Logic buat misahin list biasa sama carousel
    bool showCarousel = !_isSearching && category == "All";
    int itemCount = showCarousel
        ? displayBlogs.length + 1
        : displayBlogs.length;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (showCarousel) {
          if (index == 0) {
            // Ambil 3 blog pertama buat dijadiin slider
            List<Blog> topBlogs = displayBlogs.take(3).toList();
            return _buildFeaturedCarousel(topBlogs);
          }
          // Kurangin 1 index karena index 0 udah dipake carousel
          return _buildBlogCard(displayBlogs[index - 1]);
        } else {
          return _buildBlogCard(displayBlogs[index]);
        }
      },
    );
  }

  Widget _buildFeaturedCarousel(List<Blog> carouselBlogs) {
    if (carouselBlogs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Featured Articles",
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220, // Tinggi slider
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentCarouselPage = page;
              });
            },
            itemCount: carouselBlogs.length,
            itemBuilder: (context, index) {
              final blog = carouselBlogs[index];
              return _buildCarouselItem(blog);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indikator Titik-titik (Dots)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            carouselBlogs.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentCarouselPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentCarouselPage == index
                    ? Colors.black
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCarouselItem(Blog blog) {
    bool isBookmarked = BlogBookmarks.isBookmarked(blog.id);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 1. Gambar Full Background
            Positioned.fill(
              child: Image.asset(
                blog.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey, size: 50),
                ),
              ),
            ),

            // 2. Gradient Gelap di Bawah
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // 3. Tombol Bookmark di Pojok Kanan Atas
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.2,
                  ), // Biar transparan elegan
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      BlogBookmarks.toggle(blog.id);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isBookmarked
                              ? 'Bookmark removed'
                              : 'Added to bookmarks',
                          style: GoogleFonts.outfit(),
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // 4. Teks Konten di Pojok Kiri Bawah
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        blog.author,
                        style: GoogleFonts.outfit(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' • ${blog.date}',
                        style: GoogleFonts.outfit(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blog.excerpt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCard(Blog blog) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to detail
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                blog.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.tags.isNotEmpty ? blog.tags.first.toUpperCase() : '',
                    style: GoogleFonts.outfit(
                      color: AppConstants.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        blog.date,
                        style: GoogleFonts.outfit(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: Colors.grey[400],
                        ),
                      ),
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        blog.readTime,
                        style: GoogleFonts.outfit(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
