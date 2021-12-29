import 'package:flutter/material.dart';
import 'package:my_first_app/models/employee.dart';
import 'package:my_first_app/widgets/DetailEmployee.dart';

class ListEmploye extends StatelessWidget {
  const ListEmploye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pekerja"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: dummyEmploye().length,
            itemBuilder: (context, index) {
              Employee emp = dummyEmploye()[index];
              return Card(
                margin: EdgeInsets.all(5.0),
                child: ListTile(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (ctx) => DetailEmployee(employee: emp)),
                  title: Text(emp.name),
                  subtitle: Text(emp.category),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Employee> dummyEmploye() {
    final employee = [
      Employee(
          name: "Adam WIjaya",
          category: "Teknisi Elektronik",
          address: "Malang",
          nohandphone: "08xxxxxxxx"),
      Employee(
          name: "Suwandi",
          category: "Tukang Bangunan",
          address: "Malang",
          nohandphone: "08xxxxxxxx"),
      Employee(
          name: "Wahyu Nugroho",
          category: "Mekanik",
          address: "Malang",
          nohandphone: "08xxxxxxxx"),
    ];
    return employee;
  }
}
