import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVDetailContent extends StatefulWidget {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchlist;

  TVDetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  _TVDetailContentState createState() => _TVDetailContentState();
}

class _TVDetailContentState extends State<TVDetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: richBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: heading5,
                            ),
                            FilledButton(
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<TVDetailBloc>()
                                      .add(AddTVWatchlist(widget.tv));
                                } else {
                                  context
                                      .read<TVDetailBloc>()
                                      .add(RemoveTVWatchlist(widget.tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Text(
                              '${widget.tv.numberOfSeasons} Season(s), ${widget.tv.numberOfEpisodes} Episode(s)',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: mikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: heading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            SizedBox(height: 16),
                            // Seasons expandable list
                            if (widget.tv.seasons.isNotEmpty) ...[
                              Text(
                                'Seasons',
                                style: heading6,
                              ),
                              SizedBox(height: 8),
                              ...widget.tv.seasons.map((season) {
                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: season.posterPath != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      '$BASE_IMAGE_URL_W92${season.posterPath}',
                                                  width: 40,
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                    width: 40,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.image),
                                                ),
                                              )
                                            : Icon(Icons.image),
                                        title: Text(season.name),
                                        subtitle: Text(
                                            '${season.episodeCount} Episodes'),
                                        trailing: Icon(Icons.arrow_forward_ios,
                                            size: 16),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            TVSeasonDetailPage.ROUTE_NAME,
                                            arguments: {
                                              'tvId': widget.tv.id,
                                              'seasonNumber':
                                                  season.seasonNumber,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              SizedBox(height: 16),
                            ],
                            Text(
                              'Recommendations',
                              style: heading6,
                            ),
                            BlocBuilder<TVDetailBloc, TVDetailState>(
                              builder: (context, state) {
                                if (state is TVDetailLoaded) {
                                  if (state.recommendationState ==
                                      RequestState.Loading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state.recommendationState ==
                                      RequestState.Error) {
                                    return Text(state.message);
                                  } else if (state.recommendationState ==
                                      RequestState.Loaded) {
                                    return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tv =
                                              widget.recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  TVDetailPage.ROUTE_NAME,
                                                  arguments: tv.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      '$BASE_IMAGE_URL${tv.posterPath}',
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            widget.recommendations.length,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                                return Container();
                              },
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: richBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
