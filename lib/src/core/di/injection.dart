import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  initializerName: r"$initGetIt",
)
Future<void> configureDependencies() async => $initGetIt(getIt);
