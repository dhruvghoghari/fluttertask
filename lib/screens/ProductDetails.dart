import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {

  var id = "";
  ProductDetails({required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var title="";
  var image ="";
  var description="";
  var price="";
  var discountPercentage="";
  var rating="";
  var brand="";
  var category= "";

  
  getData() async
  {
    Uri url = Uri.parse("https://dummyjson.com/products/"+widget.id);
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        setState(() {

          title = json["title"].toString();
          image = json["thumbnail"].toString();
          description = json["description"].toString();
          price = json["price"].toString();
          discountPercentage = json["discountPercentage"].toString();
          rating = json["rating"].toString();
          brand = json["brand"].toString();
          category = json["category"].toString();

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
        title: Text(title),
      ),
      body: (title == "")
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(image,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title : "+title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text("brand : "+ brand,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Rs. " + price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16.0,
                        ),
                      ),
                        Text("Discount: -" + discountPercentage.toString() + "%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(description.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(category.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 18.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(rating.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Other widgets can be added here as part of the Column children
            ],
          ),
        ),
      ),
    );

    // Image.network(image),
              // Text("Title : "+title),
              // Text("description : "+description),
              // Text("price : "+price),
              // Text("discountPercentage : "+discountPercentage),
              // Text("rating : "+rating),
  }
}
