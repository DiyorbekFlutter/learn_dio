import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_dio/loading.dart';
import 'package:learn_dio/models/procut_model.dart';
import 'package:learn_dio/services/mockapi_servise.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final TextEditingController title = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController category = TextEditingController();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Create product", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stepper(
        onStepContinue: () async {
          if(currentStep == 0 && title.text.trim().isNotEmpty){
            currentStep++;
            setState(() {});
          } else if(currentStep == 1 && brand.text.trim().isNotEmpty){
            currentStep++;
            setState(() {});
          } else if(currentStep == 2 && price.text.trim().isNotEmpty){
            currentStep++;
            setState(() {});
          } else if(currentStep == 3 && category.text.trim().isNotEmpty){
            Loading.loading(context);
            ProductModel productModel = ProductModel(
              id: Random().nextInt(100),
              title: title.text.trim(),
              description: 'Ushbu product uchun description mavjud emas',
              price: Random().nextInt(1000) + 100,
              brand: brand.text.trim(),
              category: category.text.trim(),
              discountPercentage: Random().nextInt(1000),
              images: [
                "https://cdn.dummyjson.com/product-images/1/1.jpg",
                "https://cdn.dummyjson.com/product-images/1/2.jpg",
                "https://cdn.dummyjson.com/product-images/1/3.jpg",
                "https://cdn.dummyjson.com/product-images/1/4.jpg",
                "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
              ],
              rating: Random().nextInt(10),
              stock: Random().nextInt(10),
              thumbnail: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0YLBOsd-0L9jYjVAyOJmTAOzfSqlp_4PAeA&s"
            );

            bool result = await MockApiService.post(MockApiService.apiAllProducts, productModel.toJson);

            Navigator.pop(context);

            if(result){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Muvofaqiyatli amalga oshirildi"),
                  backgroundColor: Colors.black,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Xatolik yuz berdi"),
                  backgroundColor: Colors.black,
                  behavior: SnackBarBehavior.floating,
                )
              );
            }
          }
        },
        onStepCancel: (){
          if(currentStep != 0){
            currentStep--;
            setState(() {});
          }
        },
        currentStep: currentStep,
        steps: [
          Step(
            isActive: currentStep >= 0,
            title: const Text("Title"),
            content: TextField(
              autofocus: true,
              controller: title,
              decoration: InputDecoration(
                hintText: "Enter title",
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 1,
            title: const Text("Brand"),
            content: TextField(
              autofocus: true,
              controller: brand,
              decoration: InputDecoration(
                  hintText: "Enter brand",
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 2,
            title: const Text("Price"),
            content: TextField(
              autofocus: true,
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Ented price",
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 3,
            title: const Text("Category"),
            content: TextField(
              autofocus: true,
              controller: category,
              decoration: InputDecoration(
                  hintText: "Enter category",
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
