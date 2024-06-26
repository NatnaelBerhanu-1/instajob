import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_cubit.dart';
import 'package:insta_job/bloc/choose_image_bloc/pick_image_state.dart';
import 'package:insta_job/bloc/upload_kyc_bloc/upload_kyc_cubit.dart';
import 'package:insta_job/bloc/upload_kyc_bloc/upload_kyc_state.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/di_container.dart';
import 'package:insta_job/globals.dart';
import 'package:insta_job/network/end_points.dart';
import 'package:insta_job/payload/upload_kyc_candidate_payload.dart';
import 'package:insta_job/payload/upload_kyc_recruiter_payload.dart';
import 'package:insta_job/screens/bank_info/add_bank_info_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_cards/custom_common_card.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UploadKycScreen extends StatefulWidget {
  const UploadKycScreen({super.key});

  @override
  State<UploadKycScreen> createState() => _UploadKycScreenState();
}

class _UploadKycScreenState extends State<UploadKycScreen> {
  List<String> documentTypes = ["Driving License", "Passport", "ID Card"];
  List<String> bankAccountTypes = ["Checking", "Saving"];

  int tabIndex = 0;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  var initialValue = PhoneNumber(isoCode: "US");
  // List<String> businessTypes =
  //     ["Financial entity", "Business entity"].cast<String>();
  // String? selectedBusinessType;
  // String? selectedBusinessType;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int selectedDocumentTypeIndex = 0;
  int selectedBankAccountTypeIndex = 0;
  String idFrontImgUrl = "";
  String idBackImgUrl = "";
  var frontImageBloc = PickImageCubit(sl());
  var backImageBloc = PickImageCubit(sl());

  String? selectedAccountType;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankRoutingNumberController = TextEditingController();
  TextEditingController accountOwnerController = TextEditingController();
  List<String> accountTypes =
      AccountType.values.map((e) => e.name.toUpperCase()).toList();
  TextEditingController countryCodeController = TextEditingController();

  int lastPageIndex = 2;

