import 'package:client_view_app/helpers/responsive.dart';
import 'package:client_view_app/screen/client_view_setting/client_view_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserKeyScreen extends StatefulWidget {
  static const routeName = '/UserKeyScreen';

  const UserKeyScreen({Key? key}) : super(key: key);

  @override
  State<UserKeyScreen> createState() => _UserKeyScreenState();
}

class _UserKeyScreenState extends State<UserKeyScreen> {
  TextEditingController userKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff2D333A),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          centerTitle: true,
          title: Text(
            'User Key Settings',
            style: TextStyle(color: Colors.white, fontSize: 20.0.sp),
          ),
          // leading: InkWell(
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Center(
          //         child: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.white,
          //     ))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldWidget('User Key', controller: userKeyController),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return Colors.green;
                      }),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClientViewSetting(),
                          ));
                    },
                    child: const Text(
                      'Connect',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row textFieldWidget(String title,
      {hint,
      postfixText,
      required TextEditingController controller,
      validate = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(
            width: Responsive.isMobile(context)
                ? 250.w
                : MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              validator: (value) {
                return null;
              },
              decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0).r,
              ),
            ))
      ],
    );
  }
}
