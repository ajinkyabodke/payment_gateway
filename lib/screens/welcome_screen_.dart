import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int total_amount=0;
  Razorpay _razorpay;
  FlutterToast flutterToast;

 @override
  void initState() {
   super.initState();
   flutterToast = FlutterToast(context);
    super.initState();
    _razorpay =Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  void dispose() {

    super.dispose();
    _razorpay.clear();
  }



  void openCheckout() async{
   var options= {
     'key': 'rzp_test_4enhybaDPAcGpA',
     'amount': total_amount*100,
     'name' : 'Ajinkya',
     'description' : 'Test Payment',
     'prefill' : {'contact':'','email':''},
     'external' : {
       'wallets': ['paytm']
     }
   };
   try{
     _razorpay.open(options);
   }
   catch(e){
     debugPrint(e);
   }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
//   flutterToast.showToast(msg:"SUCCESSFUL PAYMENT :"+response.paymentId);
   flutterToast.showToast(child: Text("SUCCESSFUL PAYMENT :"+response.paymentId));
  }
  void _handlePaymentError(PaymentFailureResponse response){
    flutterToast.showToast(child: Text("ERROR :"+response.code.toString()+ "-" + response.message));
  }
  void _handleExternalWallet(ExternalWalletResponse response){
    flutterToast.showToast(child: Text("ExternalWallet :"+response.walletName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
            Container(
              height: 68.0,
              child: Image.asset('images/logo.png'),
            ),
            Text(
              'Flash Payments',
              style: TextStyle(
                color: Colors.black,
                fontSize: 38.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  total_amount=num.parse(value);
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black12),
                hintText: 'Enter Amount',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),

            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    openCheckout();
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Make Payment',


                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
