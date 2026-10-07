#!/usr/bin/env bash
set -euo pipefail

APP="turrinimusic"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK غير موجود. ثبّت Flutter أولًا ثم أعد تشغيل السكربت."
  exit 1
fi

if [ -e "$APP" ]; then
  echo "المجلد $APP موجود مسبقًا؛ أعد تسمية المجلد أو احذفه قبل المتابعة."
  exit 1
fi

flutter create --platforms=android --org com.turrini --project-name "$APP" "$APP"
cd "$APP"

cat > pubspec.yaml <<'EOF'
name: turrinimusic
description: TurriniMusic Flutter app starter.
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ">=3.4.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
EOF

cat > lib/main.dart <<'EOF'
import 'package:flutter/material.dart';

void main() {
  runApp(const TurriniMusicApp());
}

const _red = Color(0xFFE50920);
const _surface = Color(0xFF171719);

class TurriniMusicApp extends StatelessWidget {
  const TurriniMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turrinimusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _red,
          brightness: Brightness.dark,
          surface: const Color(0xFF111113),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selected = 0;
  bool _playing = false;

  static const _titles = [
    'الرئيسية',
    'اكتشف',
    'Reels',
    'الإشعارات',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FeedScreen(),
      const DiscoverScreen(),
      const ReelsScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TURRINI',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        actions: [
          IconButton(
            tooltip: 'التنزيلات',
            onPressed: () => _showMessage(context, 'قائمة التنزيلات المحلية'),
            icon: const Icon(Icons.download_outlined),
          ),
          IconButton(
            tooltip: 'البحث',
            onPressed: () => setState(() => _selected = 1),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(index: _selected, children: pages),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MiniPlayer(
            isPlaying: _playing,
            onToggle: () => setState(() => _playing = !_playing),
            onOpen: () => _openPlayer(context),
          ),
          NavigationBar(
            selectedIndex: _selected,
            onDestinationSelected: (index) => setState(() => _selected = index),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore),
                label: 'اكتشف',
              ),
              NavigationDestination(
                icon: Icon(Icons.play_circle_outline),
                selectedIcon: Icon(Icons.play_circle_fill),
                label: 'Reels',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_none),
                selectedIcon: Icon(Icons.notifications),
                label: 'الإشعارات',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'حسابي',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openPlayer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      builder: (sheetContext) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        child: PlayerScreen(
          isPlaying: _playing,
          onToggle: () => setState(() => _playing = !_playing),
        ),
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer({
    required this.isPlaying,
    required this.onToggle,
    required this.onOpen,
  });

  final bool isPlaying;
  final VoidCallback onToggle;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const _Cover(size: 40, index: 0),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ليلة حمراء', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Turrini Artist', style: TextStyle(color: Colors.white60)),
                  ],
                ),
              ),
              IconButton(
                tooltip: isPlaying ? 'إيقاف مؤقت' : 'تشغيل',
                onPressed: onToggle,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const Text('مساء الموسيقى ✨', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('اكتشف جديد الفنانين الذين تتابعهم', style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 20),
        SizedBox(
          height: 94,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: _red),
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: const Color(0xFF373238),
                    child: Text(['T', 'M', 'L', 'A', 'S'][index],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 5),
                Text(['Turrini', 'Maya', 'Leo', 'Amir', 'Sara'][index]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _PostCard(
          name: 'Turrini Artist',
          handle: '@turrini',
          caption: 'أغنية جديدة، إحساس جديد. استمعوا الآن 🎵',
          kind: 'أغنية جديدة',
          index: 0,
        ),
        const _PostCard(
          name: 'Maya Sounds',
          handle: '@mayasounds',
          caption: 'لحظة من الاستوديو قبل الإصدار القادم 🎙️',
          kind: 'من الاستوديو',
          index: 1,
        ),
        const _PostCard(
          name: 'Leo Visuals',
          handle: '@leovisuals',
          caption: 'إيقاع المدينة بعد منتصف الليل.',
          kind: 'فيديو',
          index: 2,
        ),
      ],
    );
  }
}

class _PostCard extends StatefulWidget {
  const _PostCard({
    required this.name,
    required this.handle,
    required this.caption,
    required this.kind,
    required this.index,
  });

