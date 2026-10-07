import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/theme.dart';
import 'screens/home/main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'services/audio_player_service.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint('Firebase not configured yet: $e');
  }
  await AudioPlayerService().init();
  runApp(const ProviderScope(child: TurriniMusicApp()));
}

class TurriniMusicApp extends StatelessWidget {
  const TurriniMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TURRINIMUSIC',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const FirebaseCheckWrapper(),
    );
  }
}

class FirebaseCheckWrapper extends StatelessWidget {
  const FirebaseCheckWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    // إذا لم يتم إعداد Firebase، اعرض شاشة واضحة
    try {
      Firebase.app();
      return const AuthWrapper();
    } catch (_) {
      return const NotConfiguredScreen();
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null, // سيتم ربطه بـ AuthService
      builder: (c, s) => const MainScreen(),
    );
  }
}

class NotConfiguredScreen extends StatelessWidget {
  const NotConfiguredScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('TURRINI', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(16), color: const Color(0xFF1E1E1E), child: const Text('لم يتم إعداد الخادم بعد\nFirebase not configured\n\nأضف google-services.json و Firebase Options', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }
}
