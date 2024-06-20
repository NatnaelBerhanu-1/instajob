import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UploadKycScreen extends StatefulWidget {
  const UploadKycScreen({super.key});

  @override
  State<UploadKycScreen> createState() => _UploadKycScreenState();
}

class _UploadKycScreenState extends State<UploadKycScreen> {
  int tabIndex = 0;
  TextEditingController phoneController = TextEditingController();
  var initialValue = PhoneNumber(isoCode: "US");
  List<String> businessTypes =
      ["Financial entity", "Business entity"].cast<String>();
  String? selectedBusinessType;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("curr  page $_currentPage");
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
            children: [
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
                children: [
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
                      child: CustomButton(
                    title: "Back",
                    bgColor: MyColors.white,
                    borderColor: MyColors.blue,
                    fontColor: MyColors.blue,
                    height: 48,
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {});
                    },
                  )),
                const SizedBox(width: 15),
                if (_currentPage < 2)
                  Expanded(
                    child: CustomButton(
                      title: "Next",
                      // width: 120,
                      height: 48,
                      onTap: () async {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() {});
                      },
                    ),
                  ),
                if (_currentPage == 2)
                  Expanded(
                    child: CustomButton(
                      title: "Submit",
                      // width: 120,
                      height: 48,
                      onTap: () async {
                        setState(() {});
                      },
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
            // controller: nameController,
            lblColor: MyColors.black,
            label: "Name",
            hint: "Enter the name",
            onChanged: (val) {
              // nameVal = val;
              setState(() {});
            },
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
            lblColor: MyColors.black,
            label: "Email",
            hint: "Enter the email",
            onChanged: (val) {
              // nameVal = val;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            // controller: nameController,
            lblColor: MyColors.black,
            label: "Pincode",
            hint: "Enter pincode",
            onChanged: (val) {
              // nameVal = val;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
            // controller: nameController,
            lblColor: MyColors.black,
            label: "Business name",
            hint: "Enter business name",
            onChanged: (val) {
              // nameVal = val;
              setState(() {});
            },
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
          CustomDropdown(
            list: businessTypes
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
            value: selectedBusinessType,
            onChanged: (val) {
              // endMonth = val;
              selectedBusinessType = val;
              setState(() {});
            },
            // validator: (val) =>,
            hintText: Text(
              "Select",
              style: TextStyle(color: MyColors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            // controller: nameController,
            lblColor: MyColors.black,
            label: "Business address",
            hint: "Enter the address",
            onChanged: (val) {
              // nameVal = val;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildIdInfoPage() {
    List<String> documentTypes = ["Driving License", "Passport", "ID Card"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
            children: [
              _buildDocumentType(
                documentTypeName: "Driving License",
                index: 0,
                isSelected: false,
              ),
              _buildDocumentType(
                documentTypeName: "Passport",
                index: 1,
                isSelected: false,
              ),
              _buildDocumentType(
                documentTypeName: "ID Card",
                index: 2,
                isSelected: false,
              ),
            ],
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
                child: CustomButton(
                  title: "Front",
                  width: 150,
                  height: 150,
                  bgColor: MyColors.white,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () async {},
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: CustomButton(
                  title: "Back",
                  width: 150,
                  height: 150,
                  bgColor: MyColors.white,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () async {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container _buildDocumentType({
    required String documentTypeName,
    required bool isSelected,
    required int index,
  }) {
    return Container(
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
    );
  }
}
