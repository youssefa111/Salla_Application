import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/modules/search/cubit/search_cubit.dart';
import 'package:shop_application/shared/components/componants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = new TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      if (state is SearchSucessState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildListProduct(
                                  SearchCubit.get(context)
                                      .model
                                      .data
                                      .data[index],
                                  context,
                                  isOldPrice: false),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: SearchCubit.get(context)
                                  .model
                                  .data
                                  .data
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
