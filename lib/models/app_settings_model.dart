import 'package:equatable/equatable.dart';

// Model for the 'vc' (Version Control) object
class VersionControl extends Equatable {
  final bool status;
  final String? appVersion;
  final bool? forceUpgrade;

  const VersionControl({
    required this.status,
    this.appVersion,
    this.forceUpgrade,
  });

  factory VersionControl.fromJson(Map<String, dynamic> json) {
    return VersionControl(
      status: json['status'] as bool? ?? false,
      appVersion: json['appVersion'] as String?,
      forceUpgrade: json['forceUpgrade'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'appVersion': appVersion,
      'forceUpgrade': forceUpgrade,
    };
  }

  @override
  List<Object?> get props => <Object?>[status, appVersion, forceUpgrade];
}

// Model for the various ad item lists (e.g., 'ac', 'ap', 'dt')
class AdItem extends Equatable {
  final int id;
  final int activeAdvId;
  final int p;
  final String bannerUrl;
  final String url;
  final bool gif;
  final String title;
  final int width;
  final int height;
  final bool webview;

  const AdItem({
    required this.id,
    required this.activeAdvId,
    required this.p,
    required this.bannerUrl,
    required this.url,
    required this.gif,
    required this.title,
    required this.width,
    required this.height,
    required this.webview,
  });

