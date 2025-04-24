import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringPoinHistoryPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitoringPoinHistoryPage({super.key, required this.linkPageObj});

  static const String routeName = "/monitoringPoinHistoryPage";
  @override
  State<MonitoringPoinHistoryPage> createState() =>
      _MonitoringPoinHistoryPageState();
}

// Model TreeNode
class TreeNode {
  final String key;
  final int? poin;
  final String? poinName;
  final List<TreeNode> children;

  TreeNode({
    required this.key,
    this.poin,
    List<TreeNode>? children,
    this.poinName,
  }) : children = children ?? [];
}

// Fungsi membangun tree dari data API
List<TreeNode> buildTree(List<ListRptGeneralMonitoringPoinHistory> data) {
  // Group data berdasarkan RowGroup
  final menus = <TreeNode>[];

  // RowGroup = 2 → Menu
  final rowGroup2 = data.where((e) => e.rowGroup == 2).toList();

  for (var menu in rowGroup2) {
    // Buat node untuk Menu (RowGroup 2)
    final submenuNodes = <TreeNode>[];

    // RowGroup = 3 → Submenu (anak dari Header2)
    final rowGroup3 = data
        .where((e) => e.rowGroup == 3 && e.header2 == menu.header2)
        .toList();

    for (var submenu in rowGroup3) {
      // Buat node untuk Submenu (RowGroup 3)
      final subsubmenuNodes = <TreeNode>[];

      // RowGroup = 4 → subsubmenu (anak dari Header3)
      final rowGroup4 = data
          .where((e) => e.rowGroup == 4 && e.header3 == submenu.header3)
          .toList();

      for (var subsubmenu in rowGroup4) {
        // Buat node untuk subsubmenu (RowGroup 4)
        subsubmenuNodes.add(
          TreeNode(
            key: subsubmenu.title.replaceAll('\\n', '\n'),
            poin: subsubmenu.poin,
            poinName: subsubmenu.poinName,
          ),
        );
      }

      submenuNodes.add(
        TreeNode(
          key: submenu.title.replaceAll('\\n', '\n'),
          poin: submenu.poin,
          poinName: submenu.poinName,
          children: subsubmenuNodes,
        ),
      );
    }

    menus.add(
      TreeNode(
        key: menu.title.replaceAll('\\n', '\n'),
        poin: menu.poin,
        poinName: menu.poinName,
        children: submenuNodes,
      ),
    );
  }

  return menus;
}

