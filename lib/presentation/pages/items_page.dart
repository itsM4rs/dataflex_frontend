import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_stack_fe/data/repositories/item_repo.dart';

import '../../logic/bloc/authentication_bloc/authentication_bloc.dart';
import '../../logic/bloc/item_bloc/item_bloc.dart';

class ItemPageParent extends StatelessWidget {
  final int id;

  const ItemPageParent({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(itemRepository: ItemRepository()),
      child: ItemsPage(
        id: id,
      ),
    );
  }
}

class ItemsPage extends StatefulWidget {
  final int id;
  const ItemsPage({Key key, @required this.id}) : super(key: key);
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  var itemBloc;
  @override
  void initState() {
    itemBloc = BlocProvider.of<ItemBloc>(context);
    itemBloc.add(GetItems(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    itemBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      authenticationBloc.add(
                        LoggedOut(),
                      );
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Logout'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ItemLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ItemLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.items[index].name,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(state.items[index].date,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey)),
                              Text(
                                state.items[index].text,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ));
                    },
                  );
                } else if (state is ItemError) {
                  return ErrorWidget(state.message.toString());
                } else {
                  return ErrorWidget('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
