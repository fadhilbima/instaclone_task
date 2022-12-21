import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/home/add_post/bloc/add_post_bloc.dart';
import 'package:instaclone/home/camera/screens/camera_page.dart';
import 'package:instaclone/home/display_post/screens/show_post.dart';
import 'package:instaclone/home/home_main.dart';
import 'package:instaclone/home/upload_pict/upload_bloc.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddPostBloc()..add(Initialize()),),
        BlocProvider(create: (context) => UploadBloc())
      ],
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
        print(state);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Post'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: context.read<AddPostBloc>().uidInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'UID',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    controller: context.read<AddPostBloc>().usernameInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Username/Email',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: context.read<AddPostBloc>().avatarUrlInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Put an Avatar',
                    ),
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<UploadBloc, UploadState>(
                    listener: (context, state) {
                      print(state);
                      if(state is UploadSuccess) {
                        context.read<AddPostBloc>().imageUrlInput.text = state.fileUrl;
                      }
                      if (state is UploadLoading) {
                        context.read<AddPostBloc>().imageUrlInput.text = 'Loadaing img...';
                      }
                    },
                    builder: (context, state) {
                      return TextFormField(
                        controller: context.read<AddPostBloc>().imageUrlInput,
                        decoration: InputDecoration(
                          hintText: 'Image',
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: context.read<AddPostBloc>().captionInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Put a caption',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AddPostBloc>().add(SubmitPost());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ), (route) => false,
                      );
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Camera(),
              ),
            ).then((value) {
              if (value != null && value is File) {
                context.read<UploadBloc>().uploaded(value);
              }
            });
          },
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}