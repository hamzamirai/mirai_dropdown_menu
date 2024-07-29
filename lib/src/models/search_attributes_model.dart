/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
class SearchAttributes<T> {
  List<T> searchList;
  bool showHighLight;
  String mQueryClient;

  SearchAttributes({
    this.searchList = const [],
    this.showHighLight = false,
    this.mQueryClient = '',
  });
}
