import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:tv_series/presentation/widgets/tv_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<TVDetailBloc>().add(FetchTVDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVDetailBloc, TVDetailState>(
        builder: (context, state) {
          if (state is TVDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVDetailLoaded) {
            final tv = state.tv;
            return SafeArea(
              child: TVDetailContent(
                tv,
                state.recommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state is TVDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
