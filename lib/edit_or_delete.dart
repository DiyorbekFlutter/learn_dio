import 'package:flutter/material.dart';
import 'package:learn_dio/models/procut_model.dart';

Future<void> editOrDelete(BuildContext context, ProductModel productModel, void Function(String title, int price) edit, void Function() delete){
  String language = 'edit';
  bool isShowList = true;
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: isShowList ? _list(context, (String lang){
          isShowList = false;
          language = lang;
          setState((){});
        }) : language == 'edit' ? _edit(context, productModel, edit, (){
          isShowList = true;
          setState((){});
        }) : _delete(context, delete, () {
          isShowList = true;
          setState((){});
        }),
      ),
    ),
  );
}

Widget _list(BuildContext context, void Function(String lang) onTap){
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Text("Edit products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Spacer(),
          InkWell(
            onTap: () => Navigator.pop(context),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 15),
      InkWell(
        onTap: () => onTap('edit'),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: const Row(
          children: [
            Icon(Icons.edit, color: Colors.blue),
            SizedBox(width: 10),
            Text("Productni tahrirlash", style: TextStyle(fontSize: 18)),
            Spacer(),
            Text('')
          ],
        ),
      ),
      const Divider(),
      InkWell(
        onTap: () => onTap('delete'),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: const Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 10),
            Text("O'chirib tashlash", style: TextStyle(fontSize: 18)),
            Spacer(),
            Text('')
          ],
        ),
      ),
    ],
  );
}

Widget _edit(BuildContext context, ProductModel productModel, void Function(String title, int price) edit, void Function() back){
  final TextEditingController title = TextEditingController(text: productModel.title);
  final TextEditingController price = TextEditingController(text: productModel.price.toString());
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          InkWell(
            onTap: back,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 10),
          const Text("Tahrirlash", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
      const SizedBox(height: 15),
      TextField(
        controller: title,
        decoration: InputDecoration(
          hintText: "Title",
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: price,
        decoration: InputDecoration(
          hintText: "Price",
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
        ),
      ),
      Row(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: (){
              edit(title.text.trim(), int.parse(price.text.trim()));
              Navigator.pop(context);
            },
            child: const Text("Update",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
            ),
          )
        ],
      )
    ],
  );
}

Widget _delete(BuildContext context, void Function() delete, void Function() back){
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          InkWell(
            onTap: back,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 10),
          const Text("O'chirish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
      const SizedBox(height: 15),
      const Text("Ushbu elementni o'chiribtashlamoqchimisiz?"),
      const SizedBox(height: 15),
      Row(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: delete,
            child: const Text("O'chirish",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
            ),
          )
        ],
      )
    ],
  );
}
