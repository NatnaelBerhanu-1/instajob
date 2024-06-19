import 'package:flutter/material.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
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
  List<String> businessTypes = ["Financial entity", "Business entity"].cast<String>();
  String? selectedBusinessType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: MyColors.tabClr,
                labelColor: MyColors.blue,
                indicatorColor: MyColors.blue,
                onTap: (val) {
                  tabIndex = val;
                  // context.read<InterviewScheduleCubit>().getInterviewSchedules(Global.userModel!.id.toString());
                  setState(() {});
                },
                tabs: const [
                  Tab(text: "Personal Info"),
                  Tab(text: "Business Info"),
                  Tab(text: "ID Proof"),
                ]),
            Expanded(
              child: Builder(builder: (context) {
                return TabBarView(
                  children: [
                    _buildPersonalInfoPage(),
                    _buildBusinessInfoPage(),
                    _buildIdInfoPage(),
                  ],
                );
              }),
            )
          ],
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
          const SizedBox(
            height: 20,
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
        ],
      ),
    );
  }

}
