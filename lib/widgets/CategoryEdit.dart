import 'package:flutter/widgets.dart';
import 'package:my_first_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;
  final Function categoryCallback;
  final BuildContext _modalContext;

  CategoryEdit(this.category, this.categoryCallback, this._modalContext,
      {Key? key})
      : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
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
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: categoryNameController,
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
                          child: Text('Save'),
                          onPressed: () => saveCategory(context),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: const Size.fromHeight(50)),
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ]),
                  Text(errorMessage, style: TextStyle(color: Colors.red))
                ]))));
  }

  Future saveCategory(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.category.name = categoryNameController.text;

    await widget.categoryCallback(widget.category);
    Navigator.pop(context);
    Navigator.pop(widget._modalContext);
  }
}
