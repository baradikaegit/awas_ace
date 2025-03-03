import 'package:awas_ace/repositories/reportgeneral_repositories.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportGeneralRepositoryProvider = Provider(
  <IReportGeneralRepository>(ref) => ReportGeneralRepositories(),
);

//list report monitoring poin
final reportMonitPoin =
    FutureProvider.autoDispose<ListRptGeneralMntPoinResponse>(
  (ref) async {
    final repositoryMonitPoin = ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitPoin.fecthListDataMonitoringPoin();
  },
);

//list report monitoring poin by ss
final reportMonitPoinBySS =
    FutureProvider.autoDispose.family<ListRptGeneralMntPoinResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitPoinBySS = ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitPoinBySS.fecthListDataMonitoringPoinBySS(linkPageObj);
  },
);

//list report monitoring poin by sales
final reportMonitPoinBySales =
    FutureProvider.autoDispose.family<ListRptGeneralMntPoinResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitPoinBySales =
        ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitPoinBySales
        .fecthListDataMonitoringPoinBySales(linkPageObj);
  },
);
