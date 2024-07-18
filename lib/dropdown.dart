// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:testapi/main.dart';
// import 'package:testapi/model/tiermodel.dart';
// import 'package:http/http.dart' as http;
//
// import 'model/apiurls.dart';
//
// class DropDownScreen extends StatefulWidget {
//   const DropDownScreen({super.key});
//
//   @override
//   State<DropDownScreen> createState() => _DropDownScreenState();
// }
//
// class _DropDownScreenState extends State<DropDownScreen> {
//
//   @override
//   void initState() {
//     TierData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   int?responseStatuscode;
//
//   int selectedTierIndex = 0;
//
//   String dropdownvalue = 'Tier 1';
//
//   var items = [
//     'Tier 1',
//     'Tier 2',
//     'Tier 3',
//     'Tier 4',
//     'Tier 5',
//     'Tier 6',
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: Text(
//           'DropDown API implementation',
//           style: TextStyle(fontSize: 15),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//               padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
//               child: Text('Tier Dropdown',style: TextStyle(),)
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
//             child:Container(
//               width: width*0.8,
//               height: height*0.05,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.black,
//                   )
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     value: dropdownvalue,
//
//                     items: items.map((String items) {
//                       return DropdownMenuItem(
//                         value: items,
//                         child: Text(items,style: TextStyle(fontSize: 16),),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownvalue = newValue!;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   List<TierModel> tieritem = [];
//   Future<void> TierData() async {
//     final response = await http.get(Uri.parse(ApiUrl.TierApi),);
//     if (kDebugMode) {
//       print(ApiUrl.TierApi);
//       print('TierApi');
//     }
//
//     setState(() {
//       responseStatuscode = response.statusCode;
//     });
//
//     if (response.statusCode==200) {
//       final List<dynamic> responseData = json.decode(response.body)['data'];
//       print(responseData);
//
//       setState(() {
//         tieritem = responseData.map((item) => TierModel.fromJson(item)).toList();
//       });
//
//     }
//     else if(response.statusCode==400){
//       if (kDebugMode) {
//         print('Data not found');
//       }
//     }
//     else {
//       setState(() {
//         tieritem = [];
//       });
//       throw Exception('Failed to load data');
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapi/main.dart';
import 'package:testapi/model/tiermodel.dart';
import 'package:testapi/search.dart';
import 'model/apiurls.dart';

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({super.key});

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  @override
  void initState() {
    super.initState();
    TierData();
  }

  int? responseStatuscode;
  List<TierModel> tierItems = [];
  String? dropdownValue;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Tier Data API Implementation',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tierItems.isEmpty
          ? Center(child: Text('No data found'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(
              'Tier Dropdown',
              style: TextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Container(
              height: height*0.05,
              width: width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    items: tierItems.map((TierModel item) {
                      return DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(
                          item.name ?? 'No name',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchIntegrateApi()));
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> TierData() async {
    final response = await http.get(Uri.parse(ApiUrl.TierApi));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        tierItems = responseData.map((item) => TierModel.fromJson(item)).toList();
        if (tierItems.isNotEmpty) {
          dropdownValue = tierItems[0].name;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 400) {
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        throw Exception('Failed to load data');
      }
    }
  }
}