class _MonitoringPoinHistoryPageState extends State<MonitoringPoinHistoryPage> {
  Widget titleBar = const Text(
    "Monitoring Poin",
    style: TextStyle(color: Colors.white),
  );

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
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
    );

    var textStyleColorWhiteBI = TextStyle(
      color: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: ResponsiveValue<double>(
        context,
        conditionalValues: [
          const Condition.equals(
              name: TABLET, value: 14.0, landscapeValue: 14.0),
          const Condition.largerThan(
              name: TABLET, value: 17.0, landscapeValue: 17.0, breakpoint: 800),
        ],
        defaultValue: 12.0,
      ).value,
    );

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: titleBar,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                255,
                33,
                44,
                81,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    final treeData = ref.watch(
                      reportMonitPoinHistory(linkPageObj),
                    );

                    return Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: treeData.when(
                                  data: (model) {
                                    List<TreeNode> nodes = buildTree(
                                      model
                                          .listRptGeneralMonitoringPoinHistory!,
                                    );

                                    final treeController =
                                        TreeController<TreeNode>(
                                      roots: nodes,
                                      childrenProvider: (node) => node.children,
                                    );

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        20,
                                        10,
                                        0,
                                      ),
                                      child: TreeView<TreeNode>(
                                        treeController: treeController,
                                        nodeBuilder: (context, entry) {
                                          bool isExpanded = treeController
                                              .getExpansionState(entry.node);
                                          return TreeIndentation(
                                            entry: entry,
                                            guide: const IndentGuide
                                                .connectingLines(
                                              indent: 35,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: entry.level * 16.0,
                                              ),
                                              child: ListTile(
                                                title: Builder(
                                                  builder: (_) {
                                                    final isSubsubmenu =
                                                        entry.level == 2;
                                                    if (isSubsubmenu) {
                                                      Color poinBoxColor =
                                                          Colors.white
                                                              .withOpacity(0.1);
                                                      if (entry.node.poin ==
                                                          300) {
                                                        poinBoxColor =
                                                            const Color
                                                                .fromARGB(
                                                          255,
                                                          61,
                                                          101,
                                                          171,
                                                        );
                                                      } else if (entry
                                                              .node.poin ==
                                                          150) {
                                                        poinBoxColor =
                                                            const Color
                                                                .fromARGB(
                                                          255,
                                                          109,
                                                          149,
                                                          79,
                                                        );
                                                      }

                                                      final poinBox = Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: poinBoxColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          border: Border.all(
                                                            color:
                                                                Colors.white30,
                                                          ),
                                                        ),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            style:
                                                                textStyleColorWhite,
                                                            children: [
                                                              WidgetSpan(
                                                                alignment:
                                                                    PlaceholderAlignment
                                                                        .middle,
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .coins,
                                                                  color: Colors
                                                                      .amber,
                                                                  size: ResponsiveValue<
                                                                      double>(
                                                                    context,
                                                                    conditionalValues: [
                                                                      const Condition
                                                                          .equals(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              14.0,
                                                                          landscapeValue:
                                                                              14.0),
                                                                      const Condition
                                                                          .largerThan(
                                                                          name:
                                                                              TABLET,
                                                                          value:
                                                                              17.0,
                                                                          landscapeValue:
                                                                              17.0,
                                                                          breakpoint:
                                                                              800),
                                                                    ],
                                                                    defaultValue:
                                                                        12.0,
                                                                  ).value,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    ' ${entry.node.poin ?? ""}',
                                                                style:
                                                                    textStyleColorWhite,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );

                                                      // Pisah title menjadi baris per baris
                                                      final titleLines = entry
                                                          .node.key
                                                          .trim()
                                                          .split('\n');

                                                      final titlePoinName =
                                                          entry.node.poinName!
                                                              .trim()
                                                              .split('\n');

                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          poinBox,
                                                          Text(
                                                            titlePoinName[0],
                                                            style:
                                                                textStyleColorWhiteBI,
                                                          ),
                                                          for (int i = 0;
                                                              i <
                                                                  titleLines
                                                                      .length;
                                                              i++)
                                                            Text(
                                                              titleLines[i],
                                                              style:
                                                                  textStyleColorWhite,
                                                            ),
                                                        ],
                                                      );
                                                    } else {
                                                      // Untuk level 0 & 1 tetap seperti sebelumnya
                                                      return Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          decoration: (entry
                                                                          .level ==
                                                                      0 ||
                                                                  entry.level ==
                                                                      1)
                                                              ? BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white30,
                                                                  ),
                                                                )
                                                              : null,
                                                          child: RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            text: TextSpan(
                                                              style:
                                                                  textStyleColorWhite,
                                                              children: [
                                                                TextSpan(
                                                                  text: entry
                                                                      .node.key,
                                                                  style:
                                                                      textStyleColorWhite,
                                                                ),
                                                                if (entry.node
                                                                            .poin !=
                                                                        null &&
                                                                    entry.node
                                                                        .poin!
                                                                        .toString()
                                                                        .isNotEmpty) ...[
                                                                  const TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  WidgetSpan(
                                                                    alignment:
                                                                        PlaceholderAlignment
                                                                            .middle,
                                                                    child:
                                                                        FaIcon(
                                                                      FontAwesomeIcons
                                                                          .coins,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: ResponsiveValue<
                                                                          double>(
                                                                        context,
                                                                        conditionalValues: [
                                                                          const Condition
                                                                              .equals(
                                                                              name: TABLET,
                                                                              value: 14.0,
                                                                              landscapeValue: 14.0),
                                                                          const Condition
                                                                              .largerThan(
                                                                              name: TABLET,
                                                                              value: 17.0,
                                                                              landscapeValue: 17.0,
                                                                              breakpoint: 800),
                                                                        ],
                                                                        defaultValue:
                                                                            12.0,
                                                                      ).value,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        ' ${entry.node.poin!.toString()}',
                                                                    style:
                                                                        textStyleColorWhite,
                                                                  ),
                                                                ],
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                leading: entry.level == 2
                                                    ? null
                                                    : isExpanded
                                                        ? const FaIcon(
                                                            FontAwesomeIcons
                                                                .calendarMinus,
                                                            color: Colors.white,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: Colors.white,
                                                          ),
                                                onTap: () {
                                                  treeController
                                                      .toggleExpansion(
                                                    entry.node,
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  error: (err, stack) => Text('Error $err'),
                                  loading: () => const Center(
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Watermark(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
