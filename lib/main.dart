import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
void main() {
  runApp( MyApp());
}
Future<void> sendMail(String userName,String password,String name,String recipientMail,String subject,String text) async {
 // String username = 'mustafa134bs@gmail.com'; // E-posta adresi
  //String password = 'dftd vasq qpxq chtq'; // E-posta şifresi

  final smtpServer = gmail(userName, password);

  // E-posta içeriği
  final message = Message()
    ..from = Address(userName, name)
    ..recipients.add(recipientMail) // Alıcı e-posta adresi
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. Error: $e');
  }
}
class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Mail Sender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController nameController=TextEditingController();
  TextEditingController userController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController recipientController=TextEditingController();
  TextEditingController subjectController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title,style: const TextStyle(fontSize: 25),),
      ),
      body:  Center(
        child: Container(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Your name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: userController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Your Mail Adress',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        //Go to myaccount settings /2-step Verification/App Paswords to create app password
                        hintText: 'Your App Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: recipientController,
                    decoration: InputDecoration(
                        hintText: 'Recipient Mail Adress',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: subjectController,
                    decoration: InputDecoration(
                        hintText: 'Subject',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(onPressed: (){
                  sendMail(userController.text, passwordController.text, nameController.text, recipientController.text, subjectController.text, messageController.text);
                }, child: const Text("Send"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
