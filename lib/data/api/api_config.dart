abstract class ApiConfig {
  static Map<dynamic, String> api = {
    'logout': 'user/',
    'login': 'api/users/authenticate',
    'checkVersion': 'api/checkVersion',
  };
}
