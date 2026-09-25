import 'package:flutter/material.dart';

class PopularMenuScreen extends StatelessWidget {
  const PopularMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFC),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 56, 24, 16),
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF43F5E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFFF43F5E)),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Text(
                      'Popular Menu',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF09101D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F9),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Search',
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 14,
                                color: Color(0xFF858C94),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.search, size: 20, color: Color(0xFF858C94)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF43F5E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune, color: Color(0xFFF43F5E), size: 22),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _item('Original Salad', 'Lovy Food', '\$8', 'assets/images/salad1.png', const Color(0xFFE67E22), Icons.eco),
                _item('Fresh Salad', 'Cloudy Resto', '\$10', 'assets/images/salad2.png', const Color(0xFF3498DB), Icons.restaurant),
                _item('Yummie Ice Cream', 'Circlo Resto', '\$6', 'assets/images/ice_cream.png', const Color(0xFFF1C40F), Icons.icecream),
                _item('Vegan Special', 'Haty Food', '\$11', 'assets/images/vegan.png', const Color(0xFF27AE60), Icons.spa),
                _item('Mixed Pasta', 'Recto Food', '\$13', 'assets/images/pasta.png', const Color(0xFFBDC3C7), Icons.ramen_dining),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF4F6F9)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5A6CEA).withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF43F5E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.home, color: Color(0xFFF43F5E), size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF43F5E),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.shopping_basket_outlined, color: Color(0xFFF43F5E), size: 22),
                const Icon(Icons.chat_bubble_outline, color: Color(0xFFF43F5E), size: 22),
                const Icon(Icons.person_outline, color: Color(0xFFF43F5E), size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _item(String title, String subtitle, String price, String imgPath, Color bg, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A6CEA).withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: Image.asset(
                imgPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: bg.withOpacity(0.2),
                  child: Icon(icon, color: bg, size: 32),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF09101D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 13,
                    color: Color(0xFF858C94),
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF43F5E),
            ),
          ),
        ],
      ),
    );
  }
}