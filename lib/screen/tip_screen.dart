import 'dart:convert';

import 'package:client_view_app/model/kds_tip_model.dart';
import 'package:client_view_app/screen/controller/client_controller.dart';
import 'package:client_view_app/screen/receipt_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class TipScreen extends StatefulWidget {// Your dynamic list of tip percentages

  const TipScreen({
    super.key,
  });

  @override
  State<TipScreen> createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    clientController.client!.write(jsonEncode({'tip':clientController.totalTipGetter}));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ReceiptScreen()));
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
  KdsSettings? kdsSettings;
  late ClientController clientController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientController=Provider.of<ClientController>(context,listen: false);
    kdsSettings=clientController.kdsSettings;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 204, 200, 197),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10).r,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.clear_thick)),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '\$${clientController.totalTipGetter.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tip',
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '\$${(clientController.totalBillGetter+clientController.totalTipGetter).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ...kdsSettings!.customTipRow!.map((percentage) =>
                        percentage.active=='1'?
                        Padding(
                          padding: const EdgeInsets.all(10.0).r,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle tip percentage click
                              double tipOn=kdsSettings!.tipCalculation=='1'?
                              clientController.totalBillGetter:clientController.subTotalGetter;
                              // if(kdsSettings!.enableSmartTipping=='1'){
                              //   if(canBeDouble(kdsSettings!.minimumOrderAmountThreshold.toString())&&
                              //       double.parse(kdsSettings!.minimumOrderAmountThreshold!)<=tipOn
                              //       // &&
                              //       // canBeInt(kdsSettings!.minimumNumberOfCustomersThreshold.toString())&&
                              //       // int.parse(kdsSettings!.minimumNumberOfCustomersThreshold!)<=clientController.totalGuest
                              //   ) {
                              //     if (kdsSettings!.autoTypeTippingThreshold ==
                              //         'flat') {
                              //       clientController.calculateTip(
                              //           double.parse(kdsSettings!.flatTippingThreshold!));
                              //       setState(() {
                              //
                              //       });
                              //       return;
                              //     } else {
                              //       var value=(double.parse(kdsSettings!.flatTippingThreshold!)/ 100)* tipOn;
                              //       clientController.calculateTip(value);
                              //       setState(() {
                              //
                              //       });
                              //       return;
                              //     }
                              //   }
                              // }
                              if(kdsSettings!.customTypeTippingThreshold=='flat'){

                                if(percentage.flatAmount!.isNotEmpty){
                                  var value=double.parse(percentage.flatAmount!);
                                  clientController.calculateTip(value);
                                }
                              }else{
                                if(percentage.percentageAmount!.isNotEmpty){
                                var value=(double.parse(percentage.percentageAmount!)/ 100)* tipOn;
                                clientController.calculateTip(value);
                                }
                              }
                              setState(() {});
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(
                                  50.w, 50.h), // Set the minimum button size
                              side: const BorderSide(
                                  color: Colors.lightBlue,
                                  width: 2), // Set the border color and width
                            ),
                            child: Text(
                                kdsSettings!.customTypeTippingThreshold=='flat'?
                                '\$${percentage.flatAmount}':
                                '${percentage.percentageAmount}%',
                              style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500),
                            ),
                          ),
                        ):const SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle custom tip click
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(50.w, 50.h), // Set the minimum button size
                          side: const BorderSide(
                              color: Colors.green,
                              width: 2), // Set the border color and width
                        ),
                        child: Text(
                          'Custom',
                          style: TextStyle(color: Colors.green,fontSize: 10.sp,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle no tip click
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(50.w, 50.h), // Set the minimum button size
                          side: const BorderSide(
                              color: Colors.orange,
                              width: 2), // Set the border color and width
                        ),
                        child: Text(
                          'No Tip',
                          style: TextStyle(color: Colors.orange,fontSize: 10.sp,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: SfSignaturePad(
                  key: signatureGlobalKey,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Colors.blue,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => _handleClearButtonPressed(),
                      child: Text(
                        'Clear Signature',
                        style: TextStyle(fontSize: 6.5.sp, color: Colors.blue),
                      )),
                  SizedBox(width: 10.w),
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: GestureDetector(
                            onTap: () => _handleSaveButtonPressed(),
                            child: Text(
                              'Done Signature',
                              style: TextStyle(
                                  fontSize: 6.5.sp, color: Colors.white),
                            ))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
