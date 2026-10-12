import 'package:flutter/material.dart';

class CreditCardsPage extends StatelessWidget {
  
  // TODO 1: GANTI VARIABEL INI DENGAN DATA DIRI ANDA
  final String namaMahasiswa = "Jeremy Lawrence"; // Jangan biarkan kosong!
  final String nimMahasiswa = "20245520007"; // Jangan biarkan kosong!

  @override
  Widget build(BuildContext context) {
    
    // TODO 2: BUAT LOGIKA KONDISIONAL BERDASARKAN NIM!
    // Aturan:
    // - Jika digit terakhir NIM Anda Ganjil: warnaKartu1 = Biru (0xFF090943), warnaKartu2 = Merah.
    // - Jika digit terakhir NIM Anda Genap: warnaKartu1 = Hitam (0xFF000000), warnaKartu2 = Hijau.
    // (Silakan tulis kode logika if-else Anda di sini sebelum return)
    Color warnaKartu1 = Color(0xFF090943); // <- Ubah agar dinamis menggunakan logika IF
    Color warnaKartu2 = Color(0xFF000000); // <- Ubah agar dinamis menggunakan logika IF

    if (int.parse(nimMahasiswa[nimMahasiswa.length - 1]) % 2 == 0) {
      // Digit terakhir NIM genap
      warnaKartu1 = Color(0xFF000000); // Hitam
      warnaKartu2 = Color(0xFF00FF00); // Hijau
    } else {
      // Digit terakhir NIM ganjil
      warnaKartu1 = Color(0xFF090943); // Biru
      warnaKartu2 = Color(0xFFFF0000); // Merah
    }


    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitleSection(
                title: "Rincian pembayaran",
                subTitle: "Bagaimana Anda ingin membayar?"),
            
            _buildCreditCard(
                color: warnaKartu1, 
                cardExpiration: "08/2026",
                cardHolder: namaMahasiswa, // Menggunakan variabel nama
                cardNumber: nimMahasiswa), // Menggunakan variabel NIM
            
            const SizedBox(
              height: 15,
            ),
            
            _buildCreditCard(
                color: warnaKartu2,
                cardExpiration: "05/2027",
                cardHolder: namaMahasiswa,
                cardNumber: "9874 4785 XXXX 6548"),
            
            _buildAddCardButton(
              icon: const Icon(Icons.add),
              color: const Color(0xFF081603),
            )
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PERINGATAN: DILARANG MENGUBAH NAMA FUNGSI DAN PARAMETER DI BAWAH INI!
  // JIKA ANDA MENGGUNAKAN AI GENERATOR SEPENUHNYA, STRUKTUR INI BIASANYA AKAN RUSAK.
  // ===========================================================================

  // Build the title section
  Column _buildTitleSection({required String title, required String subTitle}) {
    // TODO 3: Implementasikan UI untuk judul dan sub-judul di sini.
    // Terapkan TextStyle dengan font yang sesuai panduan.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // KODE UI ANDA DI SINI
        Text(
                    '$title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    
                  ),
        Text(
                    '$subTitle',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),

        // padding 1 
        Padding(
            padding: const EdgeInsets.all(8.0),

        ),
        // padding 2
        Padding(
            padding: const EdgeInsets.all(8.0),

        ),
      ],
    );
  }

  
  Row _buildDetailsBlock(String cardholder ,String cardExpiration) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CARDHOLDER',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              '$cardholder',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        SizedBox(width: 100), // Spacing between the two columns
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'VALID THRU',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              '$cardExpiration',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard({ 
      required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration }) {
    
    // TODO 4: Bangun UI kartu kredit di sini.
    // Wajib memanggil fungsi _buildLogosBlock() dan _buildDetailsBlock() di dalamnya.
    return Card(
      color: color,
      child: Container(
        height: 200,
        // KODE UI ANDA DI SINI
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLogosBlock(),
            Text(
              cardNumber,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailsBlock(cardHolder, cardExpiration),
              ],
            ), 
          ],
        ),
      ),
    );
  }

  // buat  top row containing logo
  Row _buildLogosBlock() {
    // TODO 5: Panggil asset gambar lokal "contact_less.png" dan "mastercard.png".
    // CATATAN: Atur posisi sejajar berlawanan (kiri dan kanan). 
    // AI teks tidak tahu dimensi resolusi asli gambar ini. Anda harus mengatur nilai width dan height 
    // secara manual agar gambar tidak pecah atau overflow (terpotong).
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,      
      children: <Widget>[
                
        // KODE GAMBAR ANDA DI SINI
        SizedBox(width: 1),
        Image.asset(
          'assets/images/contact_less.png',
          width: 30, 
          height: 30, 
        ),
        SizedBox(width: 180), 
        Image.asset(
          'assets/images/mastercard.png',
          width: 50, 
          height: 50, 
        ),
        SizedBox(width: 1), 
      ],
    );
  }
  // buat Column berisi kontainer dan Informasi

  // buat   FloatingActionButton
  Widget _buildAddCardButton({required Icon icon, required Color color}) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(

        onPressed: () {
        
        },
        child: icon,
        backgroundColor: color,
      ),
    ),
    );
  }
  // Build Column
  }