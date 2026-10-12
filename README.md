# PayKas - Aplikasi Kelola Kas Kelas

Frontend aplikasi **PayKas** ("Kelola Kas Kelas Lebih Mudah, Transparan dan Teratur") dibangun menggunakan framework **Flutter** dan **Dart**, disesuaikan dengan desain mockup visual yang Anda berikan.

---

## 📱 Daftar Halaman & Fitur yang Diimplementasikan

### 1. Onboarding & Autentikasi
- **Splash Screen**: Logo PayKas (dompet dengan koin "Rp"), slogan/tagline, tombol "Masuk" dan "Daftar".
- **Login Screen**: Form login dengan input Email/Username, Password dengan toggle visibility, tombol Masuk, dan link Daftar.
- **Register Screen**: Form registrasi lengkap (Nama, Username, Email, Kelas, Password, Konfirmasi).

### 2. Beranda / Dashboard (`MainNavigationScreen`)
- **Header**: Nama aplikasi PayKas, ikon lonceng notifikasi (dengan popup interaktif), dan avatar profil "W" (Wahyu).
- **Total Kas Card**: Kartu hijau emerald utama menampilkan saldo **Rp 2.450.000** dengan ikon dompet.
- **Kartu Ringkasan**:
  - **Pemasukan**: Indikator panah hijau, nominal **Rp 5.200.000**, dapat diklik langsung ke *Detail Pemasukan*.
  - **Pengeluaran**: Indikator panah merah, nominal **Rp 2.750.000**, dapat diklik langsung ke *Detail Pengeluaran*.
- **4 Menu Cepat (Quick Actions)**:
  - 💰 **Pemasukan**: Menuju form input pemasukan admin
  - 🧾 **Pengeluaran**: Menuju form input pengeluaran admin
  - 👥 **Anggota Kelas**: Menuju daftar anggota & status iuran
  - 🕒 **Riwayat**: Menuju riwayat transaksi kas
- **Aktivitas Terbaru**: Daftar riwayat transaksi terakhir dengan pembeda warna hijau (pemasukan) dan merah (pengeluaran), serta modal detail transaksi saat diklik.
- **Fitur Informasi**: Banner keunggulan *Mudah Digunakan*, *Aman & Terpercaya*, dan *Fitur Lengkap*.

### 3. Detail Pemasukan & Pengeluaran
- **Detail Pemasukan**: Filter kategori chip horizontal (*Semua*, *Iuran Kelas*, *Bonus*, *Lainnya*), total kas masuk, dan daftar transaksi pemasukan.
- **Detail Pengeluaran**: Filter kategori chip horizontal (*Semua*, *ATK*, *Konsumsi*, *Lainnya*), total pengeluaran, dan daftar pengeluaran kas.

### 4. Anggota Kelas
- **Tab 1: Daftar Anggota**: Nomor urut, nama siswa (Andi, Budi, Citra, Dika, Eka, dll.), kelas (Kelas X IPA 1), nominal iuran (Rp 100.000), dan status pill (*Lunas* warna hijau atau *Belum Bayar* warna merah).
- **Tab 2: Histori Pembayaran**: Riwayat verifikasi pembayaran tiap anggota beserta metode pembayarannya.

### 5. Menu Pembayaran (Tab 2)
- **Bagian Admin**:
  - **Pemasukan**: Kartu gradient hijau untuk kelola pemasukan kelas -> menuju `AdminPemasukanScreen`.
  - **Pengeluaran**: Kartu gradient biru untuk kelola pengeluaran kelas -> menuju `AdminPengeluaranScreen`.
- **Bagian Untuk User**:
  - **Bayar Iuran**: Kartu gradient ungu/indigo -> menuju `UserPembayaranScreen`.

