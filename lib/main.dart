import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paymentdemo/adsdemo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'adsdemo.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MaterialApp(
      home: adsdemo(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  final _razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("success=${response.orderId}");
    print("success=${response.paymentId}");
    print("success=${response.signature}");

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.code);
    print(response.error);
    print(response.message);
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);

    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_AD2cPBaL4zokWv',
                'amount': 10000,
                'name': 'product1',
                'description': 'product1',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };
              _razorpay.open(options);

            },
            child: Text("Pay 100"),
          ),
          ElevatedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_AD2cPBaL4zokWv',
                'amount': 200000,
                'name': 'product2',
                'description': 'product2',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };
              _razorpay.open(options);

            },
            child: Text("Pay 2000"),
          ),
        ],
      ),
    );
  }
}


