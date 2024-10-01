import 'package:awas_ace/repositories/reportsales_repositories.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospekvsmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospeuebpmodel.dart';
import 'package:awas_ace/widgets/model/reportslstargetslsactmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportSalesRepositoryProvider =
    Provider(<IReportSalesRepository>(ref) => ReportSalesRepositories());

//list report funneling
final reportFunnelingList = FutureProvider.autoDispose
    .family<ListRptFunnelingResponse, String>((ref, linkPageObj) async {
  final repository = ref.watch(reportSalesRepositoryProvider);
  return repository.fecthListData(linkPageObj);
});

//list report funneling detail ss
final reportFunnelingBySSList = FutureProvider.autoDispose
    .family<ListRptFunnelingDetailResponse, String>((ref, linkPageObj) async {
  final repository = ref.watch(reportSalesRepositoryProvider);
  return repository.fecthListDataBySS(linkPageObj);
});

//list report funneling detail sales
final reportFunnelingBySalesList = FutureProvider.autoDispose
    .family<ListRptFunnelingDetailResponse, String>((ref, linkPageObj) async {
  final repositorySales = ref.watch(reportSalesRepositoryProvider);
  return repositorySales.fecthListDataBySales(linkPageObj);
});

//list report funneling detail sales date
final reportFunnelingBySalesDetailList = FutureProvider.autoDispose
    .family<ListRptFunnelingDetailResponse, String>((ref, linkPageObj) async {
  final repositorySalesDtl = ref.watch(reportSalesRepositoryProvider);
  return repositorySalesDtl.fecthListDataBySalesDetail(linkPageObj);
});

//list report prospek valid spk
final reportProspekVspk = FutureProvider.autoDispose
    .family<ListRptProspekVsResponse, String>((ref, linkPageObj) async {
  final repositoryProspekVspk = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekVspk.fecthListDataProspekVs(linkPageObj);
});

//list report prospek valid spk by ss
final reportProspekVspkBySS = FutureProvider.autoDispose
    .family<ListRptProspekVsResponse, String>((ref, linkPageObj) async {
  final repositoryProspekVspkBySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekVspkBySS.fecthListDataProspekVsBySS(linkPageObj);
});

//list report prospek valid spk by sales
final reportProspekVspkBySales = FutureProvider.autoDispose
    .family<ListRptProspekVsResponse, String>((ref, linkPageObj) async {
  final repositoryProspekVspkBySales = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekVspkBySales
      .fecthListDataProspekVsBySales(linkPageObj);
});

//list report prospek uebp
final reportProspekUeBP = FutureProvider.autoDispose
    .family<ListRptProspekUeBpResponse, String>((ref, linkPageObj) async {
  final repositoryProspekUeBP = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekUeBP.fecthListDataProspekUeBP(linkPageObj);
});

//list report prospek uebp by ss
final reportProspekUeBPBySS = FutureProvider.autoDispose
    .family<ListRptProspekUeBpResponse, String>((ref, linkPageObj) async {
  final repositoryProspekUeBPBySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekUeBPBySS.fecthListDataProspekUeBPBySS(linkPageObj);
});

//list report prospek uebp by sales
final reportProspekUeBPBySales = FutureProvider.autoDispose
    .family<ListRptProspekUeBpResponse, String>((ref, linkPageObj) async {
  final repositoryProspekUeBPBySales = ref.watch(reportSalesRepositoryProvider);
  return repositoryProspekUeBPBySales
      .fecthListDataProspekUeBPBySales(linkPageObj);
});

//list report target sales actual
final reportTargetSalesActual = FutureProvider.autoDispose
    .family<ListRptTSalesActualResponse, String>((ref, linkPageObj) async {
  final repositoryTSalesActual = ref.watch(reportSalesRepositoryProvider);
  return repositoryTSalesActual.fecthListDataTSalesActual(linkPageObj);
});
