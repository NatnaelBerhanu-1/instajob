// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/auth_bloc/auth_cubit.dart';
import 'package:insta_job/bloc/auth_bloc/auth_state.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_bloc.dart';
import 'package:insta_job/bloc/check_kyc_availability/check_kyc_availability_state.dart';
import 'package:insta_job/bloc/check_kyc_availability/model/fetched_kyc_candidate_data.dart';
import 'package:insta_job/dialog/custom_dialog.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/api_response.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/screens/auth_screen/change_account_info.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/privacy_policy_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/save_card_screen.dart';
import 'package:insta_job/screens/insta_recruit/bottom_navigation_screen/user_account/setting_pages/termsofuse_screen.dart';
import 'package:insta_job/screens/insta_recruit/membership_screen.dart';
import 'package:insta_job/screens/insta_recruit/user_type_screen.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_cards/setting_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/custom_button/custom_btn.dart';
import 'aboutUs_screen.dart';

class SettingScreen extends StatefulWidget {
  // final bool isUserInterface;
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    context.read<CheckKycAvailabilityCubit>().execute(userId: Global.userModel!.id!.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppBar(
              title: "Settings",
              leadingImage: MyImages.arrowBlueLeft,
              height: 17,
              width: 17,
              actions: Global.userModel?.uploadPhoto == null
                  ? SizedBox()
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, right: 10, bottom: 5),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${EndPoint.imageBaseUrl}${Global.userModel?.uploadPhoto}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SettingTile(
                onTap: () {
                  AppRoutes.push(context, AboutUsScreen());
                },
                leadingImage: MyImages.about,
                title: "About Us",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  AppRoutes.push(context, TermsOfUseScreen());
                },
                leadingImage: MyImages.membership,
                title: "Terms of use",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  AppRoutes.push(context, PrivacyPolicyScreen());
                },
                leadingImage: MyImages.membership,
                title: "Privacy Policy",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  AppRoutes.push(context,
                      MemberShipScreen(isAgreement: false, isRegister: true));
                },
                leadingImage: MyImages.membership,
                title: "Membership Agreement",
              ),
              SizedBox(height: 10),
              if(userType == 'user') BlocBuilder<CheckKycAvailabilityCubit, CheckKycAvailabilityState>(
                builder: (context, state) {
                  if(state is CheckKycAvailabilityFound) {
                    return SettingTile(
                              onTap: () {
                                _generate1099Form(state.data as FetchedKycCandidateData);
                              },
                              leadingImage: MyImages.membership,
                              title: "Generate 1099",
                            );
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  // if (Global.userModel?.type == "user") {
                  //   AppRoutes.push(context,
                  //       ChangeAccInfoScreen(isUpdate: true));
                  // } else {
                  //   AppRoutes.push(context,
                  //       BecameAnEmployer(isUpdate: true));
                  // }
                  AppRoutes.push(context, ChangeAccInfoScreen());
                },
                leadingImage: MyImages.user,
                title: "Change Account Information",
              ),
              SizedBox(height: 10),
              SettingTile(
                onTap: () {
                  buildDialog(
                        context,
                        CustomDialog(
                          desc1: "This process isn't reversable, you will loose all your data.",
                          headerImagePath: MyImages.delete,
                          okOnTap: () async {
                            loading(value: true);
                            try {
                              Navigator.of(context)
                                .pop(); //revisit, double check that it's ok to pop first and call other items below(whether everything gets executed, whether to remote the setState etc/ consider dispose method too)
                            ApiResponse response = await context.read<AuthCubit>().deleteAccount(Global.userModel!.id.toString(), Global.userModel!.type!.toString());
                            debugPrint("Response: $response");
                            if(response.appStatusCode == AppStatusCode.success) {
                              context.read<AuthCubit>().logOut();
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              var type = pref.getString("type");
                              userType = type ?? "";
                              setState(() {});
                            }else {
                              debugPrint("Response: ${response.response}");
                              showToast(response.response);
                            }
                            loading(value: false);
                            } catch (e) {
                              loading(value: false);
                            }
                            
                          },
                        ));
                },
                leadingImage: MyImages.user,
                title: "Delete Account",
              ),
              // SizedBox(height: 10),
              // Global.userModel?.type == "user"
              //     ? SizedBox()
              //     : SettingTile(
              //         onTap: () {
              //           AppRoutes.push(context, SaveCardScreen());
              //         },
              //         leadingImage: MyImages.visaCardBlue,
              //         title: "Saved Cards",
              //       ),
              // SizedBox(height: 10),
              // Global.userModel?.type == "user"
              //     ? SizedBox()
              //     : SettingTile(
              //         onTap: () {
              //           buildDialog(context, CustomDialog());
              //         },
              //         leadingImage: MyImages.cancelSub,
              //         title: "Cancel Subscription",
              //       ),
              Spacer(),
              BlocConsumer<AuthCubit, AuthInitialState>(
                  listener: (context, state) {
                if (state is ErrorState) {
                  showToast(state.error);
                }
              }, builder: (context, snapshot) {
                return CustomIconButton(
                  image: MyImages.logout,
                  title: "Log Out",
                  loading: snapshot is AuthLoadingState,
                  backgroundColor: MyColors.darkRed,
                  fontColor: MyColors.white,
                  onclick: () {
                    buildDialog(
                        context,
                        CustomDialog(
                          okOnTap: () async {
                            Navigator.of(context)
                                .pop(); //revisit, double check that it's ok to pop first and call other items below(whether everything gets executed, whether to remote the setState etc/ consider dispose method too)
                            context.read<AuthCubit>().logOut();
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var type = pref.getString("type");
                            userType = type ?? "";
                            setState(() {});
                          },
                        ));
                  },
                );
              }),
              SizedBox(height: 10),
            ],
          ),
        ));
  }

  void _generate1099Form(FetchedKycCandidateData kycUser) async {
    ByteData data = await rootBundle.load('assets/pdf/1099_template.pdf');
    //Load the existing PDF document.
    final PdfDocument document = PdfDocument(inputBytes: data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    final PdfPage page = document.pages[0];
    // Write payers information
    page.graphics.drawString(
    'InstaJob LLC\n215 W Michigan Ave Ypsilanti, MI 48197\n(734)883-2142', 
    PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(60, 60, 400, 200));

     // Write calendar year
    page.graphics.drawString(
    '${DateTime.now().year}', PdfStandardFont(PdfFontFamily.helvetica, 10),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(410, 95, 400, 200));

    // Write amount to be paid
    page.graphics.drawString(
    'Total amount!', PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(310, 120, 400, 200));

    // Write payers tin
    page.graphics.drawString(
    '99-2363832', PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(60, 120, 400, 200));

    // Write Reciepents tin
    page.graphics.drawString(
    'Reciepients TIN', PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(180, 120, 400, 200));

    // Write Reciepints Name
    page.graphics.drawString(
    kycUser.ownerFullName, PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(60, 150, 400, 200));

    // Write Reciepints Street Address
    page.graphics.drawString(
    kycUser.streetAddress, PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(60, 180, 400, 200));

    // Write Reciepints City or Town
    page.graphics.drawString(
    kycUser.city, PdfStandardFont(PdfFontFamily.helvetica, 6),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(60, 210, 400, 200));


    var output = await document.save();
    //Dispose the document.
    await savePDF(output, '1099Form.pdf');
    document.dispose();
  }

  static Future<void> savePDF(List<int> bytes, String fileName) async {
    try {
      await FileSaver.instance.saveFile(name: fileName, ext: 'pdf', mimeType: MimeType.pdf, bytes: Uint8List.fromList(bytes));
      showToast("Your form has been downloaded, please check your Downloads folder");
    } catch (e) {
      showToast("Error:$e");
    }
    

  //   bool dirDownloadExists = true;
  //   var directory;
  // if (Platform.isIOS) {
  //   directory = await getDownloadsDirectory();
  // } else {

  //   directory = "/storage/emulated/0/Download/";

  //   dirDownloadExists = await Directory(directory).exists();
  //     if(dirDownloadExists){
  //       directory = "/storage/emulated/0/Download/";
  //     }else{
  //       directory = "/storage/emulated/0/Downloads/";
  //     }
  //   } 
  //   debugPrint('Directory: $directory');

  //   if (directory != null) {
  //     final File file = File('$directory/$fileName');
  //     if (file.existsSync()) {
  //       await file.delete();
  //     }
  //     await file.writeAsBytes(bytes);
  //     showToast("Your form has been downloaded, please check your Downloads folder");
  //   }
  }
}
