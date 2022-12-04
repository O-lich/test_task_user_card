import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_task_tn/widgets/heart_animation.dart';
import '../../../const/app_images.dart';
import '../../../const/strings.dart';
import '../../style/custom_container_button.dart';
import '../../style/custom_text_style.dart';

class UserCardScreen extends StatefulWidget {
  const UserCardScreen({Key? key}) : super(key: key);

  @override
  State<UserCardScreen> createState() => _UserCardScreenState();
}

class _UserCardScreenState extends State<UserCardScreen> {
  final controller = PageController();
  List<String> images = [...profileImages];
  late AssetImage assetImage;
  ValueNotifier<bool> isLiked = ValueNotifier(false);
  ValueNotifier<bool> isAnimated = ValueNotifier(false);
  ValueNotifier<bool> isClicked = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    isLiked.dispose();
    isAnimated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            duration: const Duration(milliseconds: 1000),
            child: GestureDetector(
              onDoubleTap: () {
                isAnimated.value = true;
                isLiked.value = true;
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: randomImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 15, vertical: height / 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppLogos.audioLogo,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    AppLogos.friendsLogo,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    AppLogos.countryLogo,
                                    scale: 3,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    AppLogos.buttonLoud,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Image.asset(
                                      AppLogos.newMessage,
                                      scale: 3,
                                      alignment: Alignment.topCenter,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${randomName.elementAt(Random().nextInt(randomName.length))}, ${randomAge.elementAt(Random().nextInt(randomAge.length))}',
                                    style: CustomTextStyle.nameAgeTextStyle,
                                  ),
                                  IconButton(
                                      onPressed: () => _showDialog(context),
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 40,
                                      ))
                                ],
                              ),
                              Text(
                                '${AppStrings.city}, ${randomDistance.elementAt(Random().nextInt(randomDistance.length))}',
                                style: CustomTextStyle.locationTextStyle,
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                CustomContainer.customRightContainerButton(
                                    AppLogos.letterLogo),
                                const SizedBox(
                                  height: 17,
                                ),
                                CustomContainer.customRightContainerButton(
                                    AppLogos.emojiLogo),
                                const SizedBox(
                                  height: 17,
                                ),
                                CustomContainer.customRightContainerButton(
                                    AppLogos.outboxLogo),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Image.asset(
                                    AppLogos.playerLogo,
                                    scale: 3,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(35, 35)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder(valueListenable: isClicked,
                                        builder: (BuildContext context, bool value, Widget? child) {
                                        return CustomContainer
                                            .customBottomContainerButton(
                                          context, AppLogos.beerLogo, () {
                                              isClicked.value = !isClicked.value;
                                        }, isClicked.value == false ? Colors.grey : Colors.red );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ValueListenableBuilder(valueListenable: isClicked,
                                        builder: (BuildContext context, bool value, Widget? child) {
                                          return CustomContainer
                                              .customBottomContainerButton(
                                              context, AppLogos.dogLogo, () {
                                            isClicked.value = !isClicked.value;
                                          }, isClicked.value == false ? Colors.grey : Colors.red );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ValueListenableBuilder(valueListenable: isClicked,
                                        builder: (BuildContext context, bool value, Widget? child) {
                                          return CustomContainer
                                              .customBottomContainerButton(
                                              context, AppLogos.burgerLogo, () {
                                            isClicked.value = !isClicked.value;
                                          }, isClicked.value == false ? Colors.grey : Colors.red );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ValueListenableBuilder(valueListenable: isClicked,
                                        builder: (BuildContext context, bool value, Widget? child) {
                                          return CustomContainer
                                              .customBottomContainerButton(
                                              context, AppLogos.headphonesLogo, () {
                                            isClicked.value = !isClicked.value;
                                          }, isClicked.value == false ? Colors.grey : Colors.red );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ValueListenableBuilder(valueListenable: isClicked,
                                        builder: (BuildContext context, bool value, Widget? child) {
                                          return CustomContainer
                                              .customBottomContainerButton(
                                              context, AppLogos.gamepadLogo, () {
                                            isClicked.value = !isClicked.value;
                                          }, isClicked.value == false ? Colors.grey : Colors.red );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isLiked,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return ValueListenableBuilder(
                        valueListenable: isAnimated,
                        builder: (BuildContext context, value, Widget? child) {
                          return Opacity(
                            opacity: isAnimated.value ? 1 : 0,
                            child: HeartAnimation(
                                duration: const Duration(milliseconds: 700),
                                isAnimated: isAnimated.value,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red.shade800,
                                  size: 100,
                                ),
                                onEnd: () {
                                  isAnimated.value = false;
                                }),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
        controller: controller,
      ),
    );
  }

  AssetImage randomImage() {
    if (images.isEmpty) {
      images = [...profileImages];
    }
    final random = Random();
    int randomIndex = random.nextInt(images.length);
    final asset = images[randomIndex];
    images.remove(asset);
    return AssetImage(asset);
  }

  Future _showDialog(BuildContext context) => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                elevation: 0.0,
                // title: Center(child: Text("Evaluation our APP")),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        children: const [
                          Text(AppStrings.firstAction),
                          Divider(),
                          Text(AppStrings.secondAction),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Center(
                          child: Text(AppStrings.cancel),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const Text('data');
        },
      );
}
