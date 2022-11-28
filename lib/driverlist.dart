import 'dart:convert';

import 'package:f1_pedia/driverdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriverList extends StatefulWidget {
  const DriverList({Key key}) : super(key: key);

  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  Future<List<Drivers>> drivers;
  @override
  void initState() {
    super.initState();
    drivers = fetchDriverList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'DAFTAR PEMBALAP',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                // height: 200.0,
                child: FutureBuilder<List<Drivers>>(
                    future: drivers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Card(
                              borderOnForeground: false,
                              shadowColor: Colors.black,
                              color: Color(0xffFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                // leading: CircleAvatar(
                                //   backgroundColor: Colors.transparent,
                                //   backgroundImage:
                                //       AssetImage('assets/2.jpg'),
                                //   radius: 25.0,
                                // ),
                                title: Text(
                                  snapshot.data[index].uuid,
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      letterSpacing: .5,
                                      fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                // subtitle: Text(
                                //   snapshot.data[index].president,
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       letterSpacing: .5,
                                //       fontSize: 12),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailDriverPage(
                                        item: snapshot.data[index].uuid,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Drivers {
  String givenName;
  String uuid;
  String familyName;

  Drivers({
    this.uuid,
    this.givenName,
    this.familyName,
  });

  factory Drivers.fromJson(Map<String, dynamic> json) {
    return Drivers(
      uuid: json['driverId'],
      givenName: json['givenName'],
      familyName: json['familyName'],
    );
  }
}

// function untuk fetch api
Future<List<Drivers>> fetchDriverList() async {
  // var headers = {
  //   "content-type": "application/json",
  //   'x-rapidapi-host': 'api-formula-1.p.rapidapi.com',
  //   'x-rapidapi-key': 'cf5aae3f2dmshcd438ec09b4c502p162dbfjsn5f4c66d38bea',
  // };
  String api = 'http://ergast.com/api/f1/drivers.json';
  final response = await http.get(
    Uri.parse(api),
    // headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
    print(response.statusCode);
    var driversShowsJson = jsonDecode(response.body)["MRData"]['DriverTable']
            ['Drivers'] as List,
        driversShows =
            driversShowsJson.map((top) => Drivers.fromJson(top)).toList();

    return driversShows;
  } else {
    throw Exception('Failed to load drivers');
  }
}
