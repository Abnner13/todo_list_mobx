import 'package:mobx/mobx.dart';
part 'LoginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {
      print('Senha visivel: $visiblePasswords');
    });
  }
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool visiblePasswords = false;

  @observable
  bool loading = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setVisiblePasswords() => visiblePasswords = !visiblePasswords;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));

    loading = false;
  }

  @computed
  bool get isEmailValid => email.length >= 6;
  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  Function get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;
}
