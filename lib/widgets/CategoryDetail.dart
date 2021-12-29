import 'package:flutter/material.dart';
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/providers/CategoryProvider.dart';
import 'package:my_first_app/widgets/CategoryEdit.dart';
import 'package:provider/provider.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  final Function categoryCallback;
  const CategoryDetail(
      {Key? key, required this.categoryCallback, required this.category})
      : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    categoryNameController.text = widget.category.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: categoryNameController,
                    enabled: false,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter category name';
                      }

                      return null;
                    },
                    onChanged: (text) => setState(() => errorMessage = ''),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Category name',
                    ),
                  ),
                  Spacer(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () => showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext ctx) {
                                return CategoryEdit(widget.category,
                                    provider.updateCategory, context);
                              }),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              minimumSize: const Size.fromHeight(50)),
                          child: Text('Delete'),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirmation"),
                                  content:
                                      Text("Are you sure you want to delete?"),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                        child: Text("Delete"),
                                        onPressed: () => deleteCategory(
                                            provider.deleteCategory,
                                            widget.category,
                                            context)),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                minimumSize: const Size.fromHeight(50)),
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"))
                      ]),
                  Text(errorMessage, style: TextStyle(color: Colors.red))
                ]))));
  }

  Future deleteCategory(
      Function callback, Category category, BuildContext ctx) async {
    await callback(category);
    Navigator.pop(ctx);
    Navigator.pop(context);
  }
}
