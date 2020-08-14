import 'package:card_agora_vai/entities/cards.dart';
import 'package:card_agora_vai/service/network_help.dart';
import 'package:mobx/mobx.dart';
part 'list_controller.g.dart';

class ListController = _ListControllerBase with _$ListController;

abstract class _ListControllerBase with Store {
  var networkHelper = NetworkHelper();

  @observable
  ObservableList<Cards> listaCards = ObservableList.of([]);

  /*  @observable
  bool _isLoading = false;
  @action
  isLoading() => _isLoading;

  @action
  isLoadingTrue() => _isLoading = true;
  @action
  isLoadingFalse() => _isLoading = false; */

  @action
  List<Cards> buscaLista() {
    networkHelper.buscaLista().then((value) {
      print('ESSE É P VALUE ===> $value');
      listaCards = value.asObservable();
    });
    return listaCards;
  }

  /* @action
  List<Cards> buscaListaLogged(BuildContext context) {
    networkHelper.buscaLista().then((value) {
      print(value);
      listaCards = value.asObservable();
    });
    return listaCards;
  } */

  @action
  Future<void> deletaCard(int id) async {
    await networkHelper.deletaCard(id);
    await Future.delayed(Duration(seconds: 3));
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

  @action
  void setToken(String token) {
    networkHelper.tokkenSetter(token);
  }
}
