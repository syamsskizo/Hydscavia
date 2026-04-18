import 'package:flutter_application_1/features/home/domain/entities/product.dart';


final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Adidas Shoes',
    categories: ['Anak-anak'],
    price: 120.00,
    imageUrl: 'assets/images/adidas_shoe.png',
    images: [
      'assets/images/adidas_shoe.png',
      'assets/images/adidas_shoe_1.png',
    ],
    description: 'Comfortable sneakers perfect for everyday wear.',
    colors: ['#FF5733', '#33CFFF', '#FFC300'],
    isFavorite: false,
    specialOfferIds: ['offer1'],
  ),
  Product(
    id: '2',
    name: 'Stylish Sofa',
    categories: ['Perempuan'],
    price: 350.00,
    imageUrl: 'assets/images/hoodie.png', // Di video emang agak aneh namanya, sesuaikan aja Syam
    images: [
      'assets/images/hoodie.png',
      'assets/images/hoodie_2.png',
      'assets/images/hoodie_3.png',
    ],
    description: 'A stylish sofa that adds elegance to your space.',
    colors: ['#8E44AD', '#3498DB', '#2ECC71'],
    isFavorite: false,
    specialOfferIds: ['offer2'],
  ),
  Product(
    id: '3',
    name: 'Wooden Table',
    categories: ['Promo'],
    price: 200.00,
    imageUrl: 'assets/images/3.png',
    images: [
      'assets/images/3.png',
      'assets/images/3.png', // Sesuai video dia duplikat gambarnya
    ],
    description: 'A strong wooden table suitable for dining or work.',
    colors: ['#A0522D', '#CD853F', '#D2B48C'],
    isFavorite: false,
    specialOfferIds: ['offer3'],
  ),
  Product(
    id: '4',
    name: 'Jordan Shoes',
    categories: ['Perempuan', 'Laki-laki'],
    price: 500.00,
    imageUrl: 'assets/images/jordan.png',
    images: [
      'assets/images/jordan.png',
      'assets/images/jordan.png',
    ],
    description: 'Iconic sneakers with style and comfort.',
    colors: ['#1ABC9C', '#F1C40F', '#E67E22'],
    isFavorite: false,
    specialOfferIds: ['offer4'],
  ),
];