// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';

import 'package:awas_ace/provider/reminder_provider.dart';
import 'package:awas_ace/repositories/url_api.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/catch_error_submit.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reminderdetailmodel.dart';
import 'package:awas_ace/widgets/model/taskstatusmodel.dart';
import 'package:awas_ace/widgets/pages/home_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;

class ReminderBirthdayDetailPage extends StatefulWidget {
  final Object? linkObject;

  const ReminderBirthdayDetailPage({super.key, required this.linkObject});

  static const String routeName = "/reminderBirthdayDetailPage";

  @override
  State<ReminderBirthdayDetailPage> createState() =>
      _ReminderBirthdayDetailPageState();
}

class ModelSelect {
  String value;
  int id;
  ModelSelect(this.value, this.id);
}

class _ReminderBirthdayDetailPageState
    extends State<ReminderBirthdayDetailPage> {
  Widget titleBar = const Text(
    "Task Detail",
    style: TextStyle(color: Colors.white),
  );

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController iDController = TextEditingController();
  TextEditingController taskStatusController = TextEditingController();
  TextEditingController taskStatusIDController = TextEditingController();
  TextEditingController ketController = TextEditingController();

  List<ModelSelect> bodyCapture = [
    ModelSelect('Pilih Data Yang Sesuai', 1),
  ];

  String taskStatus = '';
  String taskStatusID = '';
  String bodyCaptureVal = 'Pilih Data Yang Sesuai';

  @override
  Widget build(BuildContext context) {
    var textStyleColorWhite = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorPurple = TextStyle(
      color: const Color.fromARGB(
        255,
        90,
        1,
        181,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
    );

    var textStyleColorWhiteB = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    var textStyleColorWhiteBI = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 12.5, landscapeValue: 12.5),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );

    var textStyleColorH = TextStyle(
      color: const Color.fromARGB(
        255,
        90,
        1,
        181,
      ),
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 20.5, landscapeValue: 20.5),
          const Condition.largerThan(
              name: TABLET, value: 25.5, landscapeValue: 25.5, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
    );

    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: titleBar,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(
            255,
            90,
            1,
            181,
          ),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(
          255,
          90,
          1,
          181,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              const Watermark(),
              Consumer(
                builder: (context, WidgetRef ref, child) {
                  var linkObj = widget.linkObject.toString();

                  final databirthdaydetail = ref.watch(reminderDetail(linkObj));

                  return Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: databirthdaydetail.when(
                                data:
                                    (datadetail) =>
                                        (datadetail.listReminderDetail != null)
                                            ? datadetail.listReminderDetail!
                                                    .isNotEmpty
                                                ? ListView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount: datadetail
                                                        .listReminderDetail!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      iDController.text =
                                                          datadetail
                                                              .listReminderDetail![
                                                                  index]
                                                              .iD;

                                                      taskStatusID == ''
                                                          ? taskStatusIDController
                                                                  .text =
                                                              datadetail
                                                                  .listReminderDetail![
                                                                      index]
                                                                  .taskStatusID
                                                                  .toUpperCase()
                                                          : null;

                                                      taskStatus == ''
                                                          ? taskStatusController
                                                                  .text =
                                                              datadetail
                                                                  .listReminderDetail![
                                                                      index]
                                                                  .statusName
                                                          : null;

                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                          20,
                                                          20,
                                                          20,
                                                          0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Text(
                                                                datadetail
                                                                    .listReminderDetail![
                                                                        index]
                                                                    .taskType,
                                                                style:
                                                                    textStyleColorH,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight: 70,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        167,
                                                                        91,
                                                                        1,
                                                                        181,
                                                                      ),
                                                                      blurRadius:
                                                                          3.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          1.1,
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    167,
                                                                    91,
                                                                    1,
                                                                    181,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listReminderDetail![index]
                                                                              .info,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          "Sales - ${datadetail.listReminderDetail![index].salesName}"
                                                                              .toUpperCase(),
                                                                          style:
                                                                              textStyleColorWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minHeight: 90,
                                                                  minWidth: double
                                                                      .infinity,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color
                                                                          .fromARGB(
                                                                        167,
                                                                        91,
                                                                        1,
                                                                        181,
                                                                      ),
                                                                      blurRadius:
                                                                          3.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          1.1,
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                    167,
                                                                    91,
                                                                    1,
                                                                    181,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          datadetail
                                                                              .listReminderDetail![index]
                                                                              .custName,
                                                                          style:
                                                                              textStyleColorWhiteB,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: datadetail.listReminderDetail![index].custHomePhone ==
                                                                                ''
                                                                            ? Column(
                                                                                children: [
                                                                                  const Icon(
                                                                                    Icons.phone_android,
                                                                                    color: Colors.white,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                  Text(
                                                                                    datadetail.listReminderDetail![index].custPhone,
                                                                                    style: textStyleColorWhite,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : datadetail.listReminderDetail![index].custPhone == ''
                                                                                ? Column(
                                                                                    children: [
                                                                                      const Icon(
                                                                                        Icons.phone,
                                                                                        color: Colors.white,
                                                                                        size: 35.0,
                                                                                      ),
                                                                                      Text(
                                                                                        datadetail.listReminderDetail![index].custHomePhone,
                                                                                        style: textStyleColorWhite,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Column(
                                                                                        children: [
                                                                                          const Icon(
                                                                                            Icons.phone,
                                                                                            color: Colors.white,
                                                                                            size: 35.0,
                                                                                          ),
                                                                                          Text(
                                                                                            datadetail.listReminderDetail![index].custHomePhone,
                                                                                            style: textStyleColorWhite,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Column(
                                                                                        children: [
                                                                                          const Icon(
                                                                                            Icons.phone_android,
                                                                                            color: Colors.white,
                                                                                            size: 35.0,
                                                                                          ),
                                                                                          Text(
                                                                                            datadetail.listReminderDetail![index].custPhone,
                                                                                            style: textStyleColorWhite,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        "Body Capture :",
                                                                        style:
                                                                            textStyleColorPurple,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: DropdownSearch<
                                                                        ModelSelect>(
                                                                      popupProps:
                                                                          PopupProps
                                                                              .dialog(
                                                                        dialogProps:
                                                                            const DialogProps(
                                                                          shape:
                                                                              Border.symmetric(
                                                                            vertical:
                                                                                BorderSide.none,
                                                                          ),
                                                                        ),
                                                                        showSearchBox:
                                                                            true,
                                                                        searchFieldProps:
                                                                            TextFieldProps(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "Search..",
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  134,
                                                                                  134,
                                                                                  134,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  146,
                                                                                  2,
                                                                                  2,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      items:
                                                                          bodyCapture,
                                                                      itemAsString: (ModelSelect
                                                                              bodyCaptureOpt) =>
                                                                          bodyCaptureOpt
                                                                              .value
                                                                              .toUpperCase(),
                                                                      dropdownDecoratorProps:
                                                                          DropDownDecoratorProps(
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          hintStyle:
                                                                              textStyleColorPurple,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                91,
                                                                                1,
                                                                                181,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                91,
                                                                                1,
                                                                                181,
                                                                              ),
                                                                              width: 2,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (ModelSelect?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          //print(value);
                                                                          bodyCaptureVal =
                                                                              value!.value;
                                                                        });
                                                                      },
                                                                      dropdownBuilder:
                                                                          (context, selectedItem) =>
                                                                              Text(
                                                                        bodyCaptureVal !=
                                                                                ''
                                                                            ? bodyCaptureVal
                                                                            : "-",
                                                                        style:
                                                                            textStyleColorPurple,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (datadetail
                                                                    .listReminderDetail![
                                                                        index]
                                                                    .countTaskDetail !=
                                                                null)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  0,
                                                                  10,
                                                                  0,
                                                                  10,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  constraints:
                                                                      const BoxConstraints(
                                                                    minHeight:
                                                                        10,
                                                                    minWidth: double
                                                                        .infinity,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color
                                                                            .fromARGB(
                                                                          167,
                                                                          91,
                                                                          1,
                                                                          181,
                                                                        ),
                                                                        blurRadius:
                                                                            3.0,
                                                                        offset:
                                                                            Offset(
                                                                          0,
                                                                          0,
                                                                        ),
                                                                        spreadRadius:
                                                                            1.1,
                                                                      ),
                                                                    ],
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10.0,
                                                                    ),
                                                                    color: const Color
                                                                        .fromARGB(
                                                                      167,
                                                                      91,
                                                                      1,
                                                                      181,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      ExpansionTile(
                                                                    trailing:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Color
                                                                          .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255,
                                                                      ),
                                                                      size:
                                                                          15.0,
                                                                    ),
                                                                    title: Text(
                                                                      "History ",
                                                                      style:
                                                                          textStyleColorWhiteB,
                                                                    ),
                                                                    children: [
                                                                      for (int x =
                                                                              0;
                                                                          datadetail.listReminderDetail![index].countTaskDetail != null
                                                                              ? x < datadetail.listReminderDetail![index].countTaskDetail!.length
                                                                              : x < 0;
                                                                          x++)
                                                                        Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.fromLTRB(
                                                                              25,
                                                                              0,
                                                                              20,
                                                                              15,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    "${datadetail.listReminderDetail![index].countTaskDetail![x].CreatedDate} - ${datadetail.listReminderDetail![index].countTaskDetail![x].Name}",
                                                                                    style: textStyleColorWhiteBI,
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    datadetail.listReminderDetail![index].countTaskDetail![x].TaskNote,
                                                                                    style: textStyleColorWhiteB,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      10,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        "Status :",
                                                                        style:
                                                                            textStyleColorPurple,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: DropdownSearch<
                                                                        TaskStatus>(
                                                                      popupProps:
                                                                          PopupProps
                                                                              .dialog(
                                                                        dialogProps:
                                                                            const DialogProps(
                                                                          shape:
                                                                              Border.symmetric(
                                                                            vertical:
                                                                                BorderSide.none,
                                                                          ),
                                                                        ),
                                                                        showSearchBox:
                                                                            true,
                                                                        searchFieldProps:
                                                                            TextFieldProps(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "Search..",
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  134,
                                                                                  134,
                                                                                  134,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  134,
                                                                                  134,
                                                                                  134,
                                                                                ),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        itemBuilder: (context,
                                                                                item,
                                                                                isSelected) =>
                                                                            ListTile(
                                                                          title:
                                                                              Text(
                                                                            item.text,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      dropdownDecoratorProps:
                                                                          DropDownDecoratorProps(
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          errorStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                          errorBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          hintStyle:
                                                                              textStyleColorPurple,
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                91,
                                                                                1,
                                                                                181,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: Color.fromARGB(
                                                                                167,
                                                                                91,
                                                                                1,
                                                                                181,
                                                                              ),
                                                                              width: 2,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                          () {
                                                                            taskStatus =
                                                                                value!.text;

                                                                            taskStatusID =
                                                                                value.iD.toUpperCase();

                                                                            taskStatusController.text =
                                                                                taskStatus;

                                                                            taskStatusIDController.text =
                                                                                taskStatusID;
                                                                          },
                                                                        );
                                                                      },
                                                                      dropdownBuilder:
                                                                          (context, selectedItem) =>
                                                                              Text(
                                                                        taskStatus !=
                                                                                ''
                                                                            ? taskStatus
                                                                            : datadetail.listReminderDetail![index].statusName,
                                                                        style:
                                                                            textStyleColorPurple,
                                                                      ),
                                                                      asyncItems:
                                                                          (String
                                                                              filter) async {
                                                                        var response =
                                                                            await http.get(
                                                                          Uri.parse(
                                                                            "${urlApi()}Reminder/GetTaskStatusReminder/1",
                                                                          ),
                                                                        );
                                                                        if (response.statusCode !=
                                                                            200) {
                                                                          return [];
                                                                        }
                                                                        List allTaskStatus = (jsonDecode(
                                                                            response
                                                                                .body) as Map<
                                                                            String,
                                                                            dynamic>)["listTaskStatusReminder"];
                                                                        List<TaskStatus>
                                                                            allModelTaskStatus =
                                                                            [];

                                                                        for (var element
                                                                            in allTaskStatus) {
                                                                          allModelTaskStatus
                                                                              .add(
                                                                            TaskStatus(
                                                                              iD: element["iD"],
                                                                              text: element["text"],
                                                                            ),
                                                                          );
                                                                        }
                                                                        return allModelTaskStatus;
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        false,
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          taskStatusIDController,
                                                                      autocorrect:
                                                                          false,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Task Status',
                                                                        hintStyle:
                                                                            textStyleColorPurple,
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              90,
                                                                              1,
                                                                              181,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        "Keterangan :",
                                                                        style:
                                                                            textStyleColorPurple,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        TextFormField(
                                                                      style:
                                                                          textStyleColorPurple,
                                                                      autocorrect:
                                                                          false,
                                                                      controller:
                                                                          ketController,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        errorStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            17,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                        errorBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              17,
                                                                              0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        hintText:
                                                                            'Keterangan',
                                                                        hintStyle:
                                                                            textStyleColorPurple,
                                                                        labelText:
                                                                            'Keterangan',
                                                                        labelStyle:
                                                                            textStyleColorPurple,
                                                                        enabledBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              167,
                                                                              91,
                                                                              1,
                                                                              181,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              167,
                                                                              91,
                                                                              1,
                                                                              181,
                                                                            ),
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                10,
                                                                0,
                                                                20,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  OutlinedButton(
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      side:
                                                                          const BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Color
                                                                            .fromARGB(
                                                                          255,
                                                                          90,
                                                                          1,
                                                                          181,
                                                                        ),
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      fixedSize:
                                                                          Size(
                                                                        ResponsiveValue<double>(context,
                                                                                conditionalValues: [
                                                                                  const Condition.equals(
                                                                                    name: TABLET,
                                                                                    value: 200,
                                                                                    landscapeValue: 200,
                                                                                  ),
                                                                                  const Condition.largerThan(
                                                                                    name: TABLET,
                                                                                    value: 200,
                                                                                    landscapeValue: 200,
                                                                                    breakpoint: 800,
                                                                                  ),
                                                                                ],
                                                                                defaultValue: 130)
                                                                            .value,
                                                                        ResponsiveValue<
                                                                            double>(
                                                                          context,
                                                                          conditionalValues: [
                                                                            const Condition.equals(
                                                                                name: TABLET,
                                                                                value: 55,
                                                                                landscapeValue: 55),
                                                                            const Condition.largerThan(
                                                                                name: TABLET,
                                                                                value: 55,
                                                                                landscapeValue: 55,
                                                                                breakpoint: 800),
                                                                          ],
                                                                          defaultValue:
                                                                              50,
                                                                        ).value,
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          const Color
                                                                              .fromARGB(
                                                                        255,
                                                                        90,
                                                                        1,
                                                                        181,
                                                                      ),
                                                                    ).copyWith(
                                                                      overlayColor:
                                                                          MaterialStateProperty.resolveWith<
                                                                              Color?>(
                                                                        (Set<MaterialState>
                                                                            states) {
                                                                          if (states
                                                                              .contains(MaterialState.pressed)) {
                                                                            return const Color.fromARGB(
                                                                              255,
                                                                              129,
                                                                              26,
                                                                              247,
                                                                            );
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      var updateReminder =
                                                                          ListReminderUpdate(
                                                                        iD: iDController
                                                                            .text,
                                                                        taskStatusID:
                                                                            taskStatusIDController.text,
                                                                        taskNote:
                                                                            ketController.text,
                                                                      );

                                                                      try {
                                                                        var resp = await ref
                                                                            .read(updateReminderFormProviderDetail)
                                                                            .onUpdateReminder(updateReminder);

                                                                        if (resp.statusMessage ==
                                                                            "Success Updated") {
                                                                          ketController
                                                                              .clear();
                                                                        }

                                                                        Navigator.of(context)
                                                                            .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage(),
                                                                          ),
                                                                          (route) =>
                                                                              false,
                                                                        );

                                                                        notifUpdated(
                                                                            context);
                                                                      } catch (e) {
                                                                        Navigator.of(context)
                                                                            .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const HomePage(),
                                                                          ),
                                                                          (route) =>
                                                                              false,
                                                                        );

                                                                        catchError(
                                                                          context,
                                                                          e,
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      children: <Widget>[
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            "Simpan",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                textStyleColorWhite,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const MyAlertDialog()
                                            : const notActivetoken(),
                                error: (err, stack) => Text('Error $err'),
                                loading: () => const Center(
                                  child: Column(
                                    children: [loadingAnimation()],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void notifUpdated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ("Success Updated" == "Success Updated")
            ? const Color.fromARGB(
                255,
                1,
                209,
                29,
              )
            : Colors.red,
        content: Text(("Success Updated" == "Success Updated")
            ? "Task berhasil di update dengan status ${taskStatusController.text} "
            : "Task gagal di update "),
      ),
    );
  }
}
