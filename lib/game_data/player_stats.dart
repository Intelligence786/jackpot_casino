import 'dart:async';

class PlayerStats
{
  static double balance = 10000;

  static final _balanceController = StreamController<double>.broadcast();

  static Stream<double> get balanceStream => _balanceController.stream;

  static void incraseBalance(double amount) {
    balance += amount;
    _balanceController.add(balance);
  }

  static void decreaseBalance(double amount) {
    balance -= amount;
    if (balance < 0) balance = 0;
    _balanceController.add(balance);
  }

}