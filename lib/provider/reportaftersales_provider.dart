import 'package:awas_ace/repositories/reportaftersales_repositories.dart';
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

//list report prospek sa gr
final reportProspekSaGRBySAName = FutureProvider.autoDispose
    .family<ListRptAfterSlsProspekSaGRResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaGRBySAName =
        ref.watch(reportAfterSlsRepositoryProvider);
    return repositoryProspekSaGRBySAName
        .fecthListDataProspekSaGRBySAName(linkPageObj);
  },
);
