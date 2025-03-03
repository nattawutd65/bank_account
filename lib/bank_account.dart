class BankAccount {
  final String accountName;
  final double balance;
  final String accountNumber;
  final String accountType;
  final DateTime date; // เพิ่มฟิลด์ date

  BankAccount({
    required this.accountName,
    required this.balance,
    required this.accountNumber,
    required this.accountType,
    required this.date, // เพิ่ม date ใน constructor
  });
}