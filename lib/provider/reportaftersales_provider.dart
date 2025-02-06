import 'package:awas_ace/repositories/reportaftersales_repositories.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospekgruebpmodel.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksagrmodel.dart';
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
