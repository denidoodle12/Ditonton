import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_season_detail/tv_season_detail_state.dart';
import 'package:tv_series/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-season-detail';

  final int tvId;
  final int seasonNumber;

  TVSeasonDetailPage({required this.tvId, required this.seasonNumber});

  @override
  _TVSeasonDetailPageState createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TVSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeasonDetailBloc>().add(
            FetchTVSeasonDetail(
              tvId: widget.tvId,
              seasonNumber: widget.seasonNumber,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season ${widget.seasonNumber} Episodes'),
      ),
      body: BlocBuilder<TVSeasonDetailBloc, TVSeasonDetailState>(
        builder: (context, state) {
          if (state is TVSeasonDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeasonDetailLoaded) {
            final episodes = state.episodes;
            return ListView.builder(
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return EpisodeCard(episode: episode);
              },
            );
          } else if (state is TVSeasonDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
