import 'dart:ffi';

class Order {
  late int orderid;
  late int custid;
  late String items;
  late int totalamount;
  late String payment_type;
  late DateTime ordertime;
  late String delivery_type;
  late String isreceived;

  Order(this.orderid, this.custid, this.items, this.totalamount,
      this.payment_type, this.ordertime, this.delivery_type, this.isreceived);
}
