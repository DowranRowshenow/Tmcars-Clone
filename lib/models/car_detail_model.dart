import 'package:equatable/equatable.dart';

class CarDetail extends Equatable {
  final int id;
  final String cn;
  final String cnru;
  final String subCityName;
  final String subCityNameRu;
  final String parentCityName;
  final String parentCityNameRu;
  final String bn;
  final String mn;
  final int y;
  final double e;
  final String ctm;
  final String cru;
  final bool sw;
  final bool cr;
  final int mil;
  final int pr;
  final String pd;
  final String et;
  final String bt;
  final String tt;
  final bool toMe;
  final bool vip;
  final bool inv;
  final String dsc;
  final bool vic;
  final String shareSiteUrl;
  final List<String> imgs;
  final List<List<String>> extraImgs;
  final List<String> fullImgs;
  final List<List<String>> extraFullImgs;
  final String driveType;
  final int cupdate;
  final int vc;

  // Nullable fields
  final String? trim;
  final bool? reviewEnabled;
  final int? reviewCount;
  final String? gid;
  final String? sd;
  final String? shareUrl;
  final String? vin;

  const CarDetail({
    required this.id,
    required this.cn,
    required this.cnru,
    required this.subCityName,
    required this.subCityNameRu,
    required this.parentCityName,
    required this.parentCityNameRu,
    required this.bn,
    required this.mn,
    required this.y,
    required this.e,
    required this.ctm,
    required this.cru,
    required this.sw,
    required this.cr,
    required this.mil,
    required this.pr,
    required this.pd,
    required this.et,
    required this.bt,
    required this.tt,
    required this.toMe,
    required this.vip,
    required this.inv,
    required this.dsc,
    required this.vic,
    required this.shareSiteUrl,
    required this.imgs,
    required this.extraImgs,
    required this.fullImgs,
    required this.extraFullImgs,
    required this.driveType,
    required this.cupdate,
    required this.vc,
    this.trim,
    this.reviewEnabled,
    this.reviewCount,
    this.gid,
    this.sd,
    this.shareUrl,
    this.vin,
  });

  factory CarDetail.fromJson(Map<String, dynamic> json) {
    return CarDetail(
      id: json['id'] as int,
      cn: json['cn'] as String,
      cnru: json['cnru'] as String,
      subCityName: json['subCityName'] as String,
      subCityNameRu: json['subCityNameRu'] as String,
      parentCityName: json['parentCityName'] as String,
      parentCityNameRu: json['parentCityNameRu'] as String,
      bn: json['bn'] as String,
      mn: json['mn'] as String,
      y: json['y'] as int,
      e: json['e'] is int ? (json['e'] as int).toDouble() : json['e'] as double,
      ctm: json['ctm'] as String,
      cru: json['cru'] as String,
      sw: json['sw'] as bool,
      cr: json['cr'] as bool,
      mil: json['mil'] as int,
      pr: json['pr'] as int,
      pd: json['pd'] as String,
      et: json['et'] as String,
      bt: json['bt'] as String,
      tt: json['tt'] as String,
      toMe: json['toMe'] as bool,
      vip: json['vip'] as bool,
      inv: json['inv'] as bool,
      dsc: json['dsc'] as String,
      vic: json['vic'] as bool,
      shareSiteUrl: json['shareSiteUrl'] as String,
      imgs: (json['imgs'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      extraImgs: (json['extraImgs'] as List<dynamic>)
          .map(
            (dynamic e) =>
                (e as List<dynamic>).map((dynamic e) => e as String).toList(),
          )
          .toList(),
      fullImgs: (json['fullImgs'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      extraFullImgs: (json['extraFullImgs'] as List<dynamic>)
          .map(
            (dynamic e) =>
                (e as List<dynamic>).map((dynamic e) => e as String).toList(),
          )
          .toList(),
      driveType: json['driveType'] as String,
      cupdate: json['cupdate'] as int,
      vc: json['vc'] as int,
      trim: json['trim'] as String?,
      reviewEnabled: json['reviewEnabled'] as bool?,
      reviewCount: json['reviewCount'] as int?,
      gid: json['gid'] as String?,
      sd: json['sd'] as String?,
      shareUrl: json['shareUrl'] as String?,
      vin: json['vin'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'cn': cn,
      'cnru': cnru,
      'subCityName': subCityName,
      'subCityNameRu': subCityNameRu,
      'parentCityName': parentCityName,
      'parentCityNameRu': parentCityNameRu,
      'bn': bn,
      'mn': mn,
      'y': y,
      'e': e,
      'ctm': ctm,
      'cru': cru,
      'sw': sw,
      'cr': cr,
      'mil': mil,
      'pr': pr,
      'pd': pd,
      'et': et,
      'bt': bt,
      'tt': tt,
      'toMe': toMe,
      'vip': vip,
      'inv': inv,
      'dsc': dsc,
      'vic': vic,
      'shareSiteUrl': shareSiteUrl,
      'imgs': imgs,
      'extraImgs': extraImgs,
      'fullImgs': fullImgs,
      'extraFullImgs': extraFullImgs,
      'driveType': driveType,
      'cupdate': cupdate,
      'vc': vc,
      'trim': trim,
      'reviewEnabled': reviewEnabled,
      'reviewCount': reviewCount,
      'gid': gid,
      'sd': sd,
      'shareUrl': shareUrl,
      'vin': vin,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    cn,
    cnru,
    subCityName,
    subCityNameRu,
    parentCityName,
    parentCityNameRu,
    bn,
    mn,
    y,
    e,
    ctm,
    cru,
    sw,
    cr,
    mil,
    pr,
    pd,
    et,
    bt,
    tt,
    toMe,
    vip,
    inv,
    dsc,
    vic,
    shareSiteUrl,
    imgs,
    extraImgs,
    fullImgs,
    extraFullImgs,
    driveType,
    cupdate,
    vc,
    trim,
    reviewEnabled,
    reviewCount,
    gid,
    sd,
    shareUrl,
    vin,
  ];

  String getCityName(String languageCode) {
    return languageCode == "ru" ? cnru : cn;
  }

  String getSubCityName(String languageCode) {
    return languageCode == "ru" ? subCityNameRu : subCityName;
  }

  String getParentCityName(String languageCode) {
    return languageCode == "ru" ? parentCityNameRu : parentCityName;
  }

  String getColor(String languageCode) {
    return languageCode == "ru" ? cru : ctm;
  }

  String getTitle() {
    return "$bn $mn $trim $y";
  }
}
