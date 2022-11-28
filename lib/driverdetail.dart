import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class DetailDriverPage extends StatefulWidget {
  final String item;
  DetailDriverPage({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _DetailDriverPageState createState() => _DetailDriverPageState();
}

class _DetailDriverPageState extends State<DetailDriverPage> {
  Future<List<DriverDetail>> detail;

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
          style:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 15),
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
                itemCount: snapshot.data.length,
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
                            // Text("Year = " + snapshot.data[index].uuid),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "Nama = " + snapshot.data[index].givenName),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(snapshot.data[index].familyName),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Tanggal Lahir = " + snapshot.data[index].hbd),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Asal Negara = " +
                                snapshot.data[index].nationality),
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

class DriverDetail {
  String name;
  String uuid;
  String nationality;
  String givenName;
  String hbd;
  String familyName;

  // Location location;

  DriverDetail({
    this.uuid,
    this.name,
    this.familyName,
    this.givenName,
    this.nationality,
    this.hbd,
    // this.location,
  });

  factory DriverDetail.fromJson(json) {
    return DriverDetail(
      name: json['circuitName'],
      uuid: json['driverId'],
      familyName: json['familyName'],
      givenName: json['givenName'],
      nationality: json['nationality'],
      hbd: json['dateOfBirth'],
      // location: Location.fromJson(json['Location']),
    );
  }
}

// class Location {
//   String locality;
//   String country;

//   Location({this.locality, this.country});

//   factory Location.fromJson(json) {
//     return Location(
//       locality: json['locality'],
//       country: json['country'],
//     );
//   }
// }

Future<List<DriverDetail>> fetchDetails(uuid) async {
  String api =
      'https://my-json-server.typicode.com/danielandhika/F1geek/driver?driverId=$uuid';
  final response = await http.get(
    Uri.parse(api),
    // headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
    print(response.statusCode);
    // var driversShowsJson = jsonDecode(response.body)["MRData"]['DriverTable']
    //         ['Drivers'] as List,
    //     driversShows =
    //         driversShowsJson.map((top) => DriverDetail.fromJson(top)).toList();
    var driversShowsJson = jsonDecode(response.body) as List,
        driversShows =
            driversShowsJson.map((top) => DriverDetail.fromJson(top)).toList();

    return driversShows;
  } else {
    throw Exception('Failed to load drivers');
  }
}
