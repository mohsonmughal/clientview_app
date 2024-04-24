import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  late VideoPlayerController _controller;
  String? selectedReceipt;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/thankyou.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    // Add the listener to the controller
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // Reached the end of the video
        _controller.seekTo(Duration.zero); // Rewind the video to the beginning
        _controller.play(); // Start playing the video again
      }
    });
  }

  @override
  void dispose() {
    // Don't forget to dispose of the video player controller!
    _controller.removeListener(() {}); // Remove the listener
    _controller.dispose();
    super.dispose();
  }

  receiptOptions(
      {required IconData iconData,
      required String text,
      TextStyle? textStyle,
      CrossAxisAlignment alignment = CrossAxisAlignment.center,
      MainAxisAlignment alignment2 = MainAxisAlignment.center}) {
    bool isSelected = selectedReceipt == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedReceipt = text;
        });
        handleOptionTap(text);
      },
      child: Container(
        height: 100.h,
        width: 60.w,
        decoration: BoxDecoration(
            color: isSelected ? Colors.green[100] : Colors.transparent,
            borderRadius: BorderRadius.all(
              const Radius.circular(10).r,
            ),
            border: Border.all(color: Colors.green, width: 1.w)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(iconData, color: Colors.green, size: 15.sp),
          SizedBox(width: 10.0.w), // Space between the icon and text
          Text(
            text,
            style:
                textStyle ?? TextStyle(color: Colors.green, fontSize: 10.0.sp),
          ),
        ]),
      ),
    );
  }

  void handleOptionTap(String option) {
    if (option == 'No Thanks') {
      // Do nothing for now or close any open dialogs (not directly required here)
      Navigator.of(context).pop();
    } else if (option == 'Print') {
      Fluttertoast.showToast(
        msg: 'Receipt has been printed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 6.sp,
      );
    } else {
      addNewBookingPopup(context, option);
    }
  }

  void addNewBookingPopup(BuildContext context, String option) {
    TextEditingController controller = TextEditingController();
    TextInputType keyboardType = TextInputType.text;
    String hintText = 'Enter details';

    if (option == "Email") {
      keyboardType = TextInputType.emailAddress;
      hintText = 'Enter email address';
    } else if (option == "SMS") {
      keyboardType = TextInputType.phone;
      hintText = 'Enter phone number';
    } else if (option == 'Email & Print') {
      option = 'Email';
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              width: 180.w,
              padding: const EdgeInsets.all(20).r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10).r,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Enter $option Details",
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      labelText: hintText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 6.sp),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(
                              'Text:    ${controller.text},   Text Is Empty:    ${controller.text.isEmpty} ');
                          if (controller.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please enter a valid $option detail",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 6.sp,
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 6.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void addNewBookingPopup(BuildContext context, String option) {
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController smsController = TextEditingController();
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     barrierColor: Colors.black.withOpacity(0.7),
  //     transitionDuration: const Duration(milliseconds: 200),
  //     pageBuilder: (BuildContext buildContext, Animation animation,
  //         Animation secondaryAnimation) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         final bool isKeyboardOpen =
  //             MediaQuery.of(context).viewInsets.bottom != 0;
  //         return Center(
  //           child: Material(
  //             child: Container(
  //               width: 150.w,
  //               padding: const EdgeInsets.all(10).r,
  //               decoration: BoxDecoration(
  //                 color: const Color(0xffD4D4D4),
  //                 borderRadius: BorderRadius.circular(10).r,
  //               ),
  //               child: Padding(
  //                 padding: EdgeInsets.only(
  //                   bottom: isKeyboardOpen ? 200.h : 0,
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       option,
  //                       style: TextStyle(
  //                         fontSize: 10.sp,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5.h),
  //                     TextFormField(
  //                       controller: emailController,
  //                       decoration: InputDecoration(
  //                         hintText: '',
  //                         floatingLabelBehavior: FloatingLabelBehavior.always,
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10).r,
  //                         ),
  //                         contentPadding: const EdgeInsets.symmetric(
  //                                 horizontal: 20, vertical: 10)
  //                             .r,
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: const BorderSide(color: Colors.green),
  //                           borderRadius: BorderRadius.circular(10).r,
  //                         ),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10).r,
  //                         ),
  //                         hintStyle:
  //                             TextStyle(color: Colors.black, fontSize: 9.sp),
  //                       ),
  //                     ),
  //                     SizedBox(height: 5.h),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         ElevatedButton(
  //                           style: const ButtonStyle(
  //                               backgroundColor:
  //                                   MaterialStatePropertyAll(Colors.green)),
  //                           onPressed: () {
  //                             if (emailController.text.isEmpty) {
  //                               Fluttertoast.showToast(
  //                                 msg: 'please enter your ',
  //                                 toastLength: Toast.LENGTH_LONG,
  //                                 gravity: ToastGravity.BOTTOM,
  //                                 timeInSecForIosWeb: 1,
  //                                 backgroundColor: Colors.red,
  //                                 textColor: Colors.white,
  //                                 fontSize: 13.sp,
  //                               );
  //                               return; // Stop further execution if validation fails
  //                             }
  //                           },
  //                           child: const Text('Submit'),
  //                         ),
  //                         ElevatedButton(
  //                           style: const ButtonStyle(
  //                               backgroundColor:
  //                                   MaterialStatePropertyAll(Colors.grey)),
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: const Text('Close'),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have completed the payment Successfully.',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Receipt Options',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0).r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          receiptOptions(
                            iconData: Icons.email_outlined,
                            text: "Email",
                          ),
                          receiptOptions(
                            iconData: Icons.messenger_outline_sharp,
                            text: "SMS",
                          ),
                          receiptOptions(
                            iconData: Icons.print_outlined,
                            text: "Print",
                          ),
                          receiptOptions(
                            iconData: Icons.local_printshop_sharp,
                            text: "Email & Print",
                          ),
                          receiptOptions(
                            iconData: Icons.cancel_presentation,
                            text: "No Thanks",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
