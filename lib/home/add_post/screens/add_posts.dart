import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/home/add_post/bloc/add_post_bloc.dart';

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
                      hintText: 'Avatar',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: context.read<AddPostBloc>().imageUrlInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Image',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: context.read<AddPostBloc>().captionInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Caption',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){

                    },
                    child: TextButton.icon(
                      onPressed: (){

                      },
                      icon: Icon(Icons.camera, color: Colors.white,),
                      label: Text('Take a shot', style: TextStyle(color: Colors.white),),
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
        )
      ),
    );
  }
}

