import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVDetailNotifier>(context, listen: false)
          .fetchTVDetail(widget.id);
      Provider.of<TVDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TVDetailNotifier>(
        builder: (context, provider, _) {
          if (provider.tvState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvState == RequestState.Loaded) {
            final tv = provider.tv;
            return SafeArea(
              child: TVDetailContent(
                tv,
                provider.tvRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
