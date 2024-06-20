import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:insta_job/bloc/validation/validation_bloc.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:insta_job/widgets/custom_button/custom_btn.dart';
import 'package:insta_job/widgets/custom_drop_down.dart';
import 'package:insta_job/widgets/custom_text_field.dart';

enum AccountType {
  checking,
  saving,
}

class AddBankInfoScreen extends StatefulWidget {
  const AddBankInfoScreen({super.key});

  @override
  State<AddBankInfoScreen> createState() => _AddBankInfoScreenState();
}

class _AddBankInfoScreenState extends State<AddBankInfoScreen> {
  List<String> accountTypes =
      AccountType.values.map((e) => e.name.toUpperCase()).toList();
  String? selectedAccountType;
  Country? selectedCountry;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankRoutingNumberController = TextEditingController();
  TextEditingController accountOwnerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            title: "Add Bank Info",
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: accountNumberController,
                  hint: "Enter account number",
                  label: "Account Number",
                  lblColor: MyColors.black,
                  keyboardType: TextInputType.number,
                  validator: (val) => requiredValidationn(val!),
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
                CustomDropdown(
                  list: accountTypes
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  value: selectedAccountType,
                  onChanged: (val) {
                    selectedAccountType = val;
                    setState(() {});
                  },
                  // validator: (val) =>,
                  hintText: Text(
                    "Select",
                    style: TextStyle(color: MyColors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: bankRoutingNumberController,
                  hint: "Bank code",
                  label: "Bank routing number",
                  lblColor: MyColors.black,
                  keyboardType: TextInputType.number,
                  validator: (val) => requiredValidationn(val!),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Country",
                      style: TextStyle(
                        fontSize: 13.5,
                        color: MyColors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // Text(
                    //   // "EN",
                    //   selectedCountry?.displayNameNoCountryCode ?? "EN",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: MyColors.blue,
                    //     fontWeight: FontWeight.w700,
                    //     wordSpacing: 2,
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    // CountryCodePicker(
                    //   onChanged: print,
                    //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    //   initialSelection: 'IT',
                    //   favorite: ['+39','FR'],
                    //   // optional. Shows only country name and flag
                    //   showCountryOnly: true,
                    //   // optional. Shows only country name and flag when popup is closed.
                    //   showOnlyCountryWhenClosed: true,
                    //   // optional. aligns the flag and the Text left
                    //   alignLeft: false,
                    // ),

                    TextButton.icon(
                      label: Text(selectedCountry?.displayNameNoCountryCode ??
                          "Select"),
                      icon: const Icon(Icons.flag),
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight:
                                500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            selectedCountry = country;
                            print('Select country: ${country.displayName}');
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: accountOwnerController,
                  hint: "Account owner's full name",
                  label: "Name",
                  lblColor: MyColors.black,
                  keyboardType: TextInputType.text,
                  validator: (val) => requiredValidationn(val!),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  title: "Add Banking Info",
                  bgColor: MyColors.white,
                  borderColor: MyColors.blue,
                  fontColor: MyColors.blue,
                  onTap: () {
                    if (accountNumberController.text.isNotEmpty &&
                        selectedAccountType != null &&
                        bankRoutingNumberController.text.isNotEmpty &&
                        selectedCountry != null &&
                        accountOwnerController.text.isNotEmpty) {
                      debugPrint(
                          "LOGG:: acc ${accountNumberController.text} type $selectedAccountType routing ${bankRoutingNumberController.text} country ${selectedCountry} name ${accountOwnerController.text}");
                    } else {
                      debugPrint("LOGG:: incomplete data");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
