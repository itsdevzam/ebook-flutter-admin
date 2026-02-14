import 'dart:async';

import 'package:ebook_admin/features/ebook/controller/EbookController.dart';
import 'package:ebook_admin/features/ebook/model/EbookModel.dart';
import 'package:ebook_admin/features/ebook/widget/ImagePickPlaceHolder.dart';
import 'package:ebook_admin/helper/AssestImageByte.dart';
import 'package:ebook_admin/helper/AssestImageByteDel.dart';
import 'package:ebook_admin/helper/MyNetworkDelImage.dart';
import 'package:ebook_admin/helper/MyRectangleButton.dart'
    show MyRectangleButton;
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyEbookDialog {
  void MyAddEbookDialog({required EbookController ebookController}) async {
    await Get.defaultDialog(
      title: "Add Ebook",
      content: SingleChildScrollView(
        child: Column(
          children: [
            ///Image
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ebookController.isImagePicked.value
                    ? AssestImageByteDel(
                        imageBytes: ebookController.imageBytes!,
                        onCutCallback: () {
                          ebookController.isImagePicked.value = false;
                        },
                      )
                    : InkWell(
                        onTap: () => ebookController.pickImage(),
                        child: ImagePickPlaceHolder(),
                      ),
              ),
            ),
            SizedBox(height: 20),

            ///Other
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Title",
                    textEditingController: ebookController.titleTextController,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Description",
                    textEditingController: ebookController.descTextController,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      label: Text("Book Price"),
                      border: OutlineInputBorder(),
                    ),
                    initialValue: ebookController.ebookInitOptionValue.value,
                    items: [
                      DropdownMenuItem(value: 0, child: Text("Free")),
                      DropdownMenuItem(value: 1, child: Text("Paid")),
                    ],
                    onChanged: (value) {
                      ebookController.ebookInitOptionValue.value = value!;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () => DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        label: Text("Category"),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: ebookController.ebookCatOptionValue.value,
                      items: ebookController.ebookCatListMap.entries.map((e) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ebookController.ebookCatOptionValue.value = value!;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ebookController.isPdfPicked.value?MyText(text: ebookController.pdfFileName.value):MyText(text: "Upload Ebook PDF"),
                        CircleAvatar(backgroundColor: ThemeColors.primaryColor.withAlpha(150),child: IconButton(onPressed: (){
                          if(ebookController.isPdfPicked.value){
                            ebookController.isPdfPicked.value=false;
                          }else{
                            ebookController.pickPdf();
                          }

                        }, icon: ebookController.isPdfPicked.value?Icon(FontAwesomeIcons.xmark):Icon(FontAwesomeIcons.arrowUpFromBracket)),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                MyRectangleButton(
                  label: "Save",
                  callback: () => {
                    ebookController.addEbook(
                      ebookModel: EbookModel(
                        title: ebookController.titleTextController.text,
                        url: ebookController.urlTextController.text,
                        description: ebookController.descTextController.text,
                        categoryId: ebookController.ebookCatOptionValue.value,
                        isPaid: ebookController.ebookInitOptionValue.value,
                      ),
                      pdfBytes: ebookController.pdfBytes!,
                      imageBytes: ebookController.imageBytes!,
                    ),
                    ///to close dialog
                    Get.back(),
                    ///to refresh list
                    Timer(Duration(milliseconds: 500),()=>ebookController.allEbooksData(page: ebookController.currentPage.toString())),
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void MyEditEbookDialog({
    required EbookController ebookController,
    required EbookModel ebookModel,
  }) async {
    await Get.defaultDialog(
      title: "Edit Ebook",
      content: SingleChildScrollView(
        child: Column(
          children: [
            ///Image
            Obx(
                  () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ebookController.isImagePicked.value
                    ? AssestImageByteDel(
                  imageBytes: ebookController.imageBytes!,
                  onCutCallback: () {
                    ebookController.isImagePicked.value = false;
                  },
                )
                    : InkWell(
                  onTap: () => ebookController.pickImage(),
                  child: ImagePickPlaceHolder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Title",
                    textEditingController: ebookController.titleTextController,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Description",
                    textEditingController: ebookController.descTextController,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      label: Text("Book Price"),
                      border: OutlineInputBorder(),
                    ),
                    initialValue: ebookController.ebookInitOptionValue.value,
                    items: [
                      DropdownMenuItem(value: 0, child: Text("Free")),
                      DropdownMenuItem(value: 1, child: Text("Paid")),
                    ],
                    onChanged: (value) {
                      ebookController.ebookInitOptionValue.value = value!;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                        () => DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        label: Text("Category"),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: ebookController.ebookCatOptionValue.value,
                      items: ebookController.ebookCatListMap.entries.map((e) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ebookController.ebookCatOptionValue.value = value!;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextField(
                        label: "Url",
                        textEditingController: ebookController.urlTextController,
                        enable: false,
                        width: 300,
                      ),
                      CircleAvatar(child: IconButton(onPressed: (){
                        ebookController.openInNewTab("${Constants.baseURL}${ebookController.urlTextController.text}");
                      }, icon: Icon(Iconsax.eye)),)
                    ],
                  ),
                ),

                SizedBox(height: 20),
                MyRectangleButton(label: "Update", callback: () {
                  ebookController.editEbook(imageBytes: ebookController.imageBytes!, ebookModel: EbookModel(
                    id: ebookModel.id,
                    title: ebookController.titleTextController.text,
                    url: ebookController.urlTextController.text,
                    description: ebookController.descTextController.text,
                    categoryId: ebookController.ebookCatOptionValue.value,
                    isPaid: ebookController.ebookInitOptionValue.value,
                  ));
                  ///to close dialog
                  Get.back();
                  ///to refresh list
                  Timer(Duration(milliseconds: 500),()=>ebookController.allEbooksData(page: ebookController.currentPage.toString()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
