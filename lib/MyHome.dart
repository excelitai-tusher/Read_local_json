import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_json/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items = data.data as List<ProductDataModel>;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height*.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(image: NetworkImage(items[index].imageUrl.toString()),fit: BoxFit.fill,),
                            ),
                            Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8),
                                          child: Text(items[index].name.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8),
                                          child: Text(items[index].price.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },

      ),
    );
  }
  Future<List<ProductDataModel>>ReadJsonData()async{
    final jsonData = await rootBundle.rootBundle.loadString('jsonFile/productList.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ProductDataModel.fromJson(e)).toList();

  }
}
