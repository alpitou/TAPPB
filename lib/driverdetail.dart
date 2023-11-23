import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class DetailDriverPage extends StatefulWidget {
  final String item;

  const DetailDriverPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _DetailDriverPageState createState() => _DetailDriverPageState();
}

class _DetailDriverPageState extends State<DetailDriverPage> {
  late Future<List<DriverDetail>> detail;

  @override
  void initState() {
    super.initState();
    detail = fetchDetails(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1D2B),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff1F1D2B),
        title: Text(
          'DETAIL PEMBALAP',
          style: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<List<DriverDetail>>(
            future: detail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0, // Gunakan null-aware operator
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Card(
                      borderOnForeground: false,
                      shadowColor: Colors.black,
                      color: Color(0xffFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Nama = " + (snapshot.data?[index]?.givenName ?? "")),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(snapshot.data?[index]?.familyName ?? ""),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Tanggal Lahir = " + (snapshot.data?[index]?.hbd ?? "")),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Asal Negara = " + (snapshot.data?[index]?.nationality ?? "")),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return Center(
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DriverDetail {
  String uuid;
  String givenName;
  String familyName;
  String nationality;
  String hbd;

  DriverDetail({
  required this.uuid,
  required this.givenName,
  required this.familyName,
  required this.nationality,
  required this.hbd,
});

  factory DriverDetail.fromJson(Map<String, dynamic> json) {
    return DriverDetail(
      uuid: json['driverId'],
      givenName: json['givenName'],
      familyName: json['familyName'],
      nationality: json['nationality'],
      hbd: json['dateOfBirth'],
    );
  }
}

Future<List<DriverDetail>> fetchDetails(uuid) async {
  String api = 'https://my-json-server.typicode.com/alpitou/f1pedia/driver?driverId=$uuid';
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    var driversShowsJson = jsonDecode(response.body) as List;
    var driversShows = driversShowsJson.map((top) => DriverDetail.fromJson(top)).toList();

    return driversShows;
  } else {
    throw Exception('Failed to load drivers');
  }
}
