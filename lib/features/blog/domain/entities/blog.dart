class Blog {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final String date;
  final String readTime;
  final String author;
  final List<String> tags;

  Blog({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.readTime,
    required this.author,
    this.tags = const [],
  });
}

/// Simple in-memory bookmark store for demo purposes.
/// In a real app, this should live in state management and persistence.
class BlogBookmarks {
  BlogBookmarks._();

  static final Set<String> _bookmarkedIds = <String>{};

  static bool isBookmarked(String blogId) => _bookmarkedIds.contains(blogId);

  static void toggle(String blogId) {
    if (_bookmarkedIds.contains(blogId)) {
      _bookmarkedIds.remove(blogId);
    } else {
      _bookmarkedIds.add(blogId);
    }
  }

  static List<String> get allBookmarkedIds =>
      List<String>.unmodifiable(_bookmarkedIds);
} 