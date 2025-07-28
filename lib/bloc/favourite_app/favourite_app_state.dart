import 'package:equatable/equatable.dart';
import 'package:v9/model/favourite_item_model.dart';

enum ListStatus {loading, suceess, failure}

class FavouriteItemStates extends Equatable {

  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> temFavouriteItemList;

  final ListStatus listStatus;
  FavouriteItemStates({
    this.favouriteItemList = const [],
    this.temFavouriteItemList = const [],
    this.listStatus = ListStatus.loading
});

  FavouriteItemStates  copyWith({
    List<FavouriteItemModel>? favouriteItemList,
    List<FavouriteItemModel>? temFavouriteItemList,
    ListStatus? listStatus,
  }){
    return FavouriteItemStates(
    favouriteItemList: favouriteItemList ?? this.favouriteItemList,
        temFavouriteItemList: temFavouriteItemList ?? this.temFavouriteItemList,
    listStatus:  listStatus ?? this.listStatus

    );
}

  @override
  List<Object?> get props => [favouriteItemList, temFavouriteItemList, listStatus];

}
