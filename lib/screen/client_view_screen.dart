import 'package:client_view_app/screen/tip_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientViewScreen extends StatefulWidget {
  const ClientViewScreen({super.key});

  @override
  State<ClientViewScreen> createState() => _ClientViewScreenState();
}

class _ClientViewScreenState extends State<ClientViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Expanded(
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
                              children: const <Widget>[
                                CustomListItem(
                                  quantity: 2,
                                  title: 'Spicy Chicken Hot Lunch Set For Two',
                                  price: '34.50',
                                ),
                                CustomListItem(
                                  quantity: 2,
                                  title: 'Spicy Chicken',
                                  subtitle: 'No dressing',
                                  price: '16.00',
                                ),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'French Fries (M)',
                                    price: '5.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Purple Rice Soy Milk',
                                    price: '6.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Iced Fresh Lemon Tea',
                                    price: '7.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Free Coca-Cola',
                                    price: '0.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Free Coca-Cola',
                                    price: '0.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Free Coca-Cola',
                                    price: '0.00'),
                                CustomListItem(
                                    quantity: 2,
                                    title: 'Free Coca-Cola',
                                    price: '0.00'),
                              ],
                            ),
                          ),
                          const TotalPriceCard(
                            totalBill: '66.60',
                            totalTax: '10.00',
                            discount: '5.00',
                            totalPay: '81.60',
                          ), // This stays outside and won't scroll
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TipScreen(
                                                    tipPercentages: [
                                                      10,
                                                      15,
                                                      20,
                                                      30
                                                    ])));
                                  },
                                  child: Container(
                                    height: 60.h,
                                    color: Colors.orange,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Card',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9.sp)),
                                        Text('(\$81.60)',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 6.sp)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 1.w),
                              Expanded(
                                child: Container(
                                  height: 60.h,
                                  color: Colors.green,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Cash',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp)),
                                      Text('(\$85.15)',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 6.sp)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  const CustomListItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.price,
    this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
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
                              const EdgeInsets.symmetric(horizontal: 10.0).r,
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 7.0.sp),
                          overflow: TextOverflow
                              .clip, // Clip long texts and wrap them
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 3.0.r), // Space between title and subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33.0).r,
                      child: Text(
                        subtitle!,
                        style:
                            TextStyle(color: Colors.white70, fontSize: 7.0.sp),
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
              '\$$price',
              style: TextStyle(color: Colors.green, fontSize: 7.0.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class TotalPriceCard extends StatelessWidget {
  final String totalBill;
  final String totalTax;
  final String discount;
  final String totalPay;

  const TotalPriceCard({
    Key? key,
    required this.totalBill,
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
