
import 'dart:convert';

QsrProductModel qsrProductModelFromMap(String str) =>
    QsrProductModel.fromMap(json.decode(str));

String qsrProductModelToMap(QsrProductModel data) => json.encode(data.toMap());

class QsrProductModel {
  List<ProductLine> productLine;

  QsrProductModel({
    required this.productLine,
  });

  factory QsrProductModel.fromMap(Map<String, dynamic> json) => QsrProductModel(
    productLine: List<ProductLine>.from(json["product_line"]) == null
        ? []
        : List<ProductLine>.from(
        json["product_line"].map<ProductLine>((x) => ProductLine.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "product_line": List<dynamic>.from(productLine.map((x) => x.toMap())),
  };
}

class ProductLine {
  String id;
  String productName;
  String price;
  int qty;
  String customerName;
  List<Modifier> modifiers;
  String orderStatus;
  String? cartPrice;
  String? cartTax;
  String? cartNote;
  String? cartDiscount;
  bool? isSelected;
  bool paymentValue;
  double? paidAmount;
  String? invoiceNo;
  String? cookingTime;
  String? ticketNo;
  String status;

  ProductLine({
    required this.id,
    required this.productName,
    required this.price,
    required this.qty,
    required this.customerName,
    required this.modifiers,
    required this.orderStatus,
    required this.paymentValue,
    required this.paidAmount,
    required this.status,
    this.cartPrice,
    this.cookingTime,
    this.cartTax,
    this.cartNote,
    this.cartDiscount,
    this.isSelected,
    this.invoiceNo,
    this.ticketNo,
  });

  factory ProductLine.fromMap(Map<String, dynamic> json) => ProductLine(
    id: json['product_id'] ?? json["id"] ?? '',
    productName: json["product_name"] ?? '',
    price: json["price"] ?? '0.00',
    qty: json["qty"] ?? 1,
    paymentValue: json['paymentValue'] ?? false,
    paidAmount: json['paidAmount'] ?? 0.0,
    customerName: json["customer_name"] ?? '',
    cookingTime: json["cooking_time"],
    modifiers: json["modifiers"] != null
        ? List<Modifier>.from(
      json["modifiers"].map((x) => Modifier.fromMap(x)),
    )
        : [], // Handling the case when modifiers is null
    orderStatus: json["orderStatus"] ?? '',
    cartPrice: json["cartPrice"] ?? '0.00',
    cartTax: json["cartTax"] ?? '0.00',
    cartNote: json["cartNote"] ?? '',
    invoiceNo: json["invoice"],
    status: json["status"] ?? '',
    ticketNo: json["ticket_no"],
    cartDiscount: json["cartDiscount"] ?? '0.00',
    isSelected: json["isSelected"] ?? false,
  );


  Map<String, dynamic> toMap() => {
    "product_id": id,
    "product_name": productName,
    "price": price,
    "qty": qty,
    "status": status,
    "paymentValue": paymentValue,
    "cooking_time": cookingTime,
    "paymentStatus": paidAmount,
    "customer_name": customerName,
    "modifiers": List<dynamic>.from(modifiers.map((x) => x.toMap())),
    "orderStatus": orderStatus,
    "cartPrice": cartPrice,
    "cartTax": cartTax,
    "cartNote": cartNote,
    "cartDiscount": cartDiscount,
    "isSelected": isSelected,
    "ticket_no": ticketNo,
  };
}

class Modifier {
  String id;
  String name;
  String rate;
  String productId;
  String modifierId;

  Modifier({
    required this.id,
    required this.name,
    required this.rate,
    required this.productId,
    required this.modifierId,
  });

  factory Modifier.fromMap(Map<String, dynamic> json) => Modifier(
    id: json["id"]!=null?json["id"].toString(): '',
    productId: json["product_id"]!=null?json["product_id"].toString(): '',
    modifierId: json["modifier_id"]!=null?json["modifier_id"].toString(): '',
    name: json["name"] ?? '',
    rate: json["rate"] ??json["sell_price_inc_tax"]?? '0.00',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "rate": rate,
    "productId": productId,
    "modifier_id": modifierId,
  };
}
