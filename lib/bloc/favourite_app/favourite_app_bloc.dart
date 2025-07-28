import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v9/bloc/favourite_app/favourite_app_event.dart';
import 'package:v9/bloc/favourite_app/favourite_app_state.dart';

import '../../model/favourite_item_model.dart';
import '../../repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvents, FavouriteItemStates> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> temFavouriteList = [];

  FavouriteRepository favouriteRepository;

  FavouriteBloc(this.favouriteRepository) : super(FavouriteItemStates()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem>(_deleteItem);
  }

  void fetchList(
    FetchFavouriteList event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.suceess,
      ),
    );
  }

  void _addFavouriteItem(
    FavouriteItem event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    final index = favouriteList.indexWhere(
      (element) => element.id == event.item.id,
    );

    if (event.item.isFavourite) {
      if (temFavouriteList.contains(favouriteList[index])) {
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
      ;
    } else {
      if (temFavouriteList.contains(favouriteList[index])) {
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
      ;
    }

    favouriteList[index] = event.item;
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        temFavouriteItemList: List.from(temFavouriteList),
      ),
    );
  }

  void _selectItem(SelectItem event, Emitter<FavouriteItemStates> emit) async {
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _unSelectItem(
    UnSelectItem event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    temFavouriteList.remove(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteItemStates> emit) async {
    for (int i = 0; i < temFavouriteList.length; i++) {
      favouriteList.remove(temFavouriteList[i]);
    }
    temFavouriteList.clear();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        temFavouriteItemList: List.from(temFavouriteList),
      ),
    );
  }
}
