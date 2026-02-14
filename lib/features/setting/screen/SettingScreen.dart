import 'dart:convert';
import 'dart:typed_data';

import 'package:ebook_admin/features/setting/controller/SettingsController.dart';
import 'package:ebook_admin/features/setting/widget/SelectImagePlaceHolder.dart';
import 'package:ebook_admin/features/setting/widget/SliderByteImage.dart';
import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/helper/MyRectangleButton.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Heading
        MyHeading(text: "Settings"),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Tabs
        DefaultTabController(
          length: 3,
          child: Expanded(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Iconsax.setting_2), text: "General Setings"),
                    Tab(icon: Icon(Iconsax.slider), text: "Slider"),
                    Tab(
                      icon: Icon(Iconsax.profile_tick),
                      text: "Admin Profile",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Obx(
                            () =>
                        _settingsController.isLoading.value
                            ? Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors.primaryColor,
                          ),
                        )
                            : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              MyTextField(
                                label: "App Name",
                                textEditingController:
                                _settingsController.appNameController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Admob Banner",
                                textEditingController: _settingsController
                                    .admobBannerController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Admob Inter",
                                textEditingController: _settingsController
                                    .admobInterController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Admob Video",
                                textEditingController: _settingsController
                                    .admobVideoController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Coupon Code",
                                textEditingController:
                                _settingsController.couponController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Percentage Discount",
                                textEditingController: _settingsController
                                    .discountController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "1 Month Price",
                                textEditingController: _settingsController
                                    .oneMonthController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "6 Months Price",
                                textEditingController: _settingsController
                                    .sixMonthController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "1 Year Price",
                                textEditingController:
                                _settingsController.oneYearController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                label: "Copyright",
                                textEditingController: _settingsController
                                    .copyrightController,
                                width: Constants.isDesktop(context)
                                    ? 400
                                    : (Constants.getScreenWidth(context) -
                                    100),
                              ),
                              SizedBox(height: 10),
                              MyRectangleButton(
                                label: "Save",
                                callback: () =>
                                {
                                  _settingsController.updateSettings(
                                    appName: _settingsController
                                        .appNameController
                                        .text,
                                    banner: _settingsController
                                        .admobBannerController
                                        .text,
                                    inter: _settingsController
                                        .admobInterController
                                        .text,
                                    video: _settingsController
                                        .admobVideoController
                                        .text,
                                    copyright: _settingsController
                                        .copyrightController
                                        .text,
                                    coupon: _settingsController
                                        .couponController
                                        .text,
                                    discount: _settingsController
                                        .discountController
                                        .text,
                                    oneMonth: _settingsController
                                        .oneMonthController
                                        .text,
                                    sixMonth: _settingsController
                                        .sixMonthController
                                        .text,
                                    oneYear: _settingsController
                                        .oneYearController
                                        .text,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 10),
                            Obx(
                                  () =>
                              _settingsController.sliderOne.value.isNotEmpty
                                  ? SliderByteImage(
                                onCutCallback: () {
                                  _settingsController.sliderOne.value =
                                      Uint8List(0);
                                },
                                imageBytes: _settingsController.sliderOne.value,
                              )
                                  : SelectImagePlaceHolder(
                                callback: () {
                                  _settingsController.pickImage(
                                    slider: _settingsController.sliderOne,
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 10),
                            Obx(
                                  () =>
                              _settingsController.sliderTwo.value.isNotEmpty
                                  ? SliderByteImage(
                                onCutCallback: () {
                                  _settingsController.sliderTwo.value =
                                      Uint8List(0);
                                },
                                imageBytes: _settingsController.sliderTwo.value,
                              )
                                  : SelectImagePlaceHolder(
                                callback: () {
                                  _settingsController.pickImage(
                                    slider: _settingsController.sliderTwo,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                                  () =>
                              _settingsController.sliderThree.value.isNotEmpty
                                  ? SliderByteImage(
                                onCutCallback: () {
                                  _settingsController.sliderThree.value =
                                      Uint8List(0);
                                },
                                imageBytes: _settingsController.sliderThree
                                    .value,
                              )
                                  : SelectImagePlaceHolder(
                                callback: () {
                                  _settingsController.pickImage(
                                    slider: _settingsController.sliderThree,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            MyRectangleButton(label: "Save", callback: () {
                              _settingsController.updateSlider(
                                  sliderOne: base64Encode(
                                      _settingsController.sliderOne.value),
                                  sliderTwo: base64Encode(
                                      _settingsController.sliderTwo.value),
                                  sliderThree: base64Encode(
                                      _settingsController.sliderThree.value));
                            }),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            MyHeading(text: "Admin Profile", fontSize: 16),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "Admin Title",
                              textEditingController:
                              _settingsController.adminTitleController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "Admin Username",
                              textEditingController:
                              _settingsController.adminUsernameController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "Admin Email",
                              textEditingController:
                              _settingsController.adminEmailController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyRectangleButton(
                              label: "Save",
                              callback: () =>
                              {
                                _settingsController.updateAdminProfile(
                                  adminTitle: _settingsController
                                      .adminTitleController
                                      .text,
                                  adminUsername: _settingsController
                                      .adminUsernameController
                                      .text,
                                  adminEmail: _settingsController
                                      .adminEmailController
                                      .text,
                                ),
                              },
                            ),
                            SizedBox(height: 20),
                            Divider(thickness: 2),
                            SizedBox(height: 30),
                            MyHeading(text: "Reset Password", fontSize: 16),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "Old Password",
                              textEditingController:
                              _settingsController.oldPassController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "New Password",
                              textEditingController:
                              _settingsController.newPassController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyTextField(
                              label: "Confirm New Password",
                              textEditingController:
                              _settingsController.confirmPassController,
                              width: Constants.isDesktop(context)
                                  ? 400
                                  : (Constants.getScreenWidth(context) - 100),
                            ),
                            SizedBox(height: 10),
                            MyRectangleButton(
                              label: "Reset",
                              callback: () =>
                              {
                                _settingsController.resetAdminPass(
                                  oldPass: _settingsController
                                      .oldPassController
                                      .text
                                      .trim(),
                                  newPass: _settingsController
                                      .confirmPassController
                                      .text
                                      .trim(),
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingsController.getSettings();
    _settingsController.getAdminProfile();
  }
}
