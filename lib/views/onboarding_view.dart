import 'package:flutter/material.dart';
import 'package:noteale_clone/utils/colors.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: const [
                    OnboardingSection1(),
                    OnboardingSection2(),
                    OnboardingSection3(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      final bool isActive = _currentPage == index;
                      return Container(
                        width: isActive ? 18 : 8,
                        height: isActive ? 10 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isActive
                              ? ColorsUtil.primaryColor
                              : Colors.grey.shade400,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsUtil.primaryColor,
                      ),
                      onPressed: () {},
                      child: const Text("CREATE ACCOUNT"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsUtil.secondaryColor,
                      ),
                      onPressed: () {},
                      child: const Text("LOG IN"),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingSection3 extends StatelessWidget {
  const OnboardingSection3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 33),

        Center(
          child: Image.asset('assets/amico2.png', width: 340, height: 340),
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Image to Text Converter",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Upload your images and convert to text",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class OnboardingSection2 extends StatelessWidget {
  const OnboardingSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 33),

        Center(child: Image.asset('assets/cuate.png', width: 340, height: 340)),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "To Dos",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "list out your day-to-day tasks",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class OnboardingSection1 extends StatelessWidget {
  const OnboardingSection1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 8),
                Text(
                  'WELCOME TO',
                  style: TextStyle(fontSize: 18, fontFamily: "Roboto"),
                ),
                Text(
                  "HaBIT NOTE",
                  style: TextStyle(fontSize: 18, fontFamily: "FugazOne"),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        Center(child: Image.asset('assets/amico.png', width: 340, height: 340)),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Take Notes",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Quickly capture what’s on your mind",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
