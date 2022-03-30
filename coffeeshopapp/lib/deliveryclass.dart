// ignore_for_file: non_constant_identifier_names

class Delivery {
  late int deliveryid;
  late int custid;
  late int orderid;
  late String address;
  late String items;
  late int totalamount;
  late String isreceived;

  Delivery(this.deliveryid, this.custid, this.orderid, this.address, this.items,
      this.totalamount, this.isreceived);
}