  factory AdItem.fromJson(Map<String, dynamic> json) {
    return AdItem(
      id: json['id'] as int? ?? 0,
      activeAdvId: json['activeAdvId'] as int? ?? 0,
      p: json['p'] as int? ?? 0,
      bannerUrl: json['bannerUrl'] as String? ?? '',
      url: json['url'] as String? ?? '',
      gif: json['gif'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      webview: json['webview'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'activeAdvId': activeAdvId,
      'p': p,
      'bannerUrl': bannerUrl,
      'url': url,
      'gif': gif,
      'title': title,
      'width': width,
      'height': height,
      'webview': webview,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    activeAdvId,
    p,
    bannerUrl,
    url,
    gif,
    title,
    width,
    height,
    webview,
  ];
}

// Model for the items in 'dashFeatured'
class DashFeaturedItem extends Equatable {
  final int id;
  final int activeAdvId;
  final int productId;
  final String img;
  final String description;
  final String descriptionRu;
  final String timeLocation;
  final String timeLocationRu;
  final bool vip;
  final int p;
  final String type;
  final String title;

  const DashFeaturedItem({
    required this.id,
    required this.activeAdvId,
    required this.productId,
    required this.img,
    required this.description,
    required this.descriptionRu,
    required this.timeLocation,
    required this.timeLocationRu,
    required this.vip,
    required this.p,
    required this.type,
    required this.title,
  });

  factory DashFeaturedItem.fromJson(Map<String, dynamic> json) {
    return DashFeaturedItem(
      id: json['id'] as int? ?? 0,
      activeAdvId: json['activeAdvId'] as int? ?? 0,
      productId: json['productId'] as int? ?? 0,
      img: json['img'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionRu: json['descriptionRu'] as String? ?? '',
      timeLocation: json['timeLocation'] as String? ?? '',
      timeLocationRu: json['timeLocationRu'] as String? ?? '',
      vip: json['vip'] as bool? ?? false,
      p: json['p'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'activeAdvId': activeAdvId,
      'productId': productId,
      'img': img,
      'description': description,
      'descriptionRu': descriptionRu,
      'timeLocation': timeLocation,
      'timeLocationRu': timeLocationRu,
      'vip': vip,
      'p': p,
      'type': type,
      'title': title,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    activeAdvId,
    productId,
    img,
    description,
    descriptionRu,
    timeLocation,
    timeLocationRu,
    vip,
    p,
    type,
    title,
  ];

  String getTimeLocation(String languageCode) {
    return languageCode == "ru" ? timeLocationRu : timeLocation;
  }

  String getDescription(String languageCode) {
    return languageCode == "ru" ? descriptionRu : description;
  }
}

// Main model for the entire JSON response
class AppSettings extends Equatable {
  final VersionControl vc;
  final bool newsEnabled;
  final bool businessEnabled;
  final bool partialUpload;
  final List<String> extraUrlList;
  final List<AdItem> ac;
  final List<AdItem> ap;
  final List<AdItem> apr;
  final List<AdItem> acf;
  final List<AdItem> apf;
  final List<AdItem> aprf;
  final List<AdItem> dt;
  final List<AdItem> dl;
  final List<AdItem> dr;
  final List<AdItem> db;
  final List<AdItem> cd;
  final List<AdItem> pd;
  final List<AdItem> od;
  final bool showAdmInterStitial;
  final int admInterStitialPeriod;
  final bool showAdmOnListings;
  final bool showAdmOnDetails;
  final int admDetailsPeriod;
  final List<dynamic> customInterStitials;
  final List<AdItem> dashArticles;
  final List<AdItem> dashSlider;
  final List<DashFeaturedItem> dashFeatured;
  final List<AdItem> dashProfiles;
  final List<AdItem> articleList;
  final List<AdItem> articleDetail;
  final List<AdItem> articleDetailBot;
  final List<dynamic> reviewList;
  final bool publicReviews;
  final bool dashNews;

  const AppSettings({
    required this.vc,
    required this.newsEnabled,
    required this.businessEnabled,
    required this.partialUpload,
    required this.extraUrlList,
    required this.ac,
    required this.ap,
    required this.apr,
    required this.acf,
    required this.apf,
    required this.aprf,
    required this.dt,
    required this.dl,
    required this.dr,
    required this.db,
    required this.cd,
    required this.pd,
    required this.od,
    required this.showAdmInterStitial,
    required this.admInterStitialPeriod,
    required this.showAdmOnListings,
    required this.showAdmOnDetails,
    required this.admDetailsPeriod,
    required this.customInterStitials,
    required this.dashArticles,
    required this.dashSlider,
    required this.dashFeatured,
    required this.dashProfiles,
    required this.articleList,
    required this.articleDetail,
    required this.articleDetailBot,
    required this.reviewList,
    required this.publicReviews,
    required this.dashNews,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      vc: VersionControl.fromJson(
        json['vc'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      newsEnabled: json['newsEnabled'] as bool? ?? false,
      businessEnabled: json['businessEnabled'] as bool? ?? false,
      partialUpload: json['partialUpload'] as bool? ?? false,
      extraUrlList:
          (json['extraUrlList'] as List<dynamic>?)
              ?.map((dynamic e) => e as String)
              .toList() ??
          <String>[],
      ac:
          (json['ac'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      ap:
          (json['ap'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      apr:
          (json['apr'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      acf:
          (json['acf'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      apf:
          (json['apf'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      aprf:
          (json['aprf'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      dt:
          (json['dt'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      dl:
          (json['dl'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      dr:
          (json['dr'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      db:
          (json['db'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      cd:
          (json['cd'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      pd:
          (json['pd'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      od:
          (json['od'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      showAdmInterStitial: json['showAdmInterStitial'] as bool? ?? false,
      admInterStitialPeriod: json['admInterStitialPeriod'] as int? ?? 0,
      showAdmOnListings: json['showAdmOnListings'] as bool? ?? false,
      showAdmOnDetails: json['showAdmOnDetails'] as bool? ?? false,
      admDetailsPeriod: json['admDetailsPeriod'] as int? ?? 0,
      customInterStitials:
          json['customInterStitials'] as List<dynamic>? ?? <dynamic>[],
      dashArticles:
          (json['dashArticles'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      dashSlider:
          (json['dashSlider'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      dashFeatured:
          (json['dashFeatured'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    DashFeaturedItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          <DashFeaturedItem>[],
      dashProfiles:
          (json['dashProfiles'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      articleList:
          (json['articleList'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      articleDetail:
          (json['articleDetail'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      articleDetailBot:
          (json['articleDetailBot'] as List<dynamic>?)
              ?.map((dynamic e) => AdItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AdItem>[],
      reviewList: json['reviewList'] as List<dynamic>? ?? <dynamic>[],
      publicReviews: json['publicReviews'] as bool? ?? false,
      dashNews: json['dashNews'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'vc': vc.toJson(),
      'newsEnabled': newsEnabled,
      'businessEnabled': businessEnabled,
      'partialUpload': partialUpload,
      'extraUrlList': extraUrlList,
      'ac': ac.map((AdItem e) => e.toJson()).toList(),
      'ap': ap.map((AdItem e) => e.toJson()).toList(),
      'apr': apr.map((AdItem e) => e.toJson()).toList(),
      'acf': acf.map((AdItem e) => e.toJson()).toList(),
      'apf': apf.map((AdItem e) => e.toJson()).toList(),
      'aprf': aprf.map((AdItem e) => e.toJson()).toList(),
      'dt': dt.map((AdItem e) => e.toJson()).toList(),
      'dl': dl.map((AdItem e) => e.toJson()).toList(),
      'dr': dr.map((AdItem e) => e.toJson()).toList(),
      'db': db.map((AdItem e) => e.toJson()).toList(),
      'cd': cd.map((AdItem e) => e.toJson()).toList(),
      'pd': pd.map((AdItem e) => e.toJson()).toList(),
      'od': od.map((AdItem e) => e.toJson()).toList(),
      'showAdmInterStitial': showAdmInterStitial,
      'admInterStitialPeriod': admInterStitialPeriod,
      'showAdmOnListings': showAdmOnListings,
      'showAdmOnDetails': showAdmOnDetails,
      'admDetailsPeriod': admDetailsPeriod,
      'customInterStitials': customInterStitials,
      'dashArticles': dashArticles.map((AdItem e) => e.toJson()).toList(),
      'dashSlider': dashSlider.map((AdItem e) => e.toJson()).toList(),
      'dashFeatured': dashFeatured
          .map((DashFeaturedItem e) => e.toJson())
          .toList(),
      'dashProfiles': dashProfiles.map((AdItem e) => e.toJson()).toList(),
      'articleList': articleList.map((AdItem e) => e.toJson()).toList(),
      'articleDetail': articleDetail.map((AdItem e) => e.toJson()).toList(),
      'articleDetailBot': articleDetailBot
          .map((AdItem e) => e.toJson())
          .toList(),
      'reviewList': reviewList,
      'publicReviews': publicReviews,
      'dashNews': dashNews,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    vc,
    newsEnabled,
    businessEnabled,
    partialUpload,
    extraUrlList,
    ac,
    ap,
    apr,
    acf,
    apf,
    aprf,
    dt,
    dl,
    dr,
    db,
    cd,
    pd,
    od,
    showAdmInterStitial,
    admInterStitialPeriod,
    showAdmOnListings,
    showAdmOnDetails,
    admDetailsPeriod,
    customInterStitials,
    dashArticles,
    dashSlider,
    dashFeatured,
    dashProfiles,
    articleList,
    articleDetail,
    articleDetailBot,
    reviewList,
    publicReviews,
    dashNews,
  ];
}
