import 'package:awas_ace/repositories/reportaftersales_repositories.dart';
import 'package:awas_ace/widgets/model/reportafterslsboccaibypicbookingmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsbookingtoshowmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsfunnelingmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospekgruebpmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksagrmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslstmsproductivitymodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportAfterSlsRepositoryProvider = Provider(
  <IReportAfterSalesRepository>(ref) => ReportAfterSalesRepositories(),
);

//list report prospek sa gr
final reportProspekSaGR = FutureProvider.autoDispose
    .family<ListRptAfterSlsProspekSaGRResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaGR = ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryProspekSaGR.fecthListDataProspekSaGR(linkPageObj);
  },
);

//list report prospek sa gr by saname
final reportProspekSaGRBySAName = FutureProvider.autoDispose
    .family<ListRptAfterSlsProspekSaGRResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaGRBySAName =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryProspekSaGRBySAName
        .fecthListDataProspekSaGRBySAName(linkPageObj);
  },
);

//list report prospek gr to uebp
final reportProspekGRUeBP = FutureProvider.autoDispose
    .family<ListRptAfterSlsProspekGRUeBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekUeBP = ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryProspekUeBP.fecthListDataProspekGRtoUeBP(linkPageObj);
  },
);

//list report prospek gr to uebp by saname
final reportProspekGRUeBPBySAName = FutureProvider.autoDispose
    .family<ListRptAfterSlsProspekGRUeBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekUeBPBySAName =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryProspekUeBPBySAName
        .fecthListDataProspekGRtoUeBPBySAName(linkPageObj);
  },
);

//list report tms productivity
final reportTMSProductivity = FutureProvider.autoDispose
    .family<ListRptAfterSlsTMSPRoductivityResponse, String>(
  (ref, linkPageObj) async {
    final repositoryTMSProductivity =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryTMSProductivity.fecthListDataTMSProductivity(linkPageObj);
  },
);

//list report booking to show
final reportBookingToShow = FutureProvider.autoDispose
    .family<ListRptAfterSlsBookingToShowResponse, String>(
  (ref, linkPageObj) async {
    final repositoryBookingToShow = ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryBookingToShow.fecthListDataBookingToShow(linkPageObj);
  },
);

//list report funneling
final reportFunneling =
    FutureProvider.autoDispose.family<ListRptAfterSlsFunnelingResponse, String>(
  (ref, linkPageObj) async {
    final repositoryFunneling = ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryFunneling.fecthListDataFunneling(linkPageObj);
  },
);

//list report funneling by branch
final reportFunnelingByBranch =
    FutureProvider.autoDispose.family<ListRptAfterSlsFunnelingResponse, String>(
  (ref, linkPageObj) async {
    final repositoryFunnelingByBranch =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryFunnelingByBranch
        .fecthListDataFunnelingByBranch(linkPageObj);
  },
);

//list report funneling by actual
final reportFunnelingByActual =
    FutureProvider.autoDispose.family<ListRptAfterSlsFunnelingResponse, String>(
  (ref, linkPageObj) async {
    final repositoryFunnelingByActual =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryFunnelingByActual
        .fecthListDataFunnelingByActual(linkPageObj);
  },
);

//list report boc cai by pic booking
final reportBocCaiByPicBooking = FutureProvider.autoDispose
    .family<ListRptSalesBocCaiByPICBookingResponse, String>(
  (ref, linkPageObj) async {
    final repositoryBocCaiByPicBooking =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryBocCaiByPicBooking
        .fecthListDataBocCaiByPicBooking(linkPageObj);
  },
);
