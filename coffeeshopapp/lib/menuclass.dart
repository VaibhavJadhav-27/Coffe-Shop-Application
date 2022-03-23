// ignore_for_file: empty_constructor_bodies

class Menu {
  late int itemid;
  late String itemname;
  late String itemdesc;
  late String itemcategory;
  late String itemimage;
  late int itemprice;

  Menu(this.itemid, this.itemname, this.itemdesc, this.itemcategory,
      this.itemimage, this.itemprice);

  /*
  Menu.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    itemname = json['itemname'];
    itemdesc = json['itemdesc'];
    itemcategory = json['itemcategory'];
    itemimage = json['itemimage'];
    itemprice = json['itemprice'];
  }*/
}
