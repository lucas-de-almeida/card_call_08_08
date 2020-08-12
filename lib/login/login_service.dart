import 'package:card_agora_vai/entities/cards.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:mobx/mobx.dart';
part 'login_service.g.dart';

class LoginService = _LoginServiceBase with _$LoginService;

abstract class _LoginServiceBase with Store {
  var networkHelper = NetworkHelper();

  @observable
  ObservableList<Cards> listaCards = ObservableList.of([]);

  @action
  List<Cards> buscaLista() {
    networkHelper.buscaLista().then((value) {
      print(value);
      listaCards = value.asObservable();
    });
    return listaCards;
  }

  @action
  Future<void> deletaCard(int id) async {
    await networkHelper.deletaCard(id);
    networkHelper.buscaLista();
  }

  @action
  Future<void> editarCard(Cards card) async {
    await networkHelper.editarCard(card);
    networkHelper.buscaLista();
  }

  @action
  Future<void> salvarCard(Cards card) async {
    await networkHelper.salvarCard(card);
    networkHelper.buscaLista();
  }
}
