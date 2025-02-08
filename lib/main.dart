import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  List<Map<String, String>> employees = [];

  void _addEmployee() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        employees.add({
          'name': _nameController.text,
          'age': _ageController.text,
          'salary': _salaryController.text,
        });
        _nameController.clear();
        _ageController.clear();
        _salaryController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee Added Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter salary';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: _addEmployee,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text('Add Employee'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text('Employee List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            employees.isEmpty
                ? Text('No employees added yet.')
                : DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age')),
                DataColumn(label: Text('Salary')),
              ],
              rows: employees
                  .map(
                    (emp) => DataRow(
                  cells: [
                    DataCell(Text(emp['name']!)),
                    DataCell(Text(emp['age']!)),
                    DataCell(Text(emp['salary']!)),
                  ],
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: AddEmployeeScreen(),
  theme: ThemeData(
    scaffoldBackgroundColor: Color(0xFFFDF7FF),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFDF7FF),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  ),
));
