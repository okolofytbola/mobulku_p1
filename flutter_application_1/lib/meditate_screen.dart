import 'package:flutter/material.dart';

class MeditateScreen extends StatelessWidget {
  const MeditateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: double.infinity,
              height: 214,
              child: Image.asset(
                'assets/images/relax.png',
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => Container(
                  height: 214,
                  color: const Color(0xFFF2C94C),
                  child: const Icon(Icons.image, size: 80, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text('Peter Mach', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF828282))),
          const SizedBox(height: 4),
          const Text('Mind Deep Relax', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
          const SizedBox(height: 8),
          const Text('Join the Community as we prepare over 33 days to relax and feel joy with the mind and happnies session across the World.', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 14, height: 1.4, color: Color(0xFF4F4F4F))),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 22),
              label: const Text('Play Next Session', style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF039EA2), elevation: 0, shape: const StadiumBorder()),
            ),
          ),
          const SizedBox(height: 14),
          _item('Sweet Memories', 'December 29 Pre-Launch', const Color(0xFF2F80ED)),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFE0E0E0)),
          _item('A Day Dream', 'December 29 Pre-Launch', const Color(0xFF039EA2)),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFE0E0E0)),
          _item('Mind Explore', 'December 29 Pre-Launch', const Color(0xFFF2994A)),
        ],
      ),
    );
  }

  static Widget _item(String t, String s, Color c) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 2),
                  Text(s, style: const TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 12, color: Color(0xFF828282))),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, color: Color(0xFFBDBDBD))),
          ],
        ),
      );
}