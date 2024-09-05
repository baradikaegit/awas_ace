import 'package:awas_ace/repositories/reportsales_repositories.dart';
import 'package:awas_ace/widgets/model/reportslsfunneling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportSalesRepositoryProvider =
    Provider(<IReportSalesRepository>(ref) => ReportSalesRepositories());

//list report funneling
final reportFunnelingList = FutureProvider.autoDispose
    .family<ListRptFunnelingResponse, String>((ref, linkPageObj) async {
  final repository = ref.watch(reportSalesRepositoryProvider);
  return repository.fecthListData(linkPageObj);
});
