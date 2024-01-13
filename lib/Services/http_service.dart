class NetWorkService {
  static final NetWorkService _instance = NetWorkService._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory NetWorkService() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  NetWorkService._internal() {
    // initialization logic
  }

  // rest of class as normal, for example:
  Future<void> postMethod() async {
    /*
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
    */
  }
}

final NetWorkService netWorkService = NetWorkService();
