import 'package:awas_ace/repositories/reminder_repositories.dart';
import 'package:awas_ace/widgets/model/reminderdetailmodel.dart';
import 'package:awas_ace/widgets/model/remindergetsalesmodel.dart';
import 'package:awas_ace/widgets/model/remindermodel.dart';
import 'package:awas_ace/widgets/model/sendtaskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderRepositoryProvider =
    Provider(<IReminderRepository>(ref) => ReminderRepositories());

//list stnk
final stnk = FutureProvider.autoDispose<ListReminderResponse>((ref) async {
  final repositoryStnk = ref.watch(reminderRepositoryProvider);
  return repositoryStnk.fecthListDataStnk();
});

//list birthday
final birthday = FutureProvider.autoDispose<ListReminderResponse>((ref) async {
  final repositoryBirthday = ref.watch(reminderRepositoryProvider);
  return repositoryBirthday.fecthListDataBirthday();
});

//list leasing berakhir
final leasingBerakhir =
    FutureProvider.autoDispose<ListReminderResponse>((ref) async {
  final repositoryLeasingBerakhir = ref.watch(reminderRepositoryProvider);
  return repositoryLeasingBerakhir.fecthListDataLeasingBerakhir();
});

//list reminder detail
final reminderDetail = FutureProvider.autoDispose
    .family<ListReminderDetailResponse, String>((ref, linkObj) async {
  final repositoryReminderDetail = ref.watch(reminderRepositoryProvider);
  return repositoryReminderDetail.fecthListDataReminderDetail(linkObj);
});

//update reminder
class UpdateReminderFormNotifier extends ChangeNotifier {
  UpdateReminderFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<UpdateReminderResponse> onUpdateReminder(
      ListReminderUpdate updateReminder) async {
    final repositoryreminder = ref.read(reminderRepositoryProvider);
    late UpdateReminderResponse resp;

    resp = await repositoryreminder.updateNewReminder(updateReminder);
    return resp;
  }
}

final updateReminderFormProviderDetail =
    ChangeNotifierProvider.autoDispose<UpdateReminderFormNotifier>((ref) {
  return UpdateReminderFormNotifier(ref as ProviderElementBase);
});

//list get sales
final getSales =
    FutureProvider.autoDispose<ListReminderGetSalesResponse>((ref) async {
  final repositoryGetSales = ref.watch(reminderRepositoryProvider);
  return repositoryGetSales.fecthListDataGetSales();
});

//update send task
class UpdateReminderSendTaskFormNotifier extends ChangeNotifier {
  UpdateReminderSendTaskFormNotifier(this.ref) : super();

  final ProviderElementBase ref;

  Future<SendTaskResponse> onUpdateReminderSendTask(
      ListSendTask upReminderSendTask) async {
    final repositorysendtask = ref.read(reminderRepositoryProvider);
    late SendTaskResponse resp;

    resp = await repositorysendtask.updateReminderSendTask(upReminderSendTask);
    return resp;
  }
}

final updateReminderSendTaskFormProvider =
    ChangeNotifierProvider.autoDispose<UpdateReminderSendTaskFormNotifier>(
        (ref) {
  return UpdateReminderSendTaskFormNotifier(ref as ProviderElementBase);
});
