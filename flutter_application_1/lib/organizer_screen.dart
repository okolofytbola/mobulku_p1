import 'package:flutter/material.dart';

class OrganizerScreen extends StatelessWidget {
  const OrganizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF5265FF), size: 24),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Organizer',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF09101D),
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF5265FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF5265FF), size: 22),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                'assets/images/avatar.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 120,
                  height: 120,
                  color: const Color(0xFFE0E0E0),
                  child: const Icon(Icons.person, size: 70, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Albert Flores',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF09101D),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _stat('2.368', 'Followers'),
              Container(width: 1, height: 40, color: const Color(0xFFEBEEF2)),
              _stat('346', 'Following'),
              Container(width: 1, height: 40, color: const Color(0xFFEBEEF2)),
              _stat('13', 'Events'),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFEBEEF2)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_alt_1, size: 18, color: Colors.white),
                    label: const Text('Follow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5265FF),
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Color(0xFF5265FF)),
                    label: const Text('Messages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF5265FF))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF5265FF), width: 2),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFEBEEF2)),
          const SizedBox(height: 16),
          Row(
            children: [
              _tab('About', true),
              const SizedBox(width: 10),
              _tab('Events', false),
              const SizedBox(width: 10),
              _tab('Reviews', false),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3A4B),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 14.5,
                  height: 1.45,
                  color: Color(0xFF394452),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Read more...',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5265FF),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _stat(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontFamily: 'Source Sans Pro', fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF09101D))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontFamily: 'Source Sans Pro', fontSize: 14, color: Color(0xFF09101D))),
      ],
    );
  }

  static Widget _tab(String title, bool active) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF5265FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF5265FF), width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : const Color(0xFF5265FF),
          ),
        ),
      ),
    );
  }
}