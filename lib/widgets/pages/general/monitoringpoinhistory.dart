import 'package:awas_ace/provider/reportgeneral_provider.dart';
import 'package:awas_ace/repositories/repositories_history.dart';
import 'package:awas_ace/support/loading_animations.dart';
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

                    final treeData = ref.watch(
                      monitoringPoinHistoryProvider(linkPageObj),
                    );

                    return treeData.when(
                      data: (data) => _buildTreeView(ref, linkPageObj),
                      error: (err, stack) => Text('Error $err'),
                      loading: () => const Center(
                        child: Column(
                          children: [loadingAnimation()],
                        ),
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

  Widget _buildTreeView(WidgetRef ref, String linkPageObj) {
    final treeController = ref.watch(treeControllerProvider(linkPageObj));
    return TreeView(
      treeController: treeController,
      nodeBuilder: (context, entry) {
        return MyTreeTile(
          key: ValueKey(entry.node),
          entry: entry,
          onTap: () => ref
              .read(treeControllerProvider(linkPageObj).notifier)
              .toggleNode(entry.node),
        );
      },
    );
  }
}

class MyTreeTile extends StatelessWidget {
  const MyTreeTile({super.key, required this.entry, required this.onTap});

  final TreeEntry<ListRptGeneralMonitoringPoinHistory> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TreeIndentation(
        entry: entry,
        guide: const IndentGuide.connectingLines(indent: 48),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              IconButton(
                onPressed: entry.hasChildren ? onTap : null,
                icon: entry.hasChildren
                    ? const Icon(Icons.calendar_month)
                    : const FaIcon(FontAwesomeIcons.coins),
                selectedIcon: const FaIcon(FontAwesomeIcons.calendarMinus),
              ),
              Text(entry.node.title),
            ],
          ),
        ),
      ),
    );
  }
}
