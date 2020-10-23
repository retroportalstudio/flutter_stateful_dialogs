import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(context: context,
    builder: (context){
      final TextEditingController _textEditingController = TextEditingController();
      bool isChecked = false;
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    validator: (value){
                      return value.isNotEmpty ? null : "Invalid Field";
                    },
                    decoration: InputDecoration(hintText: "Enter Some Text"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Choice Box"),
                      Checkbox(value: isChecked, onChanged: (checked){
                        setState((){
                          isChecked = checked;
                        });
                      })
                    ],
                  )
                ],
              )),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: (){
                if(_formKey.currentState.validate()){
                  // Do something like updating SharedPreferences or User Settings etc.
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      });
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Dialog"),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () async {
                await showInformationDialog(context);
              },
              child: Text(
                "Stateful Dialog",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ),
    );
  }
}
