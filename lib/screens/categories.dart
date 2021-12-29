import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/CategoryAdd.dart';
import 'package:my_first_app/widgets/CategoryDetail.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/widgets/CategoryEdit.dart';
import 'package:my_first_app/providers/CategoryProvider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          Category category = categories[index];
          return Card(
              margin: EdgeInsets.all(15.0),
              child: ListTile(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => CategoryDetail(
                      categoryCallback: provider.updateCategory,
                      category: category),
                ),
                title: Text(category.name),
              ));
        },
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return CategoryAdd(provider.addCategory);
                });
          },
          child: Icon(Icons.add)),
    );
  }

  Future deleteCategory(
      Function callback, Category category, BuildContext ctx) async {
    await callback(category);
    Navigator.pop(ctx);
  }
}
