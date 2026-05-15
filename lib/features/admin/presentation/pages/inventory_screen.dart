import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/domain/models/models.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();
    final products = provider.products;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToolbar(context, provider),
          const SizedBox(height: 16),
          _buildCategoryFilter(provider),
          const SizedBox(height: 16),
          Expanded(child: _buildProductGrid(context, products, provider)),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context, InventoryProvider provider) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: provider.setSearch,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => _showProductDialog(context, null, provider),
          icon: const Icon(Icons.add_rounded, size: 16),
          label: Text(
            'Tambah Produk',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(InventoryProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: provider.categories.map((cat) {
          final isSelected = cat == provider.selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => provider.setCategory(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.background
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    List<Product> products,
    InventoryProvider provider,
  ) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 12),
            Text(
              'Tidak ada produk ditemukan',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final cols = constraints.maxWidth > 1000
            ? 4
            : constraints.maxWidth > 700
            ? 3
            : 2;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) => _ProductCard(
            product: products[i],
            onEdit: () => _showProductDialog(context, products[i], provider),
            onDelete: () => _confirmDelete(context, products[i], provider),
          ),
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    Product product,
    InventoryProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Hapus Produk',
          style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary),
        ),
        content: Text(
          'Yakin hapus "${product.name}"?',
          style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () {
              provider.deleteProduct(product.id);
              Navigator.pop(ctx);
            },
            child: Text(
              'Hapus',
              style: GoogleFonts.plusJakartaSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showProductDialog(
    BuildContext context,
    Product? product,
    InventoryProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => _ProductDialog(product: product, provider: provider),
    );
  }
}

// ─── Product Card ─────────────────────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit, onDelete;

  const _ProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: product.isLowStock
              ? AppColors.danger.withOpacity(0.5)
              : AppColors.border,
          width: product.isLowStock ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
                child: Image.network(
                  product.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 140,
                    color: AppColors.surfaceElevated,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: AppColors.textMuted,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              if (product.hasDiscount)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '-${product.discountPercent.toStringAsFixed(0)}%',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (product.isLowStock)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: product.stock == 0
                          ? AppColors.danger
                          : AppColors.warning,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      product.stock == 0 ? 'HABIS' : 'KRITIS',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  product.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      'Rp ${_formatNum(product.price)}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    if (product.hasDiscount) ...[
                      const SizedBox(width: 6),
                      Text(
                        'Rp ${_formatNum(product.originalPrice!)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: AppColors.textMuted,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Stok: ${product.stock}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: product.isLowStock
                        ? AppColors.danger
                        : AppColors.textSecondary,
                    fontWeight: product.isLowStock
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onEdit,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    OutlinedButton(
                      onPressed: onDelete,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.danger),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 14,
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNum(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}jt';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}rb';
    return v.toStringAsFixed(0);
  }
}

// ─── Product Dialog ───────────────────────────────────────────────────────────
class _ProductDialog extends StatefulWidget {
  final Product? product;
  final InventoryProvider provider;

  const _ProductDialog({this.product, required this.provider});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  late TextEditingController _name,
      _price,
      _originalPrice,
      _stock,
      _desc,
      _category;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.product != null;
    _name = TextEditingController(text: widget.product?.name ?? '');
    _price = TextEditingController(
      text: widget.product?.price.toStringAsFixed(0) ?? '',
    );
    _originalPrice = TextEditingController(
      text: widget.product?.originalPrice?.toStringAsFixed(0) ?? '',
    );
    _stock = TextEditingController(
      text: widget.product?.stock.toString() ?? '',
    );
    _desc = TextEditingController(text: widget.product?.description ?? '');
    _category = TextEditingController(text: widget.product?.category ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        _isEditing ? 'Edit Produk' : 'Tambah Produk Baru',
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field('Nama Produk', _name),
              const SizedBox(height: 12),
              _field('Kategori', _category),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _field('Harga (Rp)', _price, isNumber: true)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      'Harga Coret (Rp)',
                      _originalPrice,
                      isNumber: true,
                      hint: 'Kosongkan jika tidak ada',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _field('Stok', _stock, isNumber: true),
              const SizedBox(height: 12),
              _field('Deskripsi', _desc, maxLines: 3),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Batal',
            style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(
            _isEditing ? 'Simpan Perubahan' : 'Tambah Produk',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool isNumber = false,
    int maxLines = 1,
    String? hint,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final price = double.tryParse(_price.text) ?? 0;
    final orig = _originalPrice.text.isNotEmpty
        ? double.tryParse(_originalPrice.text)
        : null;
    final stock = int.tryParse(_stock.text) ?? 0;

    if (_isEditing && widget.product != null) {
      widget.product!.name = name;
      widget.product!.price = price;
      widget.product!.originalPrice = orig;
      widget.product!.stock = stock;
      widget.product!.description = _desc.text;
      widget.product!.category = _category.text;
      widget.provider.updateProduct(widget.product!);
    } else {
      final newProduct = Product(
        id: 'PRD-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        category: _category.text.isEmpty ? 'Lainnya' : _category.text,
        price: price,
        originalPrice: orig,
        stock: stock,
        imageUrl: 'https://picsum.photos/seed/${DateTime.now().second}/300/300',
        description: _desc.text,
        createdAt: DateTime.now(),
      );
      widget.provider.addProduct(newProduct);
    }
    Navigator.pop(context);
  }
}
