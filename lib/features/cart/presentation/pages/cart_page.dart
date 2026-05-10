import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/cart/domain/entities/cart_item.dart';
import 'package:flutter_application_1/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter_application_1/features/cart/presentation/widgets/cart_total.dart';
import 'package:flutter_application_1/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final List<CartItem> dummyItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'Jordan',
        description: 'A stylish and comfortable modern sofa.',
        imageUrl: 'assets/images/jordan.png',
        images: [],
        price: 499.99,
        category: 'Living Room',
        colors: [],
      ),
      quantity: 2,
      selectedColor: '#FF6F61',
      discountPercentage: 20,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'Wooden Coffee Table',
        description: 'A handcrafted wooden coffee table.',
        imageUrl: 'assets/images/coffee_table_1.png',
        price: 259.00,
        category: 'Living Room',
        images: [],
        colors: [],
      ),
      quantity: 1,
      selectedColor: '#BD6E63',
    ),
    CartItem(
      product: Product(
        id: '3',
        name: 'Ergonomic Office Chair',
        description: 'Comfortable office chair with lumbar support.',
        imageUrl:
            'assets/images/dining_table.png', // Sesuai screenshot tutorialnya ya Syam
        price: 189.50,
        category: 'Office',
        specialOfferIds: [],
        images: [],
        colors: [],
      ),
      quantity: 1,
      selectedColor: '#3949AB',
      discountPercentage: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: AppConstants.defaultPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Cart",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // show confirmation dialog
                        },
                        icon: Icon(Icons.delete_outline, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // Jeda antar baris
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${dummyItems.length} items', // Ini otomatis ngitung jumlah barang di list
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(), // Ini kuncinya biar tombol Edit mental ke pojok kanan
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          minimumSize: Size
                              .zero, // Biar gak ada padding bawaan yang kegedean
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Biar area kliknya pas
                        ),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppConstants
                                .primaryColor, // Biasanya tombol edit pake warna biru atau primary
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Nanti List Item Keranjang Lo di Sini ---
          Expanded(
            child: Builder(
              builder: (context) {
                if (dummyItems.isEmpty) {
                  return const EmptyCart();
                }

                return Column(
                  children: [
                    //cart item list
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: dummyItems.length + 1,
                        itemBuilder: (context, index) {
                          if (index < dummyItems.length) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: CartItemCard(
                                item: dummyItems[index],
                                onUndo: (item) {},
                              ),
                            );
                          } else {
                            // Bagian Cart Total di akhir list
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CartTotal(
                                total:
                                    2499.99, // Nanti ini ganti pake variabel total beneran ya
                                cartItems: dummyItems,
                              ), // <--- Pastiin kurung tutup ini ada Syam!
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
