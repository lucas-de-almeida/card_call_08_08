// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListController on _ListControllerBase, Store {
  final _$listaCardsAtom = Atom(name: '_ListControllerBase.listaCards');

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

  final _$deletaCardAsyncAction = AsyncAction('_ListControllerBase.deletaCard');

  @override
  Future<void> deletaCard(int id) {
    return _$deletaCardAsyncAction.run(() => super.deletaCard(id));
  }

  final _$editarCardAsyncAction = AsyncAction('_ListControllerBase.editarCard');

  @override
  Future<void> editarCard(Cards card) {
    return _$editarCardAsyncAction.run(() => super.editarCard(card));
  }

  final _$salvarCardAsyncAction = AsyncAction('_ListControllerBase.salvarCard');

  @override
  Future<void> salvarCard(Cards card) {
    return _$salvarCardAsyncAction.run(() => super.salvarCard(card));
  }

  final _$_ListControllerBaseActionController =
      ActionController(name: '_ListControllerBase');

  @override
  List<Cards> buscaLista() {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.buscaLista');
    try {
      return super.buscaLista();
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaCards: ${listaCards}
    ''';
  }
}
