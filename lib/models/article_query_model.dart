// TODO: Add full query arguments
class ArticleQuery {
  int? offset;
  int? max;
  int? categoryId;
  String? categoryCode;
  String? mask;
  String? tags;
  String? order;
  String? sort;
  String? lang;
  ArticleQuery({
    this.offset,
    this.mask,
    this.order,
    this.sort,
    this.lang,
    this.max,
    this.categoryCode,
    this.tags,
    this.categoryId,
  });

  ArticleQuery copyWith({
    int? offset,
    int? max,
    int? categoryId,
    String? categoryCode,
    String? mask,
    String? tags,
    String? order,
    String? sort,
    String? lang,
  }) {
    return ArticleQuery(
      offset: offset ?? this.offset,
      max: max ?? this.max,
      mask: mask ?? this.mask,
      order: order ?? this.order,
      sort: sort ?? this.sort,
      lang: lang ?? this.lang,
      categoryCode: categoryCode ?? this.categoryCode,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
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
    if (categoryCode != null) {
      map['categoryCode'] = categoryCode!;
    }
    if (categoryId != null) {
      map['categoryId'] = categoryId!.toString();
    }
    if (tags != null) {
      map['tags'] = tags!;
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
