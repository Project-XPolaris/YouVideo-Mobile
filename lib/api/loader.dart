import 'base.dart';

abstract class ApiDataLoader<T> {
  List<T> list = [];
  bool firstLoad = true;
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int pageSize = 30;

  Future<bool> loadData(
      {Map<String, String> extraFilter = const {}, force = false}) async {
    if ((!firstLoad || isLoading || !hasMore) && !force) {
      return false;
    }
    firstLoad = false;
    isLoading = true;
    page = 1;
    pageSize = 30;
    Map<String, String> queryParams = {
      "page": page.toString(),
      "pageSize": pageSize.toString()
    };
    Map<String, String> params = new Map.from(queryParams);
    params.addAll(extraFilter);
    var response = await fetchData(params);
    list = response.result;
    hasMore = list.length < response.getTotal();
    page = page;
    pageSize = response.getPageSize();
    isLoading = false;
    return true;
  }

  Future<bool> loadMore({Map<String, String> extraFilter = const {}}) async {
    if (!hasMore || isLoading) {
      return false;
    }
    isLoading = true;
    Map<String, String> queryParams = {
      "page": (page + 1).toString(),
      "pageSize": pageSize.toString()
    };
    Map<String, String> params = new Map.from(queryParams);
    params.addAll(extraFilter);
    var response = await fetchData(params);
    list.addAll(response.result);
    hasMore = response.getPage() * response.getPageSize() < response.getTotal();
    page = response.getPage();
    pageSize = response.getPageSize();
    isLoading = false;
    return true;
  }

  Future<ListResponseWrap<T>> fetchData(Map<String, String> params);
}

abstract class ApiDataLoaderWithBaseResponse<T> {
  List<T> list = [];
  bool firstLoad = true;
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int pageSize = 30;

  Future<bool> loadData(
      {Map<String, String> extraFilter = const {}, force = false}) async {
    if ((!firstLoad || isLoading || !hasMore) && !force) {
      return false;
    }
    firstLoad = false;
    isLoading = true;
    page = 1;
    pageSize = 30;
    Map<String, String> queryParams = {
      "page": page.toString(),
      "pageSize": pageSize.toString()
    };
    Map<String, String> params = new Map.from(queryParams);
    params.addAll(extraFilter);
    var response = await fetchData(params);
    if (!response.success) {
      isLoading = false;
      throw Exception(response.err);
    }
    ListResponseWrap<T>? data = response.data;
    if (data == null) {
      isLoading = false;
      throw Exception("data is null");
    }
    list = data.result;
    hasMore = list.length < data.getTotal();
    page = page;
    pageSize = data.getPageSize();
    isLoading = false;
    return true;
  }

  Future<bool> loadMore({Map<String, String> extraFilter = const {}}) async {
    if (!hasMore || isLoading) {
      return false;
    }
    isLoading = true;
    Map<String, String> queryParams = {
      "page": (page + 1).toString(),
      "pageSize": pageSize.toString()
    };
    Map<String, String> params = new Map.from(queryParams);
    params.addAll(extraFilter);
    var response = await fetchData(params);
    if (!response.success) {
      isLoading = false;
      throw Exception(response.err);
    }
    ListResponseWrap<T>? data = response.data;
    if (data == null) {
      isLoading = false;
      throw Exception("data is null");
    }
    list.addAll(data.result);
    hasMore = data.getPage() * data.getPageSize() < data.getTotal();
    page = data.getPage();
    pageSize = data.getPageSize();
    isLoading = false;
    return true;
  }

  Future<BaseResponse<ListResponseWrap<T>>> fetchData(
      Map<String, String> params);
}
