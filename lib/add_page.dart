import 'package:flutter/material.dart';
import 'bank_account.dart';
import 'package:intl/intl.dart'; // เพิ่ม import intl

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _accountNumberController = TextEditingController();
  String _accountType = 'ออมทรัพย์';
  DateTime _selectedDate = DateTime.now(); // เพิ่มตัวแปร _selectedDate

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มบัญชี'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _accountNameController,
                decoration: InputDecoration(labelText: 'ชื่อบัญชี'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ชื่อบัญชี';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _balanceController,
                decoration: InputDecoration(labelText: 'ยอดเงิน'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ยอดเงิน';
                  }
                  if (double.tryParse(value) == null) {
                    return 'กรุณาใส่ตัวเลข';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(labelText: 'หมายเลขบัญชี'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่หมายเลขบัญชี';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _accountType,
                items: <String>['ออมทรัพย์', 'กระแสรายวัน']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _accountType = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'ประเภทบัญชี'),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "วันที่: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      BankAccount(
                        accountName: _accountNameController.text,
                        balance: double.parse(_balanceController.text),
                        accountNumber: _accountNumberController.text,
                        accountType: _accountType,
                        date: _selectedDate, // ส่งค่า _selectedDate
                      ),
                    );
                  }
                },
                child: Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}