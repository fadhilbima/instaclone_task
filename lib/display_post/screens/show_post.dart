import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/display_post/bloc/show_post_bloc.dart';

class ShowPost extends StatelessWidget {
  const ShowPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowPostBloc()..add(GetPost()),
      child: ShowPostView(),
    );
  }
}

class ShowPostView extends StatelessWidget {
  const ShowPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whole Post'),
      ),
      body: BlocBuilder<ShowPostBloc, ShowPostState> (
        builder: (context, state) {
          if(state is ShowPostLoaded) {
            if (state.models.isEmpty) {
              return Center(
                child: Text('No Posts'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: state.models
                    .map(
                      (e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(e.avatarUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(e.username),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          e.imageUrl,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text.rich(
                            TextSpan(
                              text: e.username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: e.caption,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  ),
                ).toList(),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
