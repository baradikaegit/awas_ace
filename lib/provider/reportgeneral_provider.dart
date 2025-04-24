import 'package:awas_ace/repositories/reportgeneral_repositories.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinhistorymodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntpoinmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntredeemmodel.dart';
import 'package:awas_ace/widgets/model/reportgeneralmntsaldomodel.dart';
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

//list report monitoring poin by svc
final reportMonitPoinBySvc =
    FutureProvider.autoDispose.family<ListRptGeneralMntPoinResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitPoinBySvc = ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitPoinBySvc
        .fecthListDataMonitoringPoinBySvc(linkPageObj);
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

//list report monitoring redeem
final reportMonitRedeem =
    FutureProvider.autoDispose<ListRptGeneralMntRedeemResponse>(
  (ref) async {
    final repositoryMonitRedeem = ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitRedeem.fecthListDataMonitoringRedeem();
  },
);

//list report monitoring redeem by ss
final reportMonitRedeemBySS =
    FutureProvider.autoDispose.family<ListRptGeneralMntRedeemResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitRedeemBySS =
        ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitRedeemBySS
        .fecthListDataMonitoringRedeemBySS(linkPageObj);
  },
);

//list report monitoring redeem by sales
final reportMonitRedeemBySales =
    FutureProvider.autoDispose.family<ListRptGeneralMntRedeemResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitRedeemBySales =
        ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitRedeemBySales
        .fecthListDataMonitoringRedeemBySales(linkPageObj);
  },
);

//list report monitoring saldo
final reportMonitSaldo =
    FutureProvider.autoDispose<ListRptGeneralMntSaldoResponse>(
  (ref) async {
    final repositoryMonitSaldo = ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitSaldo.fecthListDataMonitoringSaldo();
  },
);

//list report monitoring history
final reportMonitPoinHistory = FutureProvider.autoDispose
    .family<ListRptGeneralMntPoinHistoryResponse, String>(
  (ref, linkPageObj) async {
    final repositoryMonitPoinHistory =
        ref.watch(reportGeneralRepositoryProvider);
    return repositoryMonitPoinHistory
        .fecthListDataMonitoringPoinHistory(linkPageObj);
  },
);
