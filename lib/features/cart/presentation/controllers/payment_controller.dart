import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedMethod = "Credit Card".obs;
  
  var cards = [
    {"type": "MasterCard", "number": "**** **** **** 4532", "holder": "Ahmed Mansour"},
    {"type": "Visa", "number": "**** **** **** 1234", "holder": "Ahmed Mansour"},
  ].obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  void addCard(String name, String number) {
    cards.add({"type": "MasterCard", "number": number, "holder": name});
  }
}
