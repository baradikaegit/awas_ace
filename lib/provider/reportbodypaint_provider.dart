import 'package:awas_ace/repositories/reporbodypaint_repositories.dart';
import 'package:awas_ace/widgets/model/reportafterslsprospeksabpmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportBodyPaintRepositoryProvider = Provider(
  <IReportBodyPaintRepository>(ref) => ReportBodyPaintRepositories(),
);

//list report prospek sa BP
final reportProspekSaBP = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekSaBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaBP = ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekSaBP.fecthListDataProspekSaBP(linkPageObj);
  },
);

//list report prospek sa BP
final reportProspekSaBPBySAName = FutureProvider.autoDispose
    .family<ListRptBodyPaintProspekSaBPResponse, String>(
  (ref, linkPageObj) async {
    final repositoryProspekSaBPBySAName =
        ref.watch(reportBodyPaintRepositoryProvider);
    return repositoryProspekSaBPBySAName
        .fecthListDataProspekSaBPBySAName(linkPageObj);
  },
);