  final String name;
  final String handle;
  final String caption;
  final String kind;
  final int index;

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false;
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _surface,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: _red,
              child: Icon(Icons.music_note, color: Colors.white),
            ),
            title: Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(widget.handle),
            trailing: IconButton(
              tooltip: 'خيارات المنشور',
              onPressed: () => _showMessage(context, 'خيارات المنشور'),
              icon: const Icon(Icons.more_horiz),
            ),
          ),
          Container(
            height: 210,
            width: double.infinity,
            color: const Color(0xFF222126),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(child: _Cover(size: 210, index: widget.index)),
                Container(color: Colors.black.withValues(alpha: 0.22)),
                Icon(
                  widget.kind == 'فيديو' ? Icons.play_circle_fill : Icons.graphic_eq,
                  size: 62,
                  color: Colors.white,
                ),
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Chip(label: Text(widget.kind)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 2),
            child: Text(widget.caption),
          ),
          Row(
            children: [
              IconButton(
                tooltip: 'إعجاب',
                onPressed: () => setState(() => _liked = !_liked),
                icon: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? _red : null),
              ),
              const Text('1.2k'),
              IconButton(
                tooltip: 'تعليق',
                onPressed: () => _showMessage(context, 'التعليقات'),
                icon: const Icon(Icons.mode_comment_outlined),
              ),
              IconButton(
                tooltip: 'مشاركة',
                onPressed: () => _showMessage(context, 'مشاركة المنشور'),
                icon: const Icon(Icons.share_outlined),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'حفظ',
                onPressed: () => setState(() => _saved = !_saved),
                icon: Icon(_saved ? Icons.bookmark : Icons.bookmark_border),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _query = '';

  static const items = [
    ('ليلة حمراء', 'أغنية • Turrini Artist', Icons.music_note),
    ('Maya Sounds', 'فنانة • 24.6k متابع', Icons.person),
    ('إيقاع المدينة', 'Reel • Leo Visuals', Icons.play_circle),
    ('#موسيقى_جديدة', 'وسم شائع', Icons.tag),
  ];

  @override
  Widget build(BuildContext context) {
    final results = items.where((item) =>
        item.$1.toLowerCase().contains(_query.toLowerCase()) ||
        item.$2.toLowerCase().contains(_query.toLowerCase()));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: 'ابحث عن أغنية أو فنان أو وسم',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: _surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
        const SizedBox(height: 18),
        const Text('الأكثر رواجًا', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        for (final item in results)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: _red.withValues(alpha: 0.2),
              child: Icon(item.$3, color: _red),
            ),
            title: Text(item.$1),
            subtitle: Text(item.$2),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showMessage(context, 'فتح ${item.$1}'),
          ),
      ],
    );
  }
}

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  int _likedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final reels = [
      ('@turrini', 'مقطع موسيقي جديد 🔥', 'ليلة حمراء • Turrini'),
      ('@maya', 'من كواليس التسجيل 🎙️', 'صوت المدينة • Maya'),
      ('@leo', 'هذا الإيقاع لا يتوقف', 'Midnight beat • Leo'),
    ];

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reels.length,
      itemBuilder: (context, index) {
        final reel = reels[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                [const Color(0xFF42131D), const Color(0xFF111113)],
                [const Color(0xFF142A39), const Color(0xFF111113)],
                [const Color(0xFF3A2A16), const Color(0xFF111113)],
              ][index],
            ),
          ),
          child: Stack(
            children: [
              const Center(child: Icon(Icons.play_circle_outline, size: 86)),
              Positioned(
                left: 18,
                bottom: 28,
                right: 82,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reel.$1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(reel.$2),
                    const SizedBox(height: 8),
                    Row(children: [const Icon(Icons.music_note, size: 18), Text(' ${reel.$3}')]),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                bottom: 24,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _likedIndex = index),
                      icon: Icon(
                        _likedIndex == index ? Icons.favorite : Icons.favorite_border,
                        color: _likedIndex == index ? _red : Colors.white,
                        size: 30,
                      ),
                    ),
                    const Text('2.4k'),
                    IconButton(
                      onPressed: () => _showMessage(context, 'تعليقات Reel'),
                      icon: const Icon(Icons.mode_comment_outlined, size: 28),
                    ),
                    IconButton(
                      onPressed: () => _showMessage(context, 'مشاركة Reel'),
                      icon: const Icon(Icons.share_outlined, size: 27),
                    ),
                    IconButton(
                      onPressed: () => _showMessage(context, 'تم إرسال طلب المتابعة'),
                      icon: const Icon(Icons.person_add_alt_1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const notifications = [
      ('Maya Sounds أعجبت بمنشورك', 'منذ 5 دقائق', Icons.favorite),
      ('Leo Visuals بدأ بمتابعتك', 'منذ ساعة', Icons.person_add),
      ('Turrini Artist نشر أغنية جديدة', 'اليوم', Icons.music_note),
      ('Sara علّقت: رائع جدًا!', 'أمس', Icons.mode_comment),
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('حديثًا', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ),
        for (final item in notifications)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: _red.withValues(alpha: 0.2),
              child: Icon(item.$3, color: _red),
            ),
            title: Text(item.$1),
            subtitle: Text(item.$2),
            onTap: () => _showMessage(context, item.$1),
          ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: _red,
            child: Text('T', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        const Center(child: Text('Turrini Artist', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        const Center(child: Text('@turrini • فنان رسمي', style: TextStyle(color: Colors.white60))),
        const SizedBox(height: 18),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Stat(label: 'منشورات', value: '28'),
            _Stat(label: 'المتابعون', value: '12.8k'),
            _Stat(label: 'يتابع', value: '340'),
          ],
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: _red),
          onPressed: () => _showMessage(context, 'تم تحديث حالة المتابعة'),
          icon: const Icon(Icons.person_add_alt_1),
          label: const Text('متابعة'),
        ),
        const SizedBox(height: 20),
        const Text('نبذة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text('موسيقى، لحظات، وأصوات من TURRINI.'),
        const SizedBox(height: 18),
        const Text('منشورات الفنان', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (_, index) => _Cover(size: 100, index: index),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white60)),
        ],
      );
}

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({required this.isPlaying, required this.onToggle});

  final bool isPlaying;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _Cover(size: 250, index: 0),
          const SizedBox(height: 24),
          const Text('ليلة حمراء', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Turrini Artist', style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 24),
          const LinearProgressIndicator(value: 0.35, color: _red),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('1:12'), Text('3:28')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous, size: 36)),
              IconButton(
                onPressed: onToggle,
                icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 64, color: _red),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next, size: 36)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
            ],
          ),
          const Text('واجهة مشغل تجريبية — أضف مصدرًا صوتيًا لتمكين التشغيل الفعلي.',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.size, required this.index});
  final double size;
  final int index;

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF8C1727), Color(0xFF183E50), Color(0xFF76511F), Color(0xFF52336A)];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors[index % colors.length], const Color(0xFF171719)],
        ),
      ),
      child: Icon(Icons.graphic_eq, size: size * 0.38, color: Colors.white70),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
