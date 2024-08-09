import 'package:awas_ace/repositories/targetsales_repositories.dart';
import 'package:awas_ace/widgets/model/targetsalesmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final targetSalesRepositoryProvider =
    Provider(<ITargetSalesRepository>(ref) => TargetSalesRepositories());

//list prospect uebp
final targetSalesList =
    FutureProvider.autoDispose<ListTargetSalesResponse>((ref) async {
  final repository = ref.watch(targetSalesRepositoryProvider);
  return repository.fecthListData();
});
