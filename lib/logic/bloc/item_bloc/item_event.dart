part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class GetItems extends ItemEvent {
  final int id;

  GetItems({@required this.id});

  @override
  List<Object> get props => [id];
}
