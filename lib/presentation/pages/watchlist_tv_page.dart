import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTVPageState createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTVBloc>().add(FetchWatchlistTV()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTVBloc>().add(FetchWatchlistTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVBloc, WatchlistTVState>(
          builder: (context, state) {
            if (state is WatchlistTVLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTVLoaded) {
              if (state.tvList.isEmpty) {
                return Center(
                  key: Key('empty_message'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.tv_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No TV Series in Watchlist'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvList[index];
                  return TVCard(tv);
                },
                itemCount: state.tvList.length,
              );
            } else if (state is WatchlistTVError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
