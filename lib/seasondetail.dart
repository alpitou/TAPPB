import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class CircuitDriverPage extends StatefulWidget {
  final String item;
  CircuitDriverPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _CircuitDriverPageState createState() => _CircuitDriverPageState();
}

class _CircuitDriverPageState extends State<CircuitDriverPage> {
  late Future<List<SeasonDetail>> detail;

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
          'DETAIL SIRKUIT',
          style:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<List<SeasonDetail>>(
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
                      color: Color(0xffF5F5DC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text("Year = " + snapshot.data[index].uuid),
                            SizedBox(
                              height: 4,
                            ),
                            Text("GP = ${snapshot.data?[index]?.location?.locality ?? 'Local_Tidak_Tersedia'}"),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Nama Sirkuit = ${snapshot.data?[index]?.name ?? 'Nama_Tidak_Tersedia'}"),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Negara = ${snapshot.data?[index]?.location?.country ?? 'Negara_Tidak_Tersedia'}"),
                          ],
                        ),
                      )),
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
        )),
      ),
    );
  }
}

class SeasonDetail {
  String name;
  String uuid;

  Location location;

  SeasonDetail({required this.uuid, required this.name, required this.location});

  factory SeasonDetail.fromJson(json) {
    return SeasonDetail(
      name: json['circuitName'],
      uuid: json['circuitId'],
      location: Location.fromJson(json['Location']),
    );
  }
}

class Location {
  String locality;
  String country;

  Location({required this.locality, required this.country});

  factory Location.fromJson(json) {
    return Location(
      locality: json['locality'],
      country: json['country'],
    );
  }
}

Future<List<SeasonDetail>> fetchDetails(uuid) async {
  String api =
      'https://my-json-server.typicode.com/alpitou/f1pedia/circuit?circuitId=$uuid';
  final response = await http.get(
    Uri.parse(api),
    // headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
    print(response.statusCode);
    // var driversShowsJson = jsonDecode(response.body)["MRData"]['CircuitTable']
    //         ['Circuits'] as List,
    //     driversShows =
    //         driversShowsJson.map((top) => SeasonDetail.fromJson(top)).toList();

    var driversShowsJson = jsonDecode(response.body) as List,
        driversShows =
            driversShowsJson.map((top) => SeasonDetail.fromJson(top)).toList();
    return driversShows;
  } else {
    throw Exception('Failed to load drivers');
  }
}