EOF

cat > test/widget_test.dart <<'EOF'
import 'package:flutter_test/flutter_test.dart';
import 'package:turrinimusic/main.dart';

void main() {
  testWidgets('يفتح التطبيق ويعرض الواجهة الرئيسية', (tester) async {
    await tester.pumpWidget(const TurriniMusicApp());
    expect(find.text('TURRINI'), findsOneWidget);
    expect(find.text('مساء الموسيقى ✨'), findsOneWidget);
  });

  testWidgets('يمكن فتح صفحة اكتشف', (tester) async {
    await tester.pumpWidget(const TurriniMusicApp());
    await tester.tap(find.text('اكتشف').last);
    await tester.pumpAndSettle();
    expect(find.text('الأكثر رواجًا'), findsOneWidget);
  });
}
EOF

mkdir -p .github/workflows

cat > .github/workflows/android.yml <<'EOF'
name: Android APK

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: "17"

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Test
        run: flutter test

      - name: Build release APK
        run: flutter build apk --release

      - name: Rename APK
        run: cp build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/turrinimusic-release.apk

      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: turrinimusic-release
          path: build/app/outputs/flutter-apk/turrinimusic-release.apk
          if-no-files-found: error
EOF

cat > README.md <<'EOF'
# Turrinimusic

مشروع Flutter باسم **Turrinimusic**، بمعرّف Android:
`com.turrini.turrinimusic`

## الموجود حاليًا

- واجهة داكنة وMaterial 3.
- تبويبات الرئيسية، اكتشف، Reels، الإشعارات، والملف الشخصي.
- بيانات محلية تجريبية تعمل دون إعداد Backend.
- GitHub Actions للتحليل والاختبارات وبناء APK ورفعه كـArtifact.
- اختبارات Widget أولية.

## المتطلبات

- Flutter stable
- Android SDK
- Java 17 لبناء Android

## التشغيل محليًا

```bash
flutter pub get
flutter analyze
flutter test
flutter run
