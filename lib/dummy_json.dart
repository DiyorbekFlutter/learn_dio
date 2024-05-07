import 'package:flutter/material.dart';
import 'package:learn_dio/services/dio_service.dart';
import 'package:lottie/lottie.dart';

import 'fount_data.dart';
import 'loading.dart';
import 'models/all_products_model.dart';
import 'models/procut_model.dart';

class DummyJson extends StatefulWidget {
  const DummyJson({super.key});

  @override
  State<DummyJson> createState() => _DummyJsonState();
}

class _DummyJsonState extends State<DummyJson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: searching(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Loading.loadingDummyJson();
          } else if(snapshot.hasData){
            return snapshot.data ?? const Center(child: Text('Nimadir xato ketdi'));
          } else {
            return const Center(child: Text('Nimadir xato ketdi'));
          }
        },
      ),
    );
  }

  Future<Widget> searching() async {
    Map<String, dynamic>? result = await DioService.get(DioService.apiAllProducts);

    if(result != null){
      AllProductsModel allProductsModel = AllProductsModel.fromJson(result);

      if(allProductsModel.products.isEmpty){
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.not_interested, color: Colors.red, size: 30),
              SizedBox(height: 10),
              Text("Not Found", style: TextStyle(color: Colors.grey, fontSize: 20))
            ],
          ),
        );
      }

      return RefreshIndicator(
          onRefresh: () async => setState((){}),
          child: FoundData(allProductsModel: allProductsModel)
      );
    } else {
      return RefreshIndicator(
          onRefresh: () async => setState((){}),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/lottie/no_internet.json"),
                ),
              ),
            ],
          )
      );
    }
  }

  List<ProductModel> searchProduct(List<ProductModel> products){
    products = products.where((element) {
      return element.title.toLowerCase().contains(''.toLowerCase())
          || element.brand.toLowerCase().contains(''.toLowerCase());
    }).toList();
    return products;
  }
}
