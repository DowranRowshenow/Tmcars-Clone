// TODO: Add full query arguments
class CarQuery {
  int? filterId;
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
    this.filterId,
  });

  CarQuery copyWith({
    int? filterId, // Added filterId as an optional parameter
    int? offset,
    int? max,
    String? mask,
    String? order,
    String? sort,
    String? lang,
  }) {
    return CarQuery(
      filterId: filterId ?? this.filterId, // Handle filterId
      offset: offset ?? this.offset,
      max: max ?? this.max,
      mask: mask ?? this.mask,
      order: order ?? this.order,
      sort: sort ?? this.sort,
      lang: lang ?? this.lang,
    );
  }

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
    if (filterId != null) {
      map['filterId'] = filterId!.toString();
    }
    return map;
  }
}
