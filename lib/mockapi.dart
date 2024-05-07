import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dio/loading.dart';
import 'package:learn_dio/models/procut_model.dart';
import 'package:learn_dio/services/mockapi_servise.dart';
import 'package:lottie/lottie.dart';

import 'creage_product.dart';
import 'edit_or_delete.dart';
import 'item_detail.dart';

class MockApi extends StatefulWidget {
  const MockApi({super.key});

  @override
  State<MockApi> createState() => _MockApiState();
}

class _MockApiState extends State<MockApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: data(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) return Loading.loadingMockApi();
          if(snapshot.hasData) return snapshot.data ?? const Center(child: Text('Nimadir xato ketdi'));
          return const Center(child: Text("Xatolik yuz berdi"));
        },
      ),
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const CreateProduct())).then((value) => setState((){})),
        child: Container(
          width: 90,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 5),
              Text("Add", style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> data() async {
    List? result = await MockApiService.get(MockApiService.apiAllProducts);

    if(result != null){
      List<ProductModel> products = List<ProductModel>.from(result.map((e) => ProductModel.fromJson(e)));

      if(products.isEmpty){
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
        child: ListView.separated(
          itemCount: products.length,
          padding: const EdgeInsets.symmetric(vertical: 10),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            ProductModel productModel = products[index];
            return InkWell(
              onLongPress: () => editOrDelete(
                context,
                productModel,
                (title, price) async {
                  Loading.loading(context);
                  productModel.title = title;
                  productModel.price = price;
                  bool result = await MockApiService.put(MockApiService.apiAllProducts, productModel.id, productModel.toJson);
                  Navigator.pop(context);

                  if(result){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Muvofaqiyatli amalga oshirildi"),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Xatolik yuz berdi"),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                        )
                    );
                  }

                  setState(() {});
                },
                () async {
                Navigator.pop(context);
                Loading.loading(context);
                bool result = await MockApiService.deleteProduct(MockApiService.apiAllProducts, productModel.id, productModel.toJson);
                log("message $result");
                Navigator.pop(context);

                if(result){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Muvofaqiyatli amalga oshirildi"),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Xatolik yuz berdi"),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                    )
                  );
                }

                setState(() {});
              },
              ),
              onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => Details(productModel: productModel))),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF0EFF4),
                  border: Border.all(color: const Color(0xffDFE1E7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: double.infinity,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(productModel.thumbnail),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productModel.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text("Brand: ${productModel.brand}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text("Category: ${productModel.category}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Text('Price: ${productModel.price}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
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
}
