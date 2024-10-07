import 'package:awas_ace/repositories/reportsales_repositories.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospekvsmodel.dart';
import 'package:awas_ace/widgets/model/reportslsprospeuebpmodel.dart';
import 'package:awas_ace/widgets/model/reportslsstockmodel.dart';
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

//list report target sales actual by ss
final reportTargetSalesActualBySS = FutureProvider.autoDispose
    .family<ListRptTSalesActualResponse, String>((ref, linkPageObj) async {
  final repositoryTSalesActualBySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryTSalesActualBySS.fecthListDataTSalesActualBySS(linkPageObj);
});

//list report target sales actual by sales
final reportTargetSalesActualBySales = FutureProvider.autoDispose
    .family<ListRptTSalesActualResponse, String>((ref, linkPageObj) async {
  final repositoryTSalesActualBySales =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryTSalesActualBySales
      .fecthListDataTSalesActualBySales(linkPageObj);
});

//list report stock by model
final reportStockByModel =
    FutureProvider.autoDispose<ListRptStockByModelResponse>((ref) async {
  final repositoryStockByModel = ref.watch(reportSalesRepositoryProvider);
  return repositoryStockByModel.fecthListDataStockByModel();
});

//list report stock by model vtype
final reportStockByModelVtype = FutureProvider.autoDispose
    .family<ListRptStockByModelResponse, String>((ref, linkPageObj) async {
  final repositoryStockByModelVtype = ref.watch(reportSalesRepositoryProvider);
  return repositoryStockByModelVtype
      .fecthListDataStockByModelVtype(linkPageObj);
});

//list report stock by model vcolor
final reportStockByModelVcolor = FutureProvider.autoDispose
    .family<ListRptStockByModelResponse, String>((ref, linkPageObj) async {
  final repositoryStockByModelVcolor = ref.watch(reportSalesRepositoryProvider);
  return repositoryStockByModelVcolor
      .fecthListDataStockByModelVcolor(linkPageObj);
});

//list report stock by model vbranch
final reportStockByModelVbranch = FutureProvider.autoDispose
    .family<ListRptStockByModelResponse, String>((ref, linkPageObj) async {
  final repositoryStockByModelVbranch =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryStockByModelVbranch
      .fecthListDataStockByModelVbranch(linkPageObj);
});
