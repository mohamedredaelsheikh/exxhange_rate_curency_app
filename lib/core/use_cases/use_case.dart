import 'package:dartz/dartz.dart';
import 'package:exchange_rate_currency_app/core/errors/failures.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
