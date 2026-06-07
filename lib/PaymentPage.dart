import 'package:flutter/material.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = ''; // To store the selected payment method
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  List<String> paymentMethods = ['Credit Card', 'Debit Card', 'instapay', 'On delivery'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PAYMENT", style: TextStyle(fontSize: 24,color:Colors.white )),
        leading: IconButton(
          onPressed: () {
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Startscreen()));
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        backgroundColor: Color(0xff00637c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              children: paymentMethods
                  .map((method) => RadioListTile<String>(
                title: Text(method),
                value: method,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Card Details:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            if (_requiresCardNumber(_selectedPaymentMethod))
              TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                ),
              ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Validate and process payment
                if (_selectedPaymentMethod.isEmpty) {
                  _showErrorDialog('Please select a payment method');
                } else if (_requiresCardNumber(_selectedPaymentMethod) && _cardNumberController.text.isEmpty) {
                  _showErrorDialog('Please enter valid card details');
                } else if (_expiryController.text.isEmpty || _cvvController.text.isEmpty) {
                  _showErrorDialog('Please enter valid card details');
                } else {
                  _processPayment();
                }
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }

bool _requiresCardNumber(String paymentMethod) {
    return paymentMethod == 'Credit Card' || paymentMethod == 'Debit Card';
  }

  void _processPayment() {
    String cardNumber = _cardNumberController.text;
    String expiryDate = _expiryController.text;
    String cvv = _cvvController.text;

    print('Payment Method: $_selectedPaymentMethod');
    print('Card Number: $cardNumber');
    print('Expiry Date: $expiryDate');
    print('CVV: $cvv');

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for your payment!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StartScreen()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}