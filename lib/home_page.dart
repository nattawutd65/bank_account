import 'package:flutter/material.dart';
import 'add_page.dart'; // ปรับเปลี่ยนเป็น add_account_page.dart ถ้ามี
import 'bank_account.dart'; // เปลี่ยนเป็น bank_account.dart
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BankAccount> _accounts = []; // เปลี่ยนชื่อเป็น _accounts

  void _addAccount(BankAccount account) { // เปลี่ยนชื่อเป็น _addAccount
    setState(() {
      _accounts.add(account);
    });
  }

  void _deleteAccount(int index) { // เปลี่ยนชื่อเป็น _deleteAccount
    setState(() {
      _accounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บัญชีธนาคาร', style: TextStyle(fontWeight: FontWeight.bold)), // เปลี่ยนชื่อ AppBar
        backgroundColor: Colors.blue, // เปลี่ยนสีเป็นสีน้ำเงิน
      ),
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          return Dismissible(
            key: Key(account.accountNumber), // เปลี่ยนเป็น accountNumber
            onDismissed: (direction) {
              _deleteAccount(index);
            },
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.blue.withOpacity(0.3), // เปลี่ยนสีเป็นสีน้ำเงิน
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue, // เปลี่ยนสีเป็นสีน้ำเงิน
                  child: Icon(Icons.account_balance, color: Colors.white), // เปลี่ยนไอคอน
                ),
                title: Text(
                  account.accountName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'หมายเลขบัญชี: ${account.accountNumber}\nยอดเงิน: ${account.balance.toStringAsFixed(2)} บาท\nประเภท: ${account.accountType}', // ปรับเปลี่ยน subtitle
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newAccount = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()), // ปรับเปลี่ยนเป็น AddAccountPage
          );
          if (newAccount != null) {
            _addAccount(newAccount);
          }
        },
        label: Text('เพิ่มบัญชี', style: TextStyle(color: Colors.white)), // เปลี่ยนข้อความ
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue, // เปลี่ยนสีเป็นสีน้ำเงิน
      ),
    );
  }
}