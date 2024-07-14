

import 'dart:convert';
import 'dart:typed_data';
import 'package:client_view_app/main.dart';
import 'package:client_view_app/model/kds_tip_model.dart';
import 'package:client_view_app/model/models.dart';
import 'package:client_view_app/screen/controller/client.dart';
import 'package:client_view_app/screen/receipt_screen.dart';
import 'package:client_view_app/screen/tip_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ClientController with ChangeNotifier{
  Client? _client;
  KdsSettings? _kdsSettings;
  double _subTotal = 0.00;
  double _totalDiscount = 0.00;
  double _totalTip = 0.00;
  double _totalGratuity = 0.00;
  double _totalTax = 0.00;
  int _totalGuest = 0;
  double _totalBill = 0.00;
  Client? get client => _client;
  KdsSettings? get kdsSettings=> _kdsSettings;
  double get subTotalGetter => _subTotal;
  int get totalGuest => _totalGuest;
  double get totalBillGetter => _totalBill;
  double get totalTaxGetter => _totalTax;
  double get totalTipGetter => _totalTip;
  double get totalGratuityGetter => _totalGratuity;
  double get totalDiscountGetter => _totalDiscount;
  List<ProductLine> _productLine = [];
  ClientController({ip}){
    connect(ip);
  }
  List<ProductLine> get productListGetter => _productLine;
  connect(ip) async {
    if(ip!=null) {
      if (_client == null || (_client != null && !_client!.isConnected)) {
        _client = Client(onData: onData, onError: onError, hostname: ip);
        if (await _client!.connect()) {
          return true;
        }
      }
      return false;
    }
  }
  disconnect() async {
    if((_client!=null&&_client!.isConnected)) {
      _client!.disconnect();
      return true;
    }
    return false;
  }
  bool canBeDouble(String value){
    try{
      double.parse(value);
      return true;
    }catch(e){
      return false;
    }
  }
  bool canBeInt(String value){
    try{
      int.parse(value);
      return true;
    }catch(e){
      return false;
    }
  }
  onData(Uint8List data){
    var message = jsonDecode(String.fromCharCodes(data));
    print(message['kdsSettings'].toString());
    // var model =qsrProductModelFromMap(jsonEncode(message));
    _productLine=List<ProductLine>.from(
        message["product_line"].map<ProductLine>((x) => ProductLine.fromMap(x)));
    _totalDiscount=message['total_discount'];
    _totalTax=message['total_tax'];
    _totalBill=message['total_bill'];
    _subTotal=message['sub_total'];
    _totalGratuity=message['total_tip'];
    if(message['kdsSettings']!=null){

      _kdsSettings = KdsSettings.fromMap(message['kdsSettings']);
      if(_kdsSettings!.tipActive=='1') {
        _totalTip = 0.00;
       //  double tipOn=_kdsSettings!.tipCalculation=='1'?
       // _totalBill:_subTotal;
        // if(kdsSettings!.enableSmartTipping=='1'){
        //   print('hereeeeee2');
        //   if(canBeDouble(kdsSettings!.minimumOrderAmountThreshold.toString())&&
        //       double.parse(_kdsSettings!.minimumOrderAmountThreshold!)<=tipOn
        //   // &&
        //   // canBeInt(kdsSettings!.minimumNumberOfCustomersThreshold.toString())&&
        //   // int.parse(kdsSettings!.minimumNumberOfCustomersThreshold!)<=clientController.totalGuest
        //   ) {
        //     if (_kdsSettings!.autoTypeTippingThreshold ==
        //         'flat') {
        //       // calculateTip(double.parse(_kdsSettings!.flatTippingThreshold!));
        //       Get.to(TipScreen());
        //       return;
        //     } else {
        //       // var value=(double.parse(_kdsSettings!.flatTippingThreshold!)/ 100)* tipOn;
        //       // calculateTip(value);
        //       Get.to(TipScreen());
        //       return;
        //     }
        //   }else{
        //     Get.to(TipScreen());
        //   }
        // }else{
        //   print('hereeeeee');
        //   Get.to(TipScreen());
        // }
        Get.to(TipScreen());

      }else{
        Get.to(ReceiptScreen());
      }
    }
    notifyListeners();
  }

  onError(dynamic error){
    print("Error : $error");
  }

  calculateTip(double tip){
    _totalTip=tip;
    notifyListeners();
  }
  clear(){
    _totalBill=0.0;
    _subTotal=0.0;
    _totalGuest=0;
    _totalTip=0.0;
    _totalGratuity=0.0;
    _kdsSettings=null;
    _totalDiscount=0.0;
    _totalTax=0.0;
    _productLine=[];
    notifyListeners();
  }

}