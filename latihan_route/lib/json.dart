import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// menampung data hasil pemanggilan API
class JsonCat {
  String fakta;
  int panjang;
  JsonCat({required this.fakta, required this.panjang}); //constructor
  // create objek JsonCat dan isi atributnya dari json
  factory JsonCat.fromJson(Map<String, dynamic> json) {
    return JsonCat(
      fakta: json['fact'],
      panjang: json['length'],
    );
  }
}



void main() {
  runApp(const JsonCatApp());
}

class JsonCatApp extends StatelessWidget {
  const JsonCatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'JsonCat',
      home: JsonCatScreen(),
    );
  }
}

class JsonCatScreen extends StatefulWidget {
  const JsonCatScreen({super.key});

  @override
  State<JsonCatScreen> createState() => _JsonCatScreenState();
}

class _JsonCatScreenState extends State<JsonCatScreen> {
  late Future<JsonCat> futureJsonCat; //menampung hasil
  late Future<int> respPost; //201 artinya berhasil
  String url = "https://catfact.ninja/fact";
  String urlPost = "http://localhost:3000/tambah_mhs";

  @override
  void initState() {
    super.initState();
    futureJsonCat = fetchData();
    respPost = Future.value(0); //init
  }

  Future<int> insertData() async {
    //data disimpan di body
    final response = await http.post(
      Uri.parse(urlPost),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        "nim": "13594022",
        "nama": "Sandra Permana",
        "id_prov": "12",
        "angkatan": "2020",
        "tinggi_badan": 190,
      }),
    );
    return response.statusCode; //sukses kalau 201
  }

  //fetch data di method ini
  Future<JsonCat> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // jika server mengembalikan 200 OK artinya berhasil,
      // parse json, return objek JsonCat yang terisi
      return JsonCat.fromJson(jsonDecode(response.body));
    } else {
      // jika gagal (bukan 200 OK),
      // lempar exception
      throw Exception('Gagal panggil API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JsonCat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<JsonCat>(
              future: futureJsonCat,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data!.fakta),
                        Text(snapshot.data!.panjang.toString())
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // default: loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  respPost = insertData(); //jika return 201 artinya sukses
                });
              },
              child: const Text('Klik Untuk Insert data (POST)'),
            ),
            const Text("Hasil:"),
            FutureBuilder<int>(
              future: respPost,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data! == 201) {
                    return const Text("Proses Insert Berhasil!");
                  }
                  if (snapshot.data == 0) {
                    return const Text("");
                  } else {
                    return const Text("Proses insert gagal");
                  }
                }
                // default: loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
