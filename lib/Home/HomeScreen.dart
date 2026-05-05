import 'package:apis_auth_jwt/ApiAuth/secure_storage_service.dart';
import 'package:apis_auth_jwt/Home/home_bloc.dart';
import 'package:apis_auth_jwt/Home/home_event.dart';
import 'package:apis_auth_jwt/Home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(RecipesLoadEvent());
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      context.read<HomeBloc>().add(LoadMoreRecipesLoadEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipes"),
          actions: [
            IconButton(
                onPressed: () {
                  SecureStorageService().clear();

                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeSuccess) {
              return ListView.builder(
                controller: scrollController,
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final item = state.recipes[index];

                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(item.image!),
                        ),
                        ListTile(
                          title: Text("${index} - ${item.name ?? ""}"),
                          subtitle: Text(item.cuisine ?? ""),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is HomeError) {
              return Center(child: Text(state.error));
            }

            // 🟡 Default
            return const SizedBox();
          },
        ));
  }
}
