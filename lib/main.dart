import 'dart:convert';
import 'dart:io';
import 'package:f1_pedia/seasondetail.dart';
import 'package:f1_pedia/mainpage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
 HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 Pedia',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Seasons>> seasons;
  @override
  void initState() {
    super.initState();
    seasons = fetchSeasonsList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'DAFTAR SIRKUIT',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    // height: 200.0,
                    child: FutureBuilder<List<Seasons>>(
                        future: seasons,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length ?? 0, // Gunakan null-aware operator
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Card(
                                  borderOnForeground: false,
                                  shadowColor: Colors.black,
                                  color: Color.fromARGB(255, 0, 0, 0),
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
                                     snapshot.data?[index]?.name ?? 'Nama Tidak Tersedia',
                                      style: TextStyle(
                                          color: Colors.white,
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
                                          builder: (context) =>
                                              CircuitDriverPage(
                                            item: snapshot.data?[index]?.uuid ?? 'UUID_Tidak_Tersedia',
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
        ),
      ),
    );
  }
}

class Seasons {
  String name;
  String uuid;
  // String image;
  // String president;

  // final String rating;

  Seasons({
    required this.uuid,
    required this.name,
    // this.president,
    // this.image,

    // this.rating,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) {
    return Seasons(
      uuid: json['circuitId'],
      name: json['circuitName'],
      // image: json['logo'],
      // president: json['president'],

      // rating: json['rating'],
    );
  }
}

// function untuk fetch api
Future<List<Seasons>> fetchSeasonsList() async {
  // var headers = {
  //   "content-type": "application/json",
  //   'x-rapidapi-host': 'api-formula-1.p.rapidapi.com',
  //   'x-rapidapi-key': 'cf5aae3f2dmshcd438ec09b4c502p162dbfjsn5f4c66d38bea',
  // };
  String api =
      'https://my-json-server.typicode.com/alpitou/f1pedia/circuit';
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
    //         driversShowsJson.map((top) => Seasons.fromJson(top)).toList();
    var driversShowsJson = jsonDecode(response.body) as List,
        driversShows =
            driversShowsJson.map((top) => Seasons.fromJson(top)).toList();

    return driversShows;
  } else {
    throw Exception('Failed to load drivers');
  }
}
