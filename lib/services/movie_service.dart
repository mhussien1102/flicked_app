import 'package:flicked_app/services/http_services.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPServices http;

  MovieService() {
    http = getIt.get<HTTPServices>();
  }
}
