import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

Future<void> PaymentMethodGetwayIntegration(BuildContext context,double paymentAmount) async {
  final
  Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //   ipn_url: "www.ipnurl.com",
          multi_card_name: "visa,master,bkash",
          currency: SSLCurrencyType.BDT,
          product_category: "Food",
          sdkType: SSLCSdkType.TESTBOX,
          store_id: "ranas682ed7037f05a",
          store_passwd: "ranas682ed7037f05a@ssl",
          total_amount: paymentAmount,
          tran_id: "custom_transaction_id"));


  final response =await sslcommerz.payNow();
  if(response.status=='VALID'){
    showSnackBarMessage(context, "payment success");
  }
  if(response.status=='Closed'){
    showSnackBarMessage(context, "payment Closed");
  }
  if(response.status=='FAILD'){
    showSnackBarMessage(context, "payment Fail");
  }
}
