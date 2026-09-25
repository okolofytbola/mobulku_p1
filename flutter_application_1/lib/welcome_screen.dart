import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF039EA2),
      child: Column(
        children: [
          const SizedBox(height: 140),
          const Text(
            'medinow',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Meditate With Us!',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _btn('Sign in with Apple', Colors.white, Colors.black),
                const SizedBox(height: 12),
                _btn('Continue with Email or Phone', const Color(0xFFCDFDFE), Colors.black),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Continue With Google',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Image.asset(
            'assets/images/meditation.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(Icons.self_improvement, size: 100, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _btn(String text, Color bg, Color tc) => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: tc,
            elevation: 0,
            shape: const StadiumBorder(),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}