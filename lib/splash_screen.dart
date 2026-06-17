import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart' show PromedioPage;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // 🎬 CONTROLADOR ANIMACION
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scale = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // ⏱ cambio de pantalla
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PromedioPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF023052),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fade.value,
              child: Transform.scale(
                scale: _scale.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // 🟡 ICONO PRO (CHECK ANIMADO VISUAL)
                    Icon(
                      Icons.task_alt_rounded,
                      size: 110,
                      color: Color(0xFFFFCC00),
                    ),

                    SizedBox(height: 18),

                    // ⚪ TEXTO
                    Text(
                      "WELCOME TO\nACADEMIC CHECK",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                      ),
                    ),

                    SizedBox(height: 10),

                    // 🔵 loading fake elegante
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      color: Color(0xFFFFCC00),
                      strokeWidth: 2,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}