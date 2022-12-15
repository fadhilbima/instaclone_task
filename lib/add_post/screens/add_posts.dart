import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/add_post/bloc/add_post_bloc.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AddPostBloc()
        ..add(Initialize()),
      child: AddView(),
    );
  }
}

class AddView extends StatelessWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {

      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('New Post'),
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().uidInput,
                  decoration: InputDecoration(
                    hintText: 'UID',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().usernameInput,
                  decoration: InputDecoration(
                    hintText: 'Username/Email',
                  ),
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().avatarUrlInput,
                  decoration: InputDecoration(
                    hintText: 'Avatar',
                  ),
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().imageUrlInput,
                  decoration: InputDecoration(
                    hintText: 'Image',
                  ),
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().captionInput,
                  decoration: InputDecoration(
                    hintText: 'Caption',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(SubmitPost());
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

