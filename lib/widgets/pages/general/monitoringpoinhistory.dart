import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/repositories/repositories_history.dart';
import 'package:awas_ace/support/alert_dialog.dart';
import 'package:awas_ace/support/loading_animations.dart';
import 'package:awas_ace/support/not_active_token.dart';
import 'package:awas_ace/support/watermark.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:awas_ace/widgets/pages/general/MonitoringPoinTreeNode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MonitoringPoinHistoryPage extends StatefulWidget {
  final Object? linkPageObj;
  const MonitoringPoinHistoryPage({super.key, required this.linkPageObj});

  static const String routeName = "/monitoringPoinHistoryPage";
  @override
  State<MonitoringPoinHistoryPage> createState() =>
      _MonitoringPoinHistoryPageState();
}

class _MonitoringPoinHistoryPageState extends State<MonitoringPoinHistoryPage> {
  Widget titleBar = const Text(
    "Monitoring Poin",
    style: TextStyle(color: Colors.white),
  );

  // late TreeController<ListRptGeneralMonitoringPoinHistory> _treeController;
  // final List<ListRptGeneralMntPoinHistoryResponse> _treeData = [];

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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
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
              name: TABLET, value: 12.0, landscapeValue: 12.0),
          const Condition.largerThan(
              name: TABLET, value: 14.0, landscapeValue: 14.0, breakpoint: 800),
        ],
        defaultValue: 11.0,
      ).value,
      fontWeight: FontWeight.bold,
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
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    var linkPageObj = widget.linkPageObj.toString();

                    // final treeAsync =
                    //     ref.watch(reportMonitPoinHistory(linkPageObj));

                    final monitoringData = ref.watch(
                      monitoringPoinHistoryProvider(linkPageObj),
                    );
                    final treeController = ref.watch(
                      treeControllerProvider(linkPageObj),
                    );

                    return TreeView<ListRptGeneralMonitoringPoinHistory>(
                      treeController: treeController,
                      padding: const EdgeInsets.all(8),
                      nodeBuilder: (context, entry) {
                        return MonitoringPoinTreeNode(
                          entry: entry,
                          treeController: treeController,
                        );
                      },
                    );
                    // monitoringData.when(
                    //   loading: () =>
                    //       const Center(child: CircularProgressIndicator()),
                    //   error: (err, stack) => Center(child: Text("Error: $err")),
                    //   data: (data) {
                    //     if (data.listRptGeneralMonitoringPoinHistory == null ||
                    //         data.listRptGeneralMonitoringPoinHistory!.isEmpty) {
                    //       return const Center(child: Text("Tidak ada data"));
                    //     }

                    //     return Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: TreeView<ListRptGeneralMonitoringPoinHistory>(
                    //         treeController: treeController,
                    //         nodeBuilder: (context, entry) {
                    //           final node = entry.node;
                    //           return MyTreeTile(
                    //             title: Text(node.title),
                    //             subtitle: Text("Poin: ${node.poin}"),
                    //             trailing: entry.hasChildren
                    //                 ? Icon(entry.isExpanded
                    //                     ? Icons.expand_less
                    //                     : Icons.expand_more)
                    //                 : null,
                    //             onTap: () =>
                    //                 treeController.toggleExpansion(entry.node),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // );
                    // Center(
                    //   child: Stack(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           Expanded(
                    //             child: RefreshIndicator(
                    //               onRefresh: () async {
                    //                 return ref.refresh(
                    //                   reportMonitPoinHistory(linkPageObj),
                    //                 );
                    //               },
                    //               child: treeAsync.when(
                    //                 data: (nodes) {
                    //                   _treeData.clear();
                    //                   _treeData.add(nodes);

                    //                   // final treeController = TreeController<
                    //                   //     ListRptGeneralMonitoringPoinHistory>(
                    //                   //   roots: _treeData,
                    //                   //   childrenProvider: (node) =>
                    //                   //       node.children ?? [],
                    //                   // );

                    //                   // _treeController = TreeController<
                    //                   //     ListRptGeneralMonitoringPoinHistory>(
                    //                   //   roots: _treeData,
                    //                   //   childrenProvider: (node) =>
                    //                   //       node.children ?? [],
                    //                   // );

                    //                   return AnimatedTreeView<
                    //                       ListRptGeneralMonitoringPoinHistory>(
                    //                     treeController: _treeController,
                    //                     nodeBuilder: (context, entry) {
                    //                       return InkWell(
                    //                         onTap: () => _treeController
                    //                             .toggleExpansion(entry.node),
                    //                         child: TreeIndentation(
                    //                           entry: entry,
                    //                           child: ListTile(
                    //                             title: Text(entry.node.title),
                    //                           ),
                    //                         ),
                    //                       );
                    //                     },
                    //                   );
                    //                 },
                    //                 loading: () => const Center(
                    //                     child: CircularProgressIndicator()),
                    //                 error: (err, stack) =>
                    //                     Center(child: Text("Error: $err")),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // );
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
