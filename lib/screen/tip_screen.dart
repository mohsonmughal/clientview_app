import 'package:client_view_app/screen/receipt_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class TipScreen extends StatefulWidget {
  final List<double> tipPercentages; // Your dynamic list of tip percentages

  const TipScreen({
    super.key,
    required this.tipPercentages,
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReceiptScreen()));
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
                        '\$0.00',
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
                        '\$81.61',
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
                    ...widget.tipPercentages.map((percentage) => Padding(
                          padding: const EdgeInsets.all(10.0).r,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle tip percentage click
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(
                                  50.w, 50.h), // Set the minimum button size
                              side: const BorderSide(
                                  color: Colors.lightBlue,
                                  width: 2), // Set the border color and width
                            ),
                            child: Text('${percentage.toStringAsFixed(0)}%'),
                          ),
                        )),
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
                        child: const Text(
                          'Custom',
                          style: TextStyle(color: Colors.green),
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
                        child: const Text(
                          'No Tip',
                          style: TextStyle(color: Colors.orange),
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
