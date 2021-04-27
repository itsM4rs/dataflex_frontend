import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_stack_fe/presentation/widgets/rounded_rectangle_button.dart';

import '../../logic/bloc/authentication_bloc/authentication_bloc.dart';
import '../../logic/bloc/category_bloc/category_bloc.dart';
import 'items_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var categoryBloc;
  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(GetCategories());
    super.initState();
  }

  @override
  void dispose() {
    categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                RoundedRectangleButton(
                  text: 'Refresh',
                  onPressed: () {
                    categoryBloc.add(RefreshCategories());
                  },
                ),
                Spacer(),
                RoundedRectangleButton(
                  onPressed: () {
                    authenticationBloc.add(
                      LoggedOut(),
                    );
                  },
                  text: 'Logout',
                )
              ],
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              buildWhen: (previous, current) => current is CategoryLoaded,
              builder: (context, state) {
                if (state is CategoryInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoaded) {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            var refresh = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ItemPageParent(
                                  id: state.categories[index].id,
                                ),
                              ),
                            );
                            if (refresh) {
                              categoryBloc.add(RefreshCategories());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.network(
                                    state.categories[index].image,
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.bottomLeft,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state.categories[index].name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is CategoryError) {
                  return ErrorWidget(state.message.toString());
                } else {
                  return ErrorWidget('Something went wrong...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
