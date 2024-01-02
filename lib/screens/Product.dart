import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertask/screens/ProductDetails.dart';
import 'package:fluttertask/screens/Productcategory.dart';
import 'package:fluttertask/model/MainUser.dart';
import 'package:http/http.dart' as http;

class Product extends StatefulWidget {
  var name="";
  Product({required this.name});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<MainUser>? allData;
  getData() async
  {
    Uri url= Uri.parse("https://dummyjson.com/products/category/"+widget.name);
    var response = await http.get(url);
    if(response.statusCode==200) {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        allData = json["products"].map<MainUser>((obj) => MainUser.fromJson(obj)).toList();
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: (allData == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: allData!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {


                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProductDetails(
                          id: allData![index].id.toString(),
                        )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(allData![index].thumbnail.toString()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allData![index].title.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  allData![index].brand.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "Rs. " + allData![index].price.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  allData![index].description.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allData![index].category.toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          allData![index].rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
