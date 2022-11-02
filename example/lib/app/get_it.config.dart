// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/authentication/services/firebase_refresh_service.dart'
    as _i4;
import '../features/authentication/services/firebase_service.dart' as _i5;
import '../features/authentication/services/user_service.dart' as _i6;
import '../features/shared/services/app_service.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppService>(_i3.AppService());
  gh.singleton<_i4.FirebaseRefreshService>(_i4.FirebaseRefreshService());
  gh.factory<_i5.FirebaseService>(() => _i5.FirebaseService());
  gh.singleton<_i6.UserService>(_i6.UserService());
  return get;
}
