import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertask/screens/Product.dart';
import 'package:http/http.dart' as http;

class Productcategory extends StatefulWidget {


  @override
  State<Productcategory> createState() => _ProductcategoryState();
}

class _ProductcategoryState extends State<Productcategory> {


  Future<List>? allcategory;

  Future<List> getdata() async
  {
    Uri url= Uri.parse("https://dummyjson.com/products/categories");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;
    }
    else
      {
        return [];
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allcategory = getdata();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: allcategory,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
            {
              if(snapshot.data!.length<=0)
                {
                  return Center(
                    child: Text("No Category"),
                  );
                }
              else
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index)
                    {
                      return ListTile(
                        title: Text(snapshot!.data![index].toString()),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>Product(name: snapshot!.data![index].toString(),))
                          );
                        },
                      );
                    },
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
