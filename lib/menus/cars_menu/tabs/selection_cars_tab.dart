import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/car_product_filter_model.dart';
import '../../../models/car_query_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/traffic.dart';
import '../../../utils/constants.dart';
import '../../../utils/server.dart';

class SelectionCarsTab extends StatefulWidget {
  const SelectionCarsTab({
    super.key,
    required this.tabController,
    required this.query,
    required this.searchBarController,
  });
  final TextEditingController searchBarController;
  final TabController tabController;
  final ValueNotifier<CarQuery> query;

  @override
  State<SelectionCarsTab> createState() => _SelectionCarsTabState();
}

class _SelectionCarsTabState extends State<SelectionCarsTab>
    with AutomaticKeepAliveClientMixin {
  final double height = 200.0;

  final double width = 600.0;

  Future<List<CarProductFilter>> _future() {
    return Server.getCarProductFilter(const CarProductFilter());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Locale locale = context.read<LocaleManager>().locale;

    return FutureBuilder<List<CarProductFilter>>(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasData) {
          final List<CarProductFilter> items =
              snapshot.data as List<CarProductFilter>;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Stack(
                  children: <Widget>[
                    context.read<TrafficManager>().isStandart()
                        ? CachedNetworkImage(
                            imageUrl: items[index].imgUrl ?? "",
                            filterQuality: FilterQuality.low,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            memCacheWidth: width.toInt(),
                            placeholder: (BuildContext context, String url) =>
                                Container(
                                  height: height,
                                  color: Colors.black.withAlpha(100),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget:
                                (
                                  BuildContext context,
                                  String url,
                                  Object error,
                                ) => buildImagePlaceholder(
                                  context,
                                  width: double.infinity,
                                  height: height,
                                ),
                          )
                        : buildImagePlaceholder(
                            context,
                            width: double.infinity,
                            height: height,
                          ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.transparent, // Top is transparent
                              Colors.black,
                            ],
                            stops: <double>[0.1, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.black.withAlpha(60),
                          splashColor: Colors.black.withAlpha(60),
                          hoverColor: Colors.black.withAlpha(60),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            items[index].getFilterName(locale.languageCode) ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.query.value.filterId = items[index].id;
                              widget.query.value = widget.query.value
                                  .copyWith();
                              widget.searchBarController.text =
                                  items[index].getFilterName(
                                    locale.languageCode,
                                  ) ??
                                  "";
                              widget.tabController.animateTo(0);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                              decoration: BoxDecoration(
                                color: Constants.colorPrimary,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "${Localizations.of<AppLocalizations>(context, AppLocalizations)!.showAll} (${items[index].productCount ?? ''}+)",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
