import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testapi/model/apiurls.dart';
import 'package:http/http.dart' as http;
import 'package:testapi/model/searchmodel.dart';
import 'dart:convert';

import 'package:testapi/model/subordinatemodel.dart';
import 'package:testapi/model/usermodel.dart';
import 'package:testapi/model/userviewprovider.dart';

class SearchIntegrateApi extends StatefulWidget {
  const SearchIntegrateApi({super.key});

  @override
  State<SearchIntegrateApi> createState() => _SearchIntegrateApiState();
}

class _SearchIntegrateApiState extends State<SearchIntegrateApi> {

  UserViewProvider userProvider = UserViewProvider();

  final TextEditingController searchCon = TextEditingController();
  int? responseStatuscode;
  int selectedTierIndex = 0;

  List<SubordinateModel> sundataitem = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Search API Implementation',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: searchCon,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: "Search",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchData(searchCon.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchData(String search) async {
    print("Starting searchData function");

    try {
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();

      final response = await http.get(
        Uri.parse("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&u_id=$search"),
      );

      if (kDebugMode) {
        print("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&u_id=$search");
        print("HTTP GET request sent");
      }

      setState(() {
        responseStatuscode = response.statusCode;
      });

      if (response.statusCode == 200) {
        List<SubordinateModel> searchResult = sundataitem.where((data) => data.u_id.toString().contains(search)).toList();
        print(searchResult);
        print("Search results filtered");

        setState(() {
          sundataitem = searchResult;
          print(sundataitem);
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print("Data not found");
        }
      } else {
        setState(() {
          sundataitem = [];
        });
        throw Exception("Failed to load data");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error in searchData function: $error");
      }
      throw Exception("Error in searchData function: $error");
    }
  }
}

