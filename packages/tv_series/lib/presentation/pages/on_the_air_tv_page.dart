import 'package:core/common/state_enum.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_event.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_state.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  @override
  _OnTheAirTVPageState createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TVListBloc>().add(FetchOnTheAirTV()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVListBloc, TVListState>(
          builder: (context, state) {
            if (state is TVListLoaded) {
              if (state.onTheAirState == RequestState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.onTheAirState == RequestState.Loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.onTheAirTv[index];
                    return TVCard(tv);
                  },
                  itemCount: state.onTheAirTv.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
