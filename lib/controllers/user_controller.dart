import 'package:mobx/mobx.dart';
part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  bool isLogged = false;

  @action
  bool checkIsLogged() {
    return isLogged;
  }

  @action
  void setIsLogged(bool value) {
    isLogged = value;
  }
}
