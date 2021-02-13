import 'package:mobx/mobx.dart';
part 'LoginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {
      print(isFormValid);
    });
  }
  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isEmailValid => email.length >= 6;
  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;
}
