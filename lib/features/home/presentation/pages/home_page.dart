import 'package:fikr/config/routes/app_routes.dart';
import 'package:fikr/features/auth/presentation/providers/auth_controller.dart';
import 'package:fikr/features/auth/presentation/providers/auth_provider.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text.dart';
import 'package:fikr/features/home/presentation/providers/home_provider.dart';
import 'package:fikr/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
  void _logout() async {
    await ref.read(authControllerProvider.notifier).signOut();

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final usersAsync = ref.watch(getUsersProvider);
    final currentUserAsync = ref.watch(authStateProvider);
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: MyText(
          title: "FikrApp",
          color: theme.surface,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.exit_to_app, color: theme.surface),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SearchTextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchController.text = value;
                });
              },
              hintText: "Поиск...",
            ),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) {
                final currentUser = currentUserAsync.value;
                final filteredUsers = users
                    .where(
                      (user) =>
                          user.uid != currentUser?.uid &&
                          user.name.toLowerCase().contains(
                            searchController.text,
                          ),
                    )
                    .toList();

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: MyText(
                          title: user.name[0],
                          color: theme.tertiary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      title: MyText(
                        title: user.name,
                        color: theme.inversePrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: MyText(title: user.email, color: theme.primary),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                  itemCount: filteredUsers.length,
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => Center(child: CupertinoActivityIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
