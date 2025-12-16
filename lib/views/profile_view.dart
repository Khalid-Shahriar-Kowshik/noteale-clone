import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        final user = authVM.currentUser;
        final displayName = user?.name ?? 'Guest';
        final displayEmail = user?.email ?? '';

        return Scaffold(
          appBar: AppBar(title: Text('Hello $displayName')),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName, style: const TextStyle(fontSize: 18)),
                        Text(
                          displayEmail,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                thickness: 1,
                color: ColorsUtil.primaryColor,
                indent: 0,
                endIndent: 0,
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.archive),
                      title: const Text(
                        'Archived Notes',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () => GoRouter.of(context).push('/settings'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text(
                        'About',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () => GoRouter.of(context).push('/about'),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                backgroundColor: ColorsUtil.backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Are you sure you want to logout?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => Navigator.of(
                                              dialogContext,
                                            ).pop(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorsUtil.backgroundColor,
                                              side: const BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorsUtil.primaryColor,
                                              foregroundColor: Colors.white,
                                              minimumSize: const Size(120, 48),
                                            ),
                                            icon: const Icon(Icons.logout),
                                            label: const Text('Logout'),
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                              context
                                                  .read<AuthViewModel>()
                                                  .logout();
                                              context.go('/login');
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsUtil.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: ColorsUtil.backgroundColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsUtil.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
