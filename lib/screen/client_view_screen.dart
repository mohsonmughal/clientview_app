import 'package:client_view_app/model/models.dart';
import 'package:client_view_app/screen/controller/client_controller.dart';
import 'package:client_view_app/screen/userkey/userkey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientViewScreen extends StatefulWidget {
  const ClientViewScreen({super.key});

  @override
  State<ClientViewScreen> createState() => _ClientViewScreenState();
}

class _ClientViewScreenState extends State<ClientViewScreen> {
  getPresentAppConnection() {
    SharedPreferences.getInstance().then((prefs) async {
      String? ip = prefs.getString('ip');
      bool? value = await Provider.of<ClientController>(context, listen: false)
          .connect(ip);
      if (value != null && !value || value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("No Parent App found for '${ip}'"),
          duration: const Duration(milliseconds: 700),
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPresentAppConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserKeyScreen()));
        },
      ),
      backgroundColor: const Color(0xff2D333A),
      appBar: AppBar(
        title: const Text('Eat365 Cafe'),
        backgroundColor: Colors.black45, // Set the AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0).r,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Image(
                      image: AssetImage('assets/images/advertisement.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Consumer<ClientController>(
                    builder: (context, state, child) => Expanded(
                      flex: 2,
                      // Wrap your ListView with a Container to set the background color
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: state.productListGetter
                                      .map<Widget>(
                                        (e) => CustomListItem(
                                          quantity: e.qty,
                                          title: e.productName,
                                          price: e.price,
                                          modifiers: e.modifiers,
                                        ),
                                      )
                                      .toList()

                                  // <Widget>[
                                  //   CustomListItem(
                                  //     quantity: 2,
                                  //     title: 'Spicy Chicken Hot Lunch Set For Two',
                                  //     price: '34.50',
                                  //   ),
                                  //   CustomListItem(
                                  //     quantity: 2,
                                  //     title: 'Spicy Chicken',
                                  //     subtitle: 'No dressing',
                                  //     price: '16.00',
                                  //   ),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'French Fries (M)',
                                  //       price: '5.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Purple Rice Soy Milk',
                                  //       price: '6.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Iced Fresh Lemon Tea',
                                  //       price: '7.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Free Coca-Cola',
                                  //       price: '0.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Free Coca-Cola',
                                  //       price: '0.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Free Coca-Cola',
                                  //       price: '0.00'),
                                  //   CustomListItem(
                                  //       quantity: 2,
                                  //       title: 'Free Coca-Cola',
                                  //       price: '0.00'),
                                  // ],
                                  ),
                            ),
                            TotalPriceCard(
                              totalBill:
                                  state.subTotalGetter.toStringAsFixed(2),
                              totalGrautity:
                                  state.totalGratuityGetter.toStringAsFixed(2),
                              totalTax: state.totalTaxGetter.toStringAsFixed(2),
                              discount:
                                  state.totalDiscountGetter.toStringAsFixed(2),
                              totalPay:
                                  state.totalBillGetter.toStringAsFixed(2),
                            ), // This stays outside and won't scroll
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(
                            //       child: GestureDetector(
                            //         onTap: () {
                            //           // Navigator.push(
                            //           //     context,
                            //           //     MaterialPageRoute(
                            //           //         builder: (context) =>
                            //           //         const TipScreen(
                            //           //             tipPercentages: [
                            //           //               10,
                            //           //               15,
                            //           //               20,
                            //           //               30
                            //           //             ])));
                            //         },
                            //         child: Container(
                            //           height: 60.h,
                            //           color: Colors.orange,
                            //           child: Column(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.center,
                            //             children: [
                            //               Text('Card',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 9.sp)),
                            //               Text('(\$81.60)',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 6.sp)),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Container(width: 1.w),
                            //     Expanded(
                            //       child: Container(
                            //         height: 60.h,
                            //         color: Colors.green,
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           children: [
                            //             Text('Cash',
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 9.sp)),
                            //             Text('(\$85.15)',
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 6.sp)),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String price;
  final int? quantity; // Optional quantity parameter
  final List<Modifier> modifiers; // Optional quantity parameter

  const CustomListItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.price,
    this.quantity,
    required this.modifiers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 15).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (quantity != null) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0)
                                      .r,
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 7.0.sp),
                              ),
                            ),
                          ],
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.0.sp),
                              overflow: TextOverflow
                                  .clip, // Clip long texts and wrap them
                            ),
                          ),
                        ],
                      ),
                      if (subtitle != null) ...[
                        SizedBox(
                            height: 3.0.r), // Space between title and subtitle
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 33.0).r,
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                                color: Colors.white70, fontSize: 7.0.sp),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
                child: Text(
                  '\$${double.parse(price).toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.green, fontSize: 7.0.sp),
                ),
              ),
            ],
          ),
          if (modifiers.isNotEmpty) ...[
            SizedBox(height: 3.0.r), // Space between title and subtitle
            Column(
              children: modifiers
                  .map(
                    (e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, bottom: 15)
                                    .r,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    Flexible(
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 6.0.sp),
                                        overflow: TextOverflow
                                            .clip, // Clip long texts and wrap them
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10.0).r,
                          child: Text(
                            '\$${(double.parse(e.rate) * quantity!).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.green, fontSize: 6.0.sp),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class TotalPriceCard extends StatelessWidget {
  final String totalBill;
  final String totalGrautity;
  final String totalTax;
  final String discount;
  final String totalPay;

  const TotalPriceCard({
    Key? key,
    required this.totalBill,
    required this.totalGrautity,
    required this.totalTax,
    required this.discount,
    required this.totalPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff24282C),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buildPriceRow('Gratuity: ', totalGrautity)),
                Expanded(child: buildPriceRow('Tip: ', '0.00')),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buildPriceRow('Total Bill: ', totalBill)),
                Expanded(child: buildPriceRow('Total Tax: ', totalTax)),
              ],
            ),
            const SizedBox(
                height: 10.0), // Provide some vertical spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buildPriceRow('Discount: ', discount)),
                Expanded(child: buildPriceRow('Total Pay: ', totalPay)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, String amount) {
    return FittedBox(
      fit: BoxFit.scaleDown, // Ensures text scales down without distortion
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 7.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '\$$amount',
              style: TextStyle(
                fontSize: 7.sp,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
