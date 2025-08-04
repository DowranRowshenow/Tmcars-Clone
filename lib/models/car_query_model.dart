// TODO: Add full query arguments
class CarQuery {
  int? offset;
  int? max;
  String? mask;
  String? order;
  String? sort;
  String? lang;
  CarQuery({
    this.offset,
    this.mask,
    this.order,
    this.sort,
    this.lang,
    this.max,
  });

  Map<String, String> map() {
    Map<String, String> map = <String, String>{};
    if (max != null) {
      map['max'] = max.toString();
    }
    if (offset != null) {
      map['offset'] = offset.toString();
    }
    if (mask != null) {
      map['mask'] = mask!;
    }
    if (order != null) {
      map['order'] = order!;
    }
    if (sort != null) {
      map['sort'] = sort!;
    }
    if (lang != null) {
      map['lang'] = lang!;
    }
    return map;
  }
}
