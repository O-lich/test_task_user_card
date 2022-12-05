import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:test_task_tn/const/app_colors.dart';
import 'package:test_task_tn/const/app_images.dart';
import 'package:test_task_tn/const/strings.dart';
import 'package:test_task_tn/ui/style/custom_container_button.dart';
import 'package:test_task_tn/ui/style/custom_text_style.dart';
import 'package:test_task_tn/widgets/audio_widget.dart';
import 'package:test_task_tn/widgets/bouncing_animation.dart';

class UserCardScreen extends StatefulWidget {
  const UserCardScreen({Key? key}) : super(key: key);

  @override
  State<UserCardScreen> createState() => _UserCardScreenState();
}

class _UserCardScreenState extends State<UserCardScreen> {
  final controller = PageController(initialPage: 0, keepPage: true);
  List<String> images = [...profileImages];
  late AssetImage assetImage;
  ValueNotifier<bool> isLiked = ValueNotifier(false);
  ValueNotifier<bool> isAnimated = ValueNotifier(false);
  ValueNotifier<bool> isClicked = ValueNotifier(false);
  ValueNotifier<bool> isEmojiPressed = ValueNotifier(false);
  ValueNotifier<bool> isEmojiAnimated = ValueNotifier(false);
  ValueNotifier<bool> isSwiped = ValueNotifier(false);
  ValueNotifier<bool> isBrokenHeartAnimated = ValueNotifier(false);

  int selectedIndex = 0;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
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
        body: RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.grey,
      onRefresh: () async {
        return Future<void>.delayed(const Duration(seconds: 1));
      },
      child: PageView.builder(
        onPageChanged: (index) {
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.linear);
        },
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onHorizontalDragEnd: (dragDetail) {
              if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
                isBrokenHeartAnimated.value = true;
                isSwiped.value = true;
              }
            },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${randomName.elementAt(Random().nextInt(randomName.length))}, '
                                  '${randomAge.elementAt(Random().nextInt(randomAge.length))}',
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
                                  AppLogos.letterLogo, null),
                              const SizedBox(
                                height: 17,
                              ),
                              CustomContainer.customRightContainerButton(
                                  AppLogos.emojiLogo, () {
                                isEmojiPressed.value = true;
                                isEmojiAnimated.value = true;
                              }),
                              const SizedBox(
                                height: 17,
                              ),
                              CustomContainer.customRightContainerButton(
                                  AppLogos.outboxLogo, null),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AudioWidget(audioPlayer: audioPlayer),
                            Container(
                              width: (width / 1.5),
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(35, 35)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ValueListenableBuilder(
                                            valueListenable: isClicked,
                                            builder: (BuildContext context,
                                                bool value, Widget? child) {
                                              return CustomContainer
                                                  .customBottomContainerButton(
                                                      context: context,
                                                      image:
                                                          favoriteLogos[index],
                                                      color: selectedIndex ==
                                                              index
                                                          ? activeIconColor
                                                          : inactiveIconColor,
                                                      borderWidth:
                                                          selectedIndex == index
                                                              ? 2.5
                                                              : 1,
                                                      width: width / 9,
                                                      height: width / 9);
                                            },
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const VerticalDivider(
                                                  width: 7,
                                                  color: Colors.transparent,
                                                ),
                                        itemCount: favoriteLogos.length)
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
                          child: BouncingAnimation(
                              duration: const Duration(milliseconds: 700),
                              isAnimated: isAnimated.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    AppStrings.unlike,
                                    style: CustomTextStyle.locationTextStyle,
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade800,
                                    size: 100,
                                  ),
                                ],
                              ),
                              onEnd: () {
                                isAnimated.value = false;
                              }),
                        );
                      },
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isEmojiPressed,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ValueListenableBuilder(
                      valueListenable: isEmojiAnimated,
                      builder: (BuildContext context, value, Widget? child) {
                        return Opacity(
                          opacity: isEmojiAnimated.value ? 1 : 0,
                          child: BouncingAnimation(
                              duration: const Duration(milliseconds: 700),
                              isAnimated: isEmojiAnimated.value,
                              child: Image.asset(AppLogos.emojiLogo),
                              onEnd: () {
                                isEmojiAnimated.value = false;
                              }),
                        );
                      },
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isSwiped,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ValueListenableBuilder(
                      valueListenable: isBrokenHeartAnimated,
                      builder: (BuildContext context, value, Widget? child) {
                        return Opacity(
                          opacity: isBrokenHeartAnimated.value ? 1 : 0,
                          child: BouncingAnimation(
                              duration: const Duration(milliseconds: 700),
                              isAnimated: isBrokenHeartAnimated.value,
                              child: Icon(
                                Icons.heart_broken,
                                color: Colors.red.shade800,
                                size: 100,
                              ),
                              onEnd: () {
                                isBrokenHeartAnimated.value = false;
                              }),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
        controller: controller,
      ),
    ));
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
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const Text('data');
        },
      );
}
