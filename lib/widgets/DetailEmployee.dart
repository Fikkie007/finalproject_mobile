import 'package:flutter/material.dart';
import 'package:my_first_app/models/employee.dart';

class DetailEmployee extends StatelessWidget {
  final employee;
  const DetailEmployee({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Employee',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Name',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            employee.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Address',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            employee.address,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Service Category',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            employee.category,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Phone Number',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            employee.nohandphone,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red, minimumSize: const Size.fromHeight(50)),
              onPressed: () => Navigator.pop(context),
              child: Text("Close"))
        ],
      ),
    );
  }
}