### 6. Formulir Pembayaran & Input Transaksi
- **Admin - Pemasukan**: Input Nominal, Keterangan, DatePicker tanggal (contoh: 12 Mei 2025), Dropdown Metode (Transfer Bank, Tunai, QRIS), dan tombol Simpan.
- **Admin - Pengeluaran**: Input Nominal, Keterangan, DatePicker tanggal, Dropdown Metode, dan tombol Simpan.
- **User - Pembayaran Iuran**: Kartu highlight iuran kelas (Rp 100.000 / bulan), pilihan metode radio interaktif (Transfer Bank, E-Wallet, Tunai Offline), tombol *Bayar Sekarang*, serta dialog konfirmasi sukses.

### 7. Pengaturan & Profil (Tab 3)
- **Menu Pengaturan**: Card profil Wahyu (Kelas X IPA 1), menu navigasi Detail Profile, Edit Profile, Ubah Password, dan Keluar Akun.
- **Detail Profile**: Tampilan detail akun (Nama, Username, Email, No. HP, Kelas) dan tombol aksi.
- **Edit Profile**: Formulir pengeditan profil yang memperbarui data secara reaktif.
- **Ubah Password**: Formulir password lama, password baru, konfirmasi password dengan validasi input.

---

## 🛠️ Struktur Direktori Proyek

```
lib/
├── main.dart                                # Entry point aplikasi & inisialisasi tema
├── theme/
│   └── app_theme.dart                       # Skema warna hijau emerald, tipografi Google Fonts, dan gaya UI
├── models/
│   ├── transaction_model.dart               # Model transaksi pemasukan & pengeluaran
│   ├── member_model.dart                    # Model anggota kelas & status pembayaran
│   └── user_model.dart                      # Model data pengguna/profil Wahyu
├── state/
│   └── kas_provider.dart                    # Manajemen state reaktif (ChangeNotifier)
├── widgets/
│   ├── paykas_logo.dart                     # Komponen logo PayKas (dompet + koin Rp)
│   ├── custom_button.dart                   # Komponen tombol kustom responsif
│   ├── custom_text_field.dart               # Input teks kustom dengan ikon & validasi
│   ├── stat_card.dart                       # Kartu Total Kas dan ringkasan mini
│   └── transaction_item.dart                # Baris item transaksi kustom
└── screens/
    ├── splash/
    │   └── splash_screen.dart               # Layar pembuka & onboarding
    ├── auth/
    │   ├── login_screen.dart                # Layar login
    │   └── register_screen.dart             # Layar registrasi
    ├── main_navigation_screen.dart          # Navigasi bawah (Beranda, Pembayaran, Pengaturan)
    ├── dashboard/
    │   ├── dashboard_screen.dart            # Beranda utama
    │   ├── detail_pemasukan_screen.dart     # Layar detail pemasukan
    │   └── detail_pengeluaran_screen.dart   # Layar detail pengeluaran
    ├── members/
    │   └── anggota_kelas_screen.dart        # Layar anggota kelas & histori
    ├── payment/
    │   ├── pembayaran_menu_screen.dart      # Layar menu pembayaran (Admin & User)
    │   ├── admin_pemasukan_screen.dart      # Form tambah pemasukan admin
    │   ├── admin_pengeluaran_screen.dart    # Form tambah pengeluaran admin
    │   └── user_pembayaran_screen.dart      # Form pembayaran iuran siswa
    └── settings/
        ├── pengaturan_screen.dart           # Layar pengaturan utama
        ├── detail_profile_screen.dart       # Layar detail profil
        ├── edit_profile_screen.dart         # Layar edit profil
        └── ubah_password_screen.dart        # Layar ubah kata sandi
```

---

## 🚀 Cara Menjalankan Aplikasi

Pastikan Flutter SDK tersedia pada sistem, kemudian jalankan:

```bash
# 1. Masuk ke direktori proyek
cd c:\flutter\PayKas

# 2. Ambil dependensi
flutter pub get

# 3. Jalankan aplikasi di emulator atau perangkat yang terhubung (Chrome, Windows, Android)
flutter run
```
