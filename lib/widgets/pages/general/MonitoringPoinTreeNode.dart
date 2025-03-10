import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class MonitoringPoinTreeNode extends StatelessWidget {
  final TreeEntry<ListRptGeneralMonitoringPoinHistory> entry;
  final TreeController<ListRptGeneralMonitoringPoinHistory> treeController;

  const MonitoringPoinTreeNode({
    super.key,
    required this.entry,
    required this.treeController,
  });

  @override
  Widget build(BuildContext context) {
    final node = entry.node;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        key: ValueKey(entry.node),
        leading: entry.hasChildren
            ? Icon(entry.isExpanded ? Icons.folder_open : Icons.folder)
            : const Icon(Icons.insert_drive_file),
        title: Text(
          node.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Poin: ${node.poin}"),
        trailing: entry.hasChildren
            ? IconButton(
                icon: Icon(
                    entry.isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () => treeController.toggleExpansion(node),
              )
            : null,
        onTap: () => treeController.toggleExpansion(node),
      ),
    );
  }
}
