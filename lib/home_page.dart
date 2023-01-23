import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_api_list/models/user_model.dart';
import 'package:get_api_list/service/api.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Pertama kita buat method getNews() yang bertipe async untuk mengambil data dari API
  Future<List<User>> getUsers() async {
    // Kedua kita buat variabel url yang bertipe Uri dan kita parse urlnya menggunakan method parse()
    Uri url = Uri.parse(NewsService.URL);
    // Ketiga kita buat variabel response yang bertipe Future<http.Response> 
    //dan kita set value nya menggunakan method get() dari library http
    var response = await http.get(url);

    // Kita buat if else untuk mengecek apakah response.statusCode == 200
    // Jika iya maka kita akan mengambil data dari response.body
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // kita ambil data dari data yang kita panggil dengan key 'data' yang bertipe List
      var result = data['data'] as List;

      // Kita buat variabel list yang bertipe List<User> dan kita set value nya menggunakan method map()
      List<User> list = result.map((f) => User.fromJson(f)).toList();      
      return list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita buat body dari scaffold dengan menggunakan FutureBuilder
      body: FutureBuilder<List<User>>(
        // Kita set future nya menggunakan method getUsers()
        future: getUsers(),
        builder: (context, snapshot) {
          // Kita buat if else untuk mengecek apakah snapshot.hasData == true atau tidak
          // Jika tru maka kita akan mengambil data dari snapshot.data
          // Jika false maka kita akan menampilkan loading 
          if (snapshot.hasData) {
            return ListView.builder(
              // `snapshot.data` ini artinya kita akan mengambil data dari variabel snapshot.data
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(snapshot.data![index].avatar),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].lastName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            user: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}