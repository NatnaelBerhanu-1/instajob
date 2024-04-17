// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

class NewEmailScreen extends StatefulWidget {
  const NewEmailScreen({Key? key, required this.resumesPath}) : super(key: key);
  final List<String> resumesPath;

  @override
  State<NewEmailScreen> createState() => _NewEmailScreenState();
}

class _NewEmailScreenState extends State<NewEmailScreen> {
  var border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: MyColors.grey.withOpacity(.30), width: 1),
  );
  TextEditingController to = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController desc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  sendMail() async {
    Global().downloadPdf(context, widget.resumesPath[0], "resume ${0}");
    final Email email = Email(
      body: desc.text,
      subject: subject.text,
      recipients: [to.text],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
    );
    print("^^^^^^^^^^ ${context.read<GlobalCubit>().emailList}");
    await FlutterEmailSender.send(email);
  }

  List<TextEditingController> controllerList = [];
  getController() {
    print(
        "LOG email list ${context.read<GlobalCubit>().emailList.length} -- ${context.read<GlobalCubit>().emailList}");
    setState(() {});
  }

  @override
  void initState() {
    getController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "New Email",
          leadingImage: MyImages.cancel4x,
          imageColor: MyColors.blue,
          height: 16,
          width: 16,
          leadingWidth: 40,
          // leadingImage: MyImages.,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        1, //TODO: listview not deleted incase we implement multiple recipients to email(seems most likely + incase that's part of requirement)
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFormField(
                          controller: to,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 17, top: 25, bottom: 10),
                            prefixIcon:
                                Center(widthFactor: 0, child: Text("To:")),
                            hintText: "teresawilliam@gmail.com",
                            hintStyle: TextStyle(
                              color: MyColors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                            border: border,
                            focusedBorder: border,
                            enabledBorder: border,
                            errorBorder: border,
                            focusedErrorBorder: border,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Field can't be empty";
                            }
                            return emailValidation(value!);
                          },
                        ),
                      );
                    }),
                SizedBox(height: 10),
                TextFormField(
                  controller: subject,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 17, top: 25, bottom: 10),
                    hintText: "  Design Request Proposal",
                    hintStyle: TextStyle(
                      color: MyColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),

                    prefixIcon: Center(
                        widthFactor: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 12),
                          child: Text(
                            "Subject: ",
                            style: TextStyle(fontSize: 11),
                          ),
                        )),
                    // prefixText: "Subject: ",
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    focusedErrorBorder: border,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Field can't be empty";
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: desc,
                  maxLine: 10,
                  color: MyColors.grey.withOpacity(.30),
                  hint: "Description",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Field can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                // Spacer(),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.33),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: MyColors.lightgrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: false
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Icon(
                                Icons.visibility,
                                color: MyColors.blue,
                              ),
                      ),
                      Spacer(),
                      // Expanded(
                      //   flex: 0,
                      //   child: Icon(
                      //     Icons.link,
                      //     color: MyColors.grey,
                      //   ),
                      // ),
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(MyColors.blue),
                        ),
                        child: Text("Send Now"),
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          sendMail();
                          // }
                        },
                      ))
                    ],
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
