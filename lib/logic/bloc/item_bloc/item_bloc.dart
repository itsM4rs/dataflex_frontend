import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/item_model.dart';
import '../../../data/repositories/item_repo.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;
  ItemBloc({this.itemRepository}) : super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is GetItems) {
      yield ItemLoading();
      try {
        final itemsList = await itemRepository.fetchItemsList(event.id);

        if (itemsList == null) {
          yield ItemError(message: "Error occured");
        } else {
          yield ItemLoaded(items: itemsList);
        }
      } catch (e) {
        yield ItemError(message: e.toString());
      }
    }
  }
}
