import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_dio/models/post_model.dart';
import 'package:learn_dio/services/json_placeholder_servise.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class JsonPlaceholder extends StatefulWidget {
  const JsonPlaceholder({super.key});

  @override
  State<JsonPlaceholder> createState() => _JsonPlaceholderState();
}

class _JsonPlaceholderState extends State<JsonPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => setState((){}),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.threeRotatingDots(color: Colors.blue, size: 50)
              );
            } else if(snapshot.hasData){
              if(snapshot.data != null){
                List<PostModel> posts = List<PostModel>.from(jsonDecode(snapshot.data!).map((e) => PostModel.fromJson(e)));
                return ListView.separated(
                  itemCount: posts.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    PostModel postModel = posts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("UserId: ${postModel.userId}, id: ${postModel.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text("${postModel.title}\n\n"),
                            Text(postModel.body),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                const Center(child: Text("Xatolik yuz berdi"));
              }
            }

            return const Center(child: Text("Xatolik yuz berdi"));
          },
        ),
      ),
    );
  }
}
