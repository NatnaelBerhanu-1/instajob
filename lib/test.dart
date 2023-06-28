// import 'package:flutter/material.dart';
// import 'package:insta_job/bloc/validation/validation_bloc.dart';
// import 'package:insta_job/globals.dart';
// import 'package:insta_job/screens/insta_job_user/SliderScreen/tellus_about_yslf_page.dart';
// import 'package:insta_job/screens/insta_job_user/SliderScreen/work_experience_screen.dart';
//
// class PageViewDemo extends StatefulWidget {
//   const PageViewDemo({Key? key}) : super(key: key);
//
//   @override
//   State<PageViewDemo> createState() => _PageViewDemoState();
// }
//
// class _PageViewDemoState extends State<PageViewDemo> {
//   // declare and initizlize the page controller
//   final PageController _pageController = PageController(initialPage: 0);
//
//   // the index of the current page
//   int _activePage = 0;
//
//   final List<Widget> subPage = [
//     const EducationScreen(),
//     const EducationScreen(isWork: true),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List _pages = [
//       const TellUsAboutYSlfPage(),
//       subPage,
//       Container(),
//     ];
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (int page) {
//               setState(() {
//                 _activePage = page;
//               });
//             },
//             itemCount: _pages.length,
//             itemBuilder: (BuildContext context, int index) {
//               return _pages[index % _pages.length];
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             height: 100,
//             child: Container(
//               color: Colors.black54,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List<Widget>.generate(
//                     _pages.length,
//                     (index) => Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: InkWell(
//                             onTap: () {
//                               _pageController.animateToPage(index,
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeIn);
//                             },
//                             child: CircleAvatar(
//                               radius: 8,
//                               backgroundColor: _activePage == index
//                                   ? Colors.amber
//                             : Colors.grey,
//                             ),
//                           ),
//                         )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Test extends StatelessWidget {
//   Test({Key? key}) : super(key: key);
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: TextEditingController(),
//               // validator: (val) =>
//               //     AppValidation.requiredValidation(val.toString(), ""),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                   } else {
//                     showToast("message");
//                   }
//                 },
//                 child: Text("child"))
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

/*import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/widgets/custom_cards/insta_job_user_cards/occupation_details_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _dateTime = DateTime.now();
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    print('DATETIME ----------  ${_dateTime}');
    return Scaffold(
        appBar: AppBar(
          title: Text("Time"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              hourMinute12H(date: _dateTime),
              */

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:insta_job/bloc/location_cubit/location_cubit.dart';
import 'package:insta_job/bloc/location_cubit/location_state.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  CameraController? _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _cameraController.dispose();
  //   super.dispose();
  // }

  _initCamera() async {
    print("############################################");
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController?.initialize();
    print("********************************");

    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController?.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(path: file!.path),
      );
      Navigator.push(context, route);
      print("PATH  ${file!.path}");
    } else {
      await _cameraController?.initialize();
      await _cameraController?.prepareForVideoRecording();
      await _cameraController?.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController!),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: MyColors.blue,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class VideoPage extends StatefulWidget {
  final String path;
  const VideoPage({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? videoPlayerController;
  initVideo() async {
    videoPlayerController = VideoPlayerController.file(File(widget.path));
    await videoPlayerController?.initialize();
    await videoPlayerController?.setLooping(true);
    await videoPlayerController?.play();
  }

  @override
  void initState() {
    // initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: initVideo(),
              builder: (c, state) {
                if (state.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  VideoPlayer(videoPlayerController!);
                }
                return Text("data");
              })),
    );
  }

  // @override
  // void dispose() {
  //   videoPlayerController?.dispose();
  //   super.dispose();
  // }
}

const kGoogleApiKey = "AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI";

class SearchAdd extends StatefulWidget {
  SearchAdd({Key? key}) : super(key: key);

  @override
  State<SearchAdd> createState() => _SearchAddState();
}

class _SearchAddState extends State<SearchAdd> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          BlocBuilder<LocationCubit, LocationInitial>(
              builder: (context, state) {
            return TypeAheadField(
                textFieldConfiguration:
                    TextFieldConfiguration(controller: controller),
                suggestionsCallback: (pattern) async {
                  return await context
                      .read<LocationCubit>()
                      .getLocation(controller.text);
                },
                itemBuilder: (c, location) {
                  return ListTile(
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                    title: Text("${location.description}"),
                  );
                },
                onSuggestionSelected: (pattern) {
                  controller.text = pattern.description.toString();
                  setState(() {});
                });
          })
        ],
      )),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  bool isCupertino = !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (!isCupertino) {
      return MaterialApp(
        title: 'flutter_typeahead demo',
        scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.phone_iphone),
                  onPressed: () => setState(() {
                    isCupertino = true;
                  }),
                ),
                title: TabBar(tabs: [
                  Tab(text: 'Example 1: Navigation'),
                  Tab(text: 'Example 2: Form'),
                  Tab(text: 'Example 3: Scroll'),
                  Tab(text: '4: Alternative Layout')
                ]),
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: TabBarView(children: [
                  NavigationExample(),
                  FormExample(),
                  ScrollExample(),
                  AlternativeLayoutArchitecture(),
                ]),
              )),
        ),
      );
    } else {
      return CupertinoApp(
        title: 'Cupertino demo',
        home: Scaffold(
          appBar: CupertinoNavigationBar(
            leading: IconButton(
              icon: Icon(Icons.android),
              onPressed: () => setState(() {
                isCupertino = false;
              }),
            ),
            middle: Text('Cupertino demo'),
          ),
          body: CupertinoPageScaffold(
            child: FavoriteCitiesPage(),
          ),
        ), //MyHomePage(),
      );
    }
  }
}

class NavigationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofillHints: ["AutoFillHints 1", "AutoFillHints 2"],
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you looking for?'),
            ),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, Map<String, String> suggestion) {
              return ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(suggestion['name']!),
                subtitle: Text('\$${suggestion['price']}'),
              );
            },
            itemSeparatorBuilder: (context, index) {
              return Divider();
            },
            onSuggestionSelected: (Map<String, String> suggestion) {
              Navigator.of(context).push<void>(MaterialPageRoute(
                  builder: (context) => ProductPage(product: suggestion)));
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 8.0,
              color: Theme.of(context).cardColor,
            ),
          ),
        ],
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  String? _selectedCity;

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // close the suggestions box when the user taps outside of it
      onTap: () {
        suggestionBoxController.close();
      },
      child: Container(
        // Add zero opacity to make the gesture detector work
        color: Colors.amber.withOpacity(0),
        // Create the form for the user to enter their favorite city
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Text('What is your favorite city?'),
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(labelText: 'City'),
                    controller: _typeAheadController,
                  ),
                  suggestionsCallback: (pattern) {
                    return CitiesService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, String suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  itemSeparatorBuilder: (context, index) {
                    return Divider();
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (String suggestion) {
                    _typeAheadController.text = suggestion;
                  },
                  suggestionsBoxController: suggestionBoxController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a city' : null,
                  onSaved: (value) => _selectedCity = value,
                ),
                Spacer(),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Your Favorite City is ${_selectedCity}'),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, String> product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              product['name']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              product['price']! + ' USD',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}

/// This example shows how to use the [TypeAheadField] in a [ListView] that
/// scrolls. The [TypeAheadField] will resize to fit the suggestions box when
/// scrolling.
class ScrollExample extends StatelessWidget {
  final List<String> items = List.generate(50, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Suggestion box will resize when scrolling"),
        ),
      ),
      SizedBox(height: 200),
      TypeAheadField<String>(
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'What are you looking for?'),
        ),
        suggestionsCallback: (String pattern) async {
          return items
              .where((item) =>
                  item.toLowerCase().startsWith(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        itemSeparatorBuilder: (context, index) {
          return Divider();
        },
        onSuggestionSelected: (String suggestion) {
          print("Suggestion selected");
        },
      ),
      SizedBox(height: 500),
    ]);
  }
}

/// This is a fake service that mimics a backend service.
/// It returns a list of suggestions after a 1 second delay.
/// In a real app, this would be a service that makes a network request.
class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {
        'name': query + index.toString(),
        'price': Random().nextInt(100).toString()
      };
    });
  }
}

/// A fake service to filter cities based on a query.
class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class FavoriteCitiesPage extends StatefulWidget {
  @override
  _FavoriteCitiesPage createState() => _FavoriteCitiesPage();
}

class _FavoriteCitiesPage extends State<FavoriteCitiesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  String favoriteCity = 'Unavailable';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _suggestionsBoxController.close(),
      child: Container(
        color: Colors.amber.withOpacity(0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Text('What is your favorite city?'),
                CupertinoTypeAheadFormField(
                  getImmediateSuggestions: true,
                  suggestionsBoxController: _suggestionsBoxController,
                  suggestionsBoxDecoration: CupertinoSuggestionsBoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  textFieldConfiguration: CupertinoTextFieldConfiguration(
                    controller: _typeAheadController,
                  ),
                  suggestionsCallback: (pattern) {
                    return Future.delayed(
                      Duration(seconds: 1),
                      () => CitiesService.getSuggestions(pattern),
                    );
                  },
                  itemBuilder: (context, String suggestion) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        suggestion,
                      ),
                    );
                  },
                  itemSeparatorBuilder: (context, index) {
                    return Divider();
                  },
                  onSuggestionSelected: (String suggestion) {
                    _typeAheadController.text = suggestion;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a city' : null,
                ),
                SizedBox(
                  height: 10.0,
                ),
                CupertinoButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        favoriteCity = _typeAheadController.text;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Your favorite city is $favoriteCity!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlternativeLayoutArchitecture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you looking for?'),
            ),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, Map<String, String> suggestion) {
              return ListTile(
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                leading: Icon(Icons.shopping_cart),
                title: Text(suggestion['name']!),
                subtitle: Text('\$${suggestion['price']}'),
              );
            },
            layoutArchitecture: (items, scrollContoller) {
              return ListView(
                  controller: scrollContoller,
                  shrinkWrap: true,
                  children: [
                    GridView.count(
                      physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 5 / 5,
                      shrinkWrap: true,
                      children: items.toList(),
                    ),
                  ]);
            },
            onSuggestionSelected: (Map<String, String> suggestion) {
              Navigator.of(context).push<void>(MaterialPageRoute(
                  builder: (context) => ProductPage(product: suggestion)));
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 8.0,
              color: Theme.of(context).cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