  final personalSInfoSectionFormKey = GlobalKey<FormState>();
  final businessInfoSectionFormKey = GlobalKey<FormState>();
  final idProofSectionFormKey = GlobalKey<FormState>();
  final bankInfoSectionFormKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    // selectedBusinessType = businessTypes[0]; //TODO: keep this or add validation check for dropdown
  }

  bool userIsCandidate() {
    return Global.userModel?.type == "user";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("curr  page $_currentPage");
    debugPrint("LOGG:: front $idFrontImgUrl back $idBackImgUrl");
    // debugPrint("LOGG:: select 1 $selectedDocumentTypeIndex $selectedBusinessType $selectedBankAccountTypeIndex");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            useLeadingImage: false,
            title: "Upload KYC",
            actions: IconButton(
                onPressed: () {
                  AppRoutes.pop(context);
                  // Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: MyColors.grey,
                )),
          )),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: (userIsCandidate() == true) ? [
              _buildItem(
                  index: 0,
                  selectedIndex: _currentPage,
                  title: "Personal Info"),
              _buildItem(
                  index: 1, selectedIndex: _currentPage, title: "ID Proof"),
              _buildItem(
                  index: 2, selectedIndex: _currentPage, title: "Bank"),
            ] : [
              _buildItem(
                  index: 0,
                  selectedIndex: _currentPage,
                  title: "Personal Info"),
              _buildItem(
                  index: 1,
                  selectedIndex: _currentPage,
                  title: "Business Info"),
              _buildItem(
                  index: 2, selectedIndex: _currentPage, title: "ID Proof"),
            ],
          ),
          Flexible(
            child: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  setState(() {});
                },
                children: (userIsCandidate() == true) ? [
                  _buildPersonalInfoPage(),
                  _buildIdInfoPage(),
                  _buildBankInfoPage(),
                ] : [
                  _buildPersonalInfoPage(),
                  _buildBusinessInfoPage(),
                  _buildIdInfoPage(),
                ]),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: BlocBuilder<UploadKycCubit, UploadKycState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "Back",
                        bgColor: MyColors.white,
                        borderColor: MyColors.blue,
                        fontColor: MyColors.blue,
                        height: 48,
                        onTap: state is UploadKycLoading ? null : () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {});
                        },
                      );
                    }
                  )),
                const SizedBox(width: 15),
                if (_currentPage < lastPageIndex)
                  Expanded(
                    child: CustomButton(
                      title: "Next",
                      // width: 120,
                      height: 48,
                      onTap: () async {
                        var formKey;
                        if (userIsCandidate() == true) {
                          if (_currentPage == 0) {
                            formKey = personalSInfoSectionFormKey;
                          } else if (_currentPage == 1) {
                            formKey = idProofSectionFormKey;
                          } else if (_currentPage == 2) {
                            formKey = bankInfoSectionFormKey;
                          }
                        } else {
                          if (_currentPage == 0) {
                            formKey = personalSInfoSectionFormKey;
                          } else if (_currentPage == 1) {
                            formKey = businessInfoSectionFormKey;
                          } else if (_currentPage == 2) {
                            formKey = idProofSectionFormKey;
                          }
                        }

                        if (formKey.currentState!.validate()) {
                          print("LOGG validated");
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          print("LOGG INvalidated");
                        }

                        setState(() {});
                      },
                    ),
                  ),
                if (_currentPage == lastPageIndex)
                  Expanded(
                    child: BlocConsumer<UploadKycCubit, UploadKycState>(
                        listener: (context, state) {
                          if (state is UploadKycSuccess) {
                            // AppRoutes.pop(context);
                            Navigator.of(context).pop();
                          } else if (state is UploadKycErrorState) {
                            showToast("Something went wrong: Upload KYC failed");
                          }
                        },
                        builder: (context, state) {
                      return CustomButton(
                        title: "Submit",
                        // width: 120,
                        height: 48,
                        loading: state is UploadKycLoading,
                        onTap: () async {
                          if (userIsCandidate() == true) {
                            var clientPayload = UploadCandidateKycPayload(
                              fullName: nameController.text,
                              phoneNumber: phoneController.text,
                              email: emailController.text,
                              documentType:
                                  documentTypes[selectedDocumentTypeIndex],
                              // frontIdImageUrl: "",
                              frontIdImageUrl: frontImageBloc.imgUrl,
                              // backIdImageUrl: "",
                              backIdImageUrl: backImageBloc.imgUrl,
                              bankAccountNumber: accountNumberController.text,
                              bankAccountType: bankAccountTypes[
                                  selectedBankAccountTypeIndex],
                              countryCode: countryCodeController.text,
                              bankAccountOwnerFullName:
                                  accountOwnerController.text,
                            );
                            print(
                                "LOGG payload (client) ${clientPayload.toMap()}");
                            context
                                .read<UploadKycCubit>()
                                .uploadKyc(uploadKycPayload: clientPayload);
                          } else {
                            var recruiterPayload = UploadRecruiterKycPayload(
                              fullName: nameController.text,
                              phoneNumber: phoneController.text,
                              email: emailController.text,
                              businessName: businessNameController.text,
                              businessType:
                                  businessTypeController.text, //TODO: revisit
                              businessAddress: businessAddressController.text,
                              documentType:
                                  documentTypes[selectedDocumentTypeIndex],
                              // frontIdImageUrl: "",
                              frontIdImageUrl: frontImageBloc.imgUrl,
                              // backIdImageUrl: "",
                              backIdImageUrl: backImageBloc.imgUrl,
                            );
                            print(
                                "LOGG payload (recruiter) ${recruiterPayload.toMap()}");
                            context
                                .read<UploadKycCubit>()
                                .uploadKyc(uploadKycPayload: recruiterPayload);
                          }

                          setState(() {});
                        },
                      );
                    }
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String title, required int selectedIndex, required int index}) {
    var itemIsCompletedOrCurrentStage = index <= selectedIndex;
    var isPreviousStage = index < selectedIndex;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: itemIsCompletedOrCurrentStage
                ? MyColors.blue
                : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: itemIsCompletedOrCurrentStage
                ? isPreviousStage
                    ? MyColors.black
                    : MyColors.blue
                : MyColors.tabClr,
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Form(
          key: personalSInfoSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your Personal Details",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: nameController,
                lblColor: MyColors.black,
                label: "Name",
                hint: "Enter the name",
                onChanged: (val) {
                  // nameVal = val;
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomPhonePickerTextField(
                controller: phoneController,
                label: "Phone Number",
                labelColor: MyColors.black,
                onInputValidated: (val) {
                  //TODO: revisit
                },
                initialValue: initialValue,
                onInputChanged: (PhoneNumber number) async {
                  //TODO: revisit
                  initialValue = await PhoneNumber.getRegionInfoFromPhoneNumber(
                      number.phoneNumber ?? "");
                },
                // validator: (val) {},
                validator: (val) => requiredValidationn2(val!),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  leadingPadding: 10,
                  setSelectorButtonAsPrefixIcon: true,
                  showFlags: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                // controller: nameController,
                controller: emailController,
                lblColor: MyColors.black,
                label: "Email",
                hint: "Enter the email",
                onChanged: (val) {
                  // nameVal = val;
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!), //revisit: email validation
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CustomTextField(
              //   // controller: nameController,
              //   controller: pinCodeController,
              //   lblColor: MyColors.black,
              //   label: "Pincode",
              //   hint: "Enter pincode",
              //   onChanged: (val) {
              //     // nameVal = val;
              //     setState(() {});
              //   },
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (val) => requiredValidationn2(val!), //revisit: email validation
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessInfoPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: SingleChildScrollView(
        child: Form(
          key: businessInfoSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your Business Details",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessNameController,
                lblColor: MyColors.black,
                label: "Business name",
                hint: "Enter business name",
                onChanged: (val) {
                  // nameVal = val;
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Doing business as",
                style: TextStyle(
                  fontSize: 13.5,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomDropdown(
              //   list: businessTypes
              //       .map((e) => DropdownMenuItem(
              //             value: e,
              //             child: Text(e.toString()),
              //           ))
              //       .toList(),
              //   value: selectedBusinessType,
              //   onChanged: (val) {
              //     // endMonth = val;
              //     selectedBusinessType = val;
              //     setState(() {});
              //   },
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (val) => requiredValidationn2(val ?? ""),
              //   hintText: Text(
              //     "Select",
              //     style: TextStyle(color: MyColors.grey),
              //   ),
              // ),
              CustomTextField(
                controller: businessTypeController,
                lblColor: MyColors.black,
                label: "Business type",
                hint: "Enter the business type",
                onChanged: (val) {
                  // nameVal = val;
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                // controller: nameController,
                controller: businessAddressController,
                lblColor: MyColors.black,
                label: "Business address",
                hint: "Enter the address",
                onChanged: (val) {
                  // nameVal = val;
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdInfoPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: SingleChildScrollView(
        child: Form(
          key: idProofSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose Document Type",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: _buildDocumentTypes(documentTypes),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Upload ID Proof",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocConsumer<PickImageCubit, InitialImage>(
                        bloc: frontImageBloc,
                        listener: (context, state) {
                          if (state is PickImageState) {
                            idFrontImgUrl = state.url;
                            setState(() {});
                          }
                        },
                        builder: (context, state) {
                          if (state is PickImageState) {
                            return _buildSelectedImage(
                              idFrontImgUrl,
                              onTap: onFrontImageTap,
                            );
                          }
                          return CustomButton(
                            title: "Front",
                            width: 150,
                            height: 150,
                            bgColor: MyColors.white,
                            borderColor: MyColors.blue,
                            fontColor: MyColors.blue,
                            loading: state is LoadingImageState,
                            loadingIndicatorColor: MyColors.blue,
                            onTap: () async {
                              frontImageBloc.getImage();
                            },
                          );
                        }),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: BlocConsumer<PickImageCubit, InitialImage>(
                        bloc: backImageBloc,
                        listener: (context, state) {
                          if (state is PickImageState) {
                            idBackImgUrl = state.url;
                            setState(() {});
                          }
                        },
                        builder: (context, state) {
                          if (state is PickImageState) {
                            return _buildSelectedImage(idBackImgUrl,
                                onTap: onBackImageTap);
                          }
                          return CustomButton(
                            title: "Back",
                            width: 150,
                            height: 150,
                            loading: state is LoadingImageState,
                            loadingIndicatorColor: MyColors.blue,
                            bgColor: MyColors.white,
                            borderColor: MyColors.blue,
                            fontColor: MyColors.blue,
                            onTap: () async {
                              backImageBloc.getImage();
                            },
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankInfoPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22).copyWith(bottom: 0),
      child: SingleChildScrollView(
        child: Form(
          key: bankInfoSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your Bank Details",
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: accountNumberController,
                hint: "Enter account number",
                label: "Account Number",
                lblColor: MyColors.black,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(height: 20),
              Text(
                "Account Type",
                style: TextStyle(
                  fontSize: 13.5,
                  color: MyColors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // CustomDropdown(
              //   list: accountTypes
              //       .map((e) => DropdownMenuItem(
              //             value: e,
              //             child: Text(e.toString()),
              //           ))
              //       .toList(),
              //   value: selectedAccountType,
              //   onChanged: (val) {
              //     selectedAccountType = val;
              //     setState(() {});
              //   },
              //   // validator: (val) =>,
              //   hintText: Text(
              //     "Select",
              //     style: TextStyle(color: MyColors.grey),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Wrap(
                children: _buildBankAccountTypes(bankAccountTypes),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: bankRoutingNumberController,
                hint: "Bank routing number",
                label: "Bank Code",
                lblColor: MyColors.black,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: countryCodeController,
                hint: "Enter country code",
                label: "Country Code",
                lblColor: MyColors.black,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: accountOwnerController,
                hint: "Enter name",
                label: "Account Owner's Full Name",
                lblColor: MyColors.black,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => requiredValidationn2(val!),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImage(String url, {required void Function() onTap}) {
    return CustomCommonCard(
      onTap: () {
        onTap();
      },
      bgColor: MyColors.blue.withOpacity(.10),
      borderRadius: BorderRadius.circular(10),
      borderColor: MyColors.lightBlue,
      height: 150,
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Image.network(
            // "${EndPoint.imageBaseUrl}${state.url}",
            "${EndPoint.imageBaseUrl}$url",
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        ),
      ),
    );
  }

  void onFrontImageTap() {
    frontImageBloc.getImage();
  }

  void onBackImageTap() {
    backImageBloc.getImage();
  }

  Widget _buildDocumentType({
    required String documentTypeName,
    required bool isSelected,
    required int index, 
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        decoration: BoxDecoration(
            color:
                isSelected ? MyColors.lightBlue.withOpacity(0.1) : MyColors.white,
            border: Border.all(
              color: isSelected ? MyColors.lightBlue : MyColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Text(
          documentTypeName,
          style: TextStyle(
            color: isSelected ? MyColors.blue : MyColors.greyTxt,
          ),
        ),
      ),
    );
  }
  
  List<Widget> _buildDocumentTypes(List<String> documentTypes) {
    return documentTypes.asMap().entries.map((item) => _buildDocumentType(
      documentTypeName: item.value,
      index: item.key,
      isSelected: item.key == selectedDocumentTypeIndex,
      onTap: () {
        setState(() {
          var index = item.key;
          selectedDocumentTypeIndex = index;
        });
      },
    )).toList();
  }

  List<Widget> _buildBankAccountTypes(List<String> documentTypes) {
    return documentTypes.asMap().entries.map((item) => _buildDocumentType(
      documentTypeName: item.value,
      index: item.key,
      isSelected: item.key == selectedBankAccountTypeIndex,
      onTap: () {
        setState(() {
          var index = item.key;
          selectedBankAccountTypeIndex = index;
        });
      }
    )).toList();
  }
}
