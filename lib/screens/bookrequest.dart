import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:read_and_brew/models/requestbuku.dart';
import 'package:read_and_brew/screens/booklist_detail.dart';
import 'package:read_and_brew/widgets/left_drawer.dart';
import 'package:read_and_brew/screens/login.dart';
import 'package:read_and_brew/screens/bookrequest_detail.dart';

class RequestBukuPage extends StatefulWidget {
    const RequestBukuPage({Key? key}) : super(key: key);

    @override
    _RequestBukuPageState createState() => _RequestBukuPageState();
}

class _RequestBukuPageState extends State<RequestBukuPage> {
final _formKey = GlobalKey<FormState>();
String _judul = "";
String _kategori = "";
String _penulis = "";
String _gambar = "";
Future<List<RequestBuku>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://readandbrew-c08-tk.pbp.cs.ui.ac.id/bookrequest/get_books');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<RequestBuku> list_product = [];
    for (var d in data) {
        if (d != null ) {
            list_product.add(RequestBuku.fromJson(d));
        }
    }
    return list_product;
}

@override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Buku'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Belum ada request buku.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(requestBuku: snapshot.data![index]),
                      ),
                    );
                  },
                  child:
                   Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                      await showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40,
                                      top: -40,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Gambar",
                                                labelText: "Gambar",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _gambar = value!;
                                                });
                                              },
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Gambar tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Judul Buku",
                                                labelText: "Judul Buku",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _judul = value!;
                                                });
                                              },
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Judul tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Judul Buku",
                                                labelText: "Judul Buku",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _judul = value!;
                                                });
                                              },
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Judul tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Kategori",
                                                labelText: "Kategori",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _kategori = value!;
                                                });
                                              },
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Kategori tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.green),
                                              ),
                                              child: const Text('Submit',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  final response =
                                                      await request.postJson(
                                                          "https://readandbrew-c08-tk.pbp.cs.ui.ac.id/bookrequest/create_request_flutter/",
                                                          jsonEncode(<String,
                                                              String>{
                                                            "judul": _judul,
                                                            "kategori":
                                                                _kategori,
                                                            "penulis": _penulis,
                                                            "gambar": _gambar,
                                                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                                          }));
                                                  if (response['status'] ==
                                                      'success') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          response['messages']),
                                                    ));
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RequestBukuPage()),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          response['messages']),
                                                    ));
                                                  }
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                          child: Text('Tombol Request Sementara'),
                        ),
                        Text(
                          "${snapshot.data![index].fields.judul}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].fields.penulis}"),
                        const SizedBox(height: 10),
                        Text(
                            "${snapshot.data![index].fields.kategori}")
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}