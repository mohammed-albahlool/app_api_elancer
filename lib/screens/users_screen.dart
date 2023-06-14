import 'package:app_api_elancer/controllers/users_controller.dart';
import 'package:app_api_elancer/model/user.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

   List<User> _users = <User>[];
   late Future<List<User>> _future;

   @override
  void initState() {
    super.initState();
    _future = UserApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());

          }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            _users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(_users[index].image),),
                  title: Text("${_users[index].firstName} ${_users[index].lastName}"),
                  subtitle: Text(_users[index].email),
                );
              },);
          }else {
            return Center(child: Text('No Data'),);
          }
        },
      ),

    );
  }
}
