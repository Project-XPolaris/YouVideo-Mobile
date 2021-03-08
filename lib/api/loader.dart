import 'base.dart';

abstract class ApiDataLoader<T> {
  List<T> list = [];
  bool firstLoad = true;
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int pageSize = 20;

  Future<bool> loadData({Map<String,String> extraFilter,force = false}) async{
    print(force);
    if ((!firstLoad || isLoading || !hasMore) && !force){
      return false;
    }
    firstLoad = false;
    isLoading = true;
    page = 1;
    pageSize = 20;
    Map<String,String> queryParams = {
      "page":page.toString(),
      "pageSize":pageSize.toString()
    };
    Map<String,String> params = new Map.from(queryParams);
    if (extraFilter != null) {
      params.addAll(extraFilter);
    }
    var response = await fetchData(params);

    list = response.result;
    hasMore = list.length < response.count;
    page = response.page;
    pageSize = response.pageSize;
    isLoading = false;
    return true;
  }

  Future<bool> loadMore({Map<String,String> extraFilter}) async{
    if (!hasMore){
      return false;
    }
    isLoading = true;
    Map<String,String> queryParams = {
      "page":(page + 1).toString(),
      "pageSize":pageSize.toString()
    };
    Map<String,String> params = new Map.from(queryParams);
    if (extraFilter != null) {
      params.addAll(extraFilter);
    }
    var response = await fetchData(params);
    list.addAll(response.result);
    hasMore = response.page * response.pageSize < response.count;
    page = response.page;
    pageSize = response.pageSize;

    isLoading = false;
    return true;
  }
  Future<ListResponseWrap<T>> fetchData(Map<String,String> params);
}