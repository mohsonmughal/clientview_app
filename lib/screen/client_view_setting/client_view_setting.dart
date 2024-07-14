
import 'package:client_view_app/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/client_controller.dart';

class ClientViewSetting extends StatefulWidget {
  static const routeName = '/ClientViewSetting';

  const ClientViewSetting({Key? key}) : super(key: key);

  @override
  State<ClientViewSetting> createState() => _ClientViewSettingState();
}

class _ClientViewSettingState extends State<ClientViewSetting> {
  TextEditingController networkIPController = TextEditingController();
  late ClientController clientController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientController = Provider.of<ClientController>(context, listen: false);
    getInfoInSharedPref();
  }

  setInfoInSharedPref() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('ip', networkIPController.text);
    });
  }

  getInfoInSharedPref() {
    SharedPreferences.getInstance().then((prefs) {
      networkIPController.text = prefs.getString('ip') ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Client View Settings',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(child: Icon(Icons.arrow_back_ios))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldWidget('Network Ip',
                      controller: networkIPController, postfixText: 'GET IP'),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  //
                  // textFieldWidget('Port',
                  //     // postfixText: 'MS',
                  //     controller: portController,
                  //     validate: true),
                  const SizedBox(
                    height: 20,
                  ),

                  // Text(_responseFromNativeCode),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<ClientController>(
                    builder: (context, prov, child) => ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                          // If the button is pressed, return green, otherwise blue
                          if (prov.client != null && prov.client!.isConnected) {
                            return Colors.red;
                          }
                          return Colors.green;
                        }),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (prov.client == null ||
                              (prov.client != null &&
                                  !prov.client!.isConnected)) {
                            var value =  await Provider.of<ClientController>(context,listen: false).connect(
                                networkIPController.text);
                            if (!value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "No Parent App found for '${networkIPController.text}'"),
                                duration: const Duration(milliseconds: 700),
                              ));
                            }
                          } else {
                            await prov.disconnect();
                          }
                          setInfoInSharedPref();
                          setState(() {});
                        }
                      },
                      child: Text(
                        prov.client != null && prov.client!.isConnected
                            ? 'Disconnect'
                            : 'Connect',
                      ),
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
        Text(title),
        SizedBox(
            width: Responsive.isMobile(context)
                ? 250.w
                : MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || (value != null && value.trim().isEmpty)) {
                  return "Enter the field's related data.";
                } else if (value.trim().isNotEmpty &&
                    networkIPController == controller &&
                    value.split('.').length != 4) {
                  return "Enter the Valid IPv4.";
                }
                // else if (value.trim().isNotEmpty &&
                //     portController == controller) {
                //   try {
                //     int.parse(controller.text);
                //   } catch (e) {
                //     return "Enter the an integer value.";
                //   }
                // }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: postfixText != null
                    ? Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: InkWell(
                    onTap: () async {
                      if (postfixText == 'GET IP') {
                        final info = NetworkInfo();
                        final ip = await info.getWifiIP();
                        // final String subnet = ip!.substring(0, ip.lastIndexOf('.'));
                        if (ip != null) {
                          controller.text = ip;
                          setState(() {});
                        }
                      }
                    },
                    child: SizedBox(
                        width: 20,
                        child: Center(
                            child: Text(
                              postfixText,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: postfixText == 'GET IP'
                                      ? Colors.blueAccent
                                      : Colors.grey),
                            ))),
                  ),
                )
                    : null,
                hintText: hint,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ))
      ],
    );
  }
}
