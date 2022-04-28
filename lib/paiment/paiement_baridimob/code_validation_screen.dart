import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeValidationScreen extends StatefulWidget {
  const CodeValidationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CodeValidationScreenState();
}

class CodeValidationScreenState extends State<CodeValidationScreen> {
  final TextEditingController _textController = TextEditingController();

  // This function is triggered when the copy icon is pressed
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _textController.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copié dans le presse-papier'),
      elevation: 3,
      backgroundColor: Color.fromRGBO(27, 146, 164, 0.7),
      behavior: SnackBarBehavior.floating,
      width: 300,
    ));
  }

  @override
  void initState() {
    super.initState();
    _textController.text = "Code RIP de l'entreprise";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: TextField(
            controller: _textController,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 3,
                  color: Color.fromRGBO(27, 146, 164, 0.7),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.all(14.0),
              icon: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: _copyToClipboard,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
