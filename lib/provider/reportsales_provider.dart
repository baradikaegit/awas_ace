import 'package:awas_ace/repositories/reportsales_repositories.dart';
import 'package:awas_ace/widgets/model/reportslsdotogatepassmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportslsfunnelingdetailmodel.dart';
import 'package:awas_ace/widgets/model/reportslsgatepasstosbimodel.dart';
import 'package:awas_ace/widgets/model/reportslsmonitoringfoapmamodel.dart';
import 'package:awas_ace/widgets/model/reportslsmonitoringmodel.dart';
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

//list report do to gatepass
final reportDoToGatepass = FutureProvider.autoDispose
    .family<ListRptDoToGatepassResponse, String>((ref, linkPageObj) async {
  final repositoryDoToGatepass = ref.watch(reportSalesRepositoryProvider);
  return repositoryDoToGatepass.fecthListDataDotoGatepass(linkPageObj);
});

//list report do to gatepass by ss
final reportDoToGatepassBySS = FutureProvider.autoDispose
    .family<ListRptDoToGatepassResponse, String>((ref, linkPageObj) async {
  final repositoryDoToGatepassBySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryDoToGatepassBySS.fecthListDataDotoGatepassBySS(linkPageObj);
});

//list report do to gatepass by sales
final reportDoToGatepassBySales = FutureProvider.autoDispose
    .family<ListRptDoToGatepassResponse, String>((ref, linkPageObj) async {
  final repositoryDoToGatepassBySales =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryDoToGatepassBySales
      .fecthListDataDotoGatepassBySales(linkPageObj);
});

//list report gatepass to sbi
final reportGatepasstoSBI = FutureProvider.autoDispose
    .family<ListRptGatepassToSbiResponse, String>((ref, linkPageObj) async {
  final repositoryGatepasstoSBI = ref.watch(reportSalesRepositoryProvider);
  return repositoryGatepasstoSBI.fecthListDataGatepasstoSBI(linkPageObj);
});

//list report gatepass to sbi by ss
final reportGatepasstoSBIBySS = FutureProvider.autoDispose
    .family<ListRptGatepassToSbiResponse, String>((ref, linkPageObj) async {
  final repositoryGatepasstoSBIBySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryGatepasstoSBIBySS
      .fecthListDataGatepasstoSBIBySS(linkPageObj);
});

//list report gatepass to sbi by sales
final reportGatepasstoSBIBySales = FutureProvider.autoDispose
    .family<ListRptGatepassToSbiResponse, String>((ref, linkPageObj) async {
  final repositoryGatepasstoSBIBySales =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryGatepasstoSBIBySales
      .fecthListDataGatepasstoSBIBySales(linkPageObj);
});

//list report monitoring vol & profit maker
final reportMonitoringVolProfitMaker = FutureProvider.autoDispose
    .family<ListMonitroingVolProfitMakerResponse, String>(
        (ref, linkPageObj) async {
  final repositoryMonitoringVolProfitMaker =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryMonitoringVolProfitMaker
      .fecthListDataMonitoringVolProfitMaker(linkPageObj);
});

//list report monitoring vol & profit maker detail
final reportMonitoringVolProfitMakerDetail = FutureProvider.autoDispose
    .family<ListMonitroingVolProfitMakerResponse, String>(
        (ref, linkPageObj) async {
  final repositoryMonitVolProfitMakerDetail =
      ref.watch(reportSalesRepositoryProvider);
  return repositoryMonitVolProfitMakerDetail
      .fecthListDataMonitoringVolProfitMakerDetail(linkPageObj);
});

//list report monitoring foa pma
final reportMonitoringFoaPMA = FutureProvider.autoDispose
    .family<ListMonitroingFoaPMAResponse, String>((ref, linkPageObj) async {
  final repositoryMonitFoaPMA = ref.watch(reportSalesRepositoryProvider);
  return repositoryMonitFoaPMA.fecthListDataMonitoringFoaPMA(linkPageObj);
});

//list report monitoring foa pma by ss
final reportMonitoringFoaPMABySS = FutureProvider.autoDispose
    .family<ListMonitroingFoaPMAResponse, String>((ref, linkPageObj) async {
  final repositoryMonitFoaPMABySS = ref.watch(reportSalesRepositoryProvider);
  return repositoryMonitFoaPMABySS
      .fecthListDataMonitoringFoaPMABySS(linkPageObj);
});

//list report monitoring foa pma by sales
final reportMonitoringFoaPMABySls = FutureProvider.autoDispose
    .family<ListMonitroingFoaPMAResponse, String>((ref, linkPageObj) async {
  final repositoryMonitFoaPMABySls = ref.watch(reportSalesRepositoryProvider);
  return repositoryMonitFoaPMABySls
      .fecthListDataMonitoringFoaPMABySls(linkPageObj);
});
