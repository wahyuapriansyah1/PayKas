import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paykas/main.dart';
import 'package:paykas/screens/auth/login_screen.dart';
import 'package:paykas/screens/main_navigation_screen.dart';
import 'package:paykas/widgets/custom_button.dart';

void main() {
  testWidgets('PayKas splash screen and login flow test', (WidgetTester tester) async {
    await tester.pumpWidget(const PayKasApp());
    expect(find.text('PayKas'), findsWidgets);
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);

    // Tap Masuk button on Splash
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Verify Login Screen
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Silakan masuk ke akun Anda'), findsOneWidget);
    expect(find.text('Email / Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Tap Masuk on Login Screen
    final loginButtons = find.byType(CustomButton);
    expect(loginButtons, findsOneWidget);
    await tester.tap(loginButtons);
    await tester.pumpAndSettle();
  });

  testWidgets('MainNavigationScreen tabs navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavigationScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Dashboard verification
    expect(find.text('Total Kas'), findsOneWidget);
    expect(find.text('Aktivitas Terbaru'), findsOneWidget);
    expect(find.text('Anggota Kelas'), findsOneWidget);

    // Switch to Pembayaran tab
    await tester.tap(find.text('Pembayaran'));
    await tester.pumpAndSettle();
    expect(find.text('Kelola pemasukan kelas (admin)'), findsOneWidget);
    expect(find.text('Bayar Iuran'), findsOneWidget);

    // Switch to Pengaturan tab
    await tester.tap(find.text('Pengaturan'));
    await tester.pumpAndSettle();
    expect(find.text('Wahyu'), findsOneWidget);
    expect(find.text('Detail Profile'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Ubah Password'), findsOneWidget);
  });
}
