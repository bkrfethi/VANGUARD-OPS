import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/core/usecases/usecases.dart';
import 'package:vanguard_ops/domain/alert/repository/alert_repository.dart';
import 'package:vanguard_ops/service_loacator.dart';
class CancelAlertUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<AlertRepository>().cancelAlert(params!);
  }
}