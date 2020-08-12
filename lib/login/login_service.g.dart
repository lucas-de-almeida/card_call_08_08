// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginService on _LoginServiceBase, Store {
  final _$listaCardsAtom = Atom(name: '_LoginServiceBase.listaCards');

  @override
  ObservableList<Cards> get listaCards {
    _$listaCardsAtom.reportRead();
    return super.listaCards;
  }

  @override
  set listaCards(ObservableList<Cards> value) {
    _$listaCardsAtom.reportWrite(value, super.listaCards, () {
      super.listaCards = value;
    });
  }

  final _$deletaCardAsyncAction = AsyncAction('_LoginServiceBase.deletaCard');

  @override
  Future<void> deletaCard(int id) {
    return _$deletaCardAsyncAction.run(() => super.deletaCard(id));
  }

  final _$editarCardAsyncAction = AsyncAction('_LoginServiceBase.editarCard');

  @override
  Future<void> editarCard(Cards card) {
    return _$editarCardAsyncAction.run(() => super.editarCard(card));
  }

  final _$salvarCardAsyncAction = AsyncAction('_LoginServiceBase.salvarCard');

  @override
  Future<void> salvarCard(Cards card) {
    return _$salvarCardAsyncAction.run(() => super.salvarCard(card));
  }

  final _$_LoginServiceBaseActionController =
      ActionController(name: '_LoginServiceBase');

  @override
  List<Cards> buscaLista() {
    final _$actionInfo = _$_LoginServiceBaseActionController.startAction(
        name: '_LoginServiceBase.buscaLista');
    try {
      return super.buscaLista();
    } finally {
      _$_LoginServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaCards: ${listaCards}
    ''';
  }
}
