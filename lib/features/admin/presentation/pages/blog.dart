import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  // Kita buat data dummy lokal di sini Bang, bebas dari model luar!
  final List<Map<String, dynamic>> _localPosts = [
    {
      'id': 'BLOG-1',
      'title': 'Tren Fashion Ramadhan 2026 yang Wajib Kamu Punya',
      'category': 'Fashion',
      'isPublished': true,
    },
    {
      'id': 'BLOG-2',
      'title': 'Diskon Gila-gilaan Grand Opening Official Store!',
      'category': 'Promo',
      'isPublished': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manajemen Blog & Artikel',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kelola konten promosi dan pengumuman Official Store (Local Dummy Mode).',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddPostDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  'Tulis Artikel',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Area Tabel Artikel
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: _localPosts.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article_rounded,
                          size: 80,
                          color: AppColors.textSecondary.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum Ada Artikel',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _localPosts.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.grey, height: 24),
                      itemBuilder: (context, index) {
                        final post = _localPosts[index];
                        final isPublished = post['isPublished'] as bool;

                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    (isPublished
                                            ? AppColors.success
                                            : AppColors.warning)
                                        .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isPublished
                                    ? Icons.assignment_turned_in
                                    : Icons.assignment_late_outlined,
                                color: isPublished
                                    ? AppColors.success
                                    : AppColors.warning,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post['title'].toString(),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          post['category'].toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isPublished ? 'PUBLISHED' : 'DRAFT',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: isPublished
                                              ? AppColors.success
                                              : AppColors.warning,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Tombol Aksi Lokal
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isPublished
                                        ? Icons.visibility_off_outlined
                                        : Icons.send_rounded,
                                    color: isPublished
                                        ? Colors.grey
                                        : AppColors.primary,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _localPosts[index]['isPublished'] =
                                          !isPublished;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: AppColors.danger,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _localPosts.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceElevated,
          title: Text(
            'Tulis Artikel Baru',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          content: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: const InputDecoration(labelText: 'Judul Artikel'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: categoryController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: const InputDecoration(labelText: 'Kategori'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                if (titleController.text.isEmpty ||
                    categoryController.text.isEmpty)
                  return;
                setState(() {
                  _localPosts.add({
                    'id': 'BLOG-${DateTime.now().millisecondsSinceEpoch}',
                    'title': titleController.text,
                    'category': categoryController.text,
                    'isPublished': false,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Simpan Draft',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}