import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/home/add_post/add_post.dart';
import 'package:instaclone/home/home_global_bloc/home_bloc.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        print(state);
        if(state is AddNewPostState) {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddPost();
          }));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: context.read<HomeBloc>().stating[
          context.read<HomeBloc>().index
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<HomeBloc>().add(AddPostEvent());
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 12,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 70,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: context.read<HomeBloc>().index,
              onTap: (index) {
                context.read<HomeBloc>().index = index;
                setState(() {});
                print(context.read<HomeBloc>().index);
                if(index==0) {
                  return context.read<HomeBloc>().add(HomeInitialEvent());
                }
                if(index==1) {
                  return context.read<HomeBloc>().add(SettingEvent());
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Setting'
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
