import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helpers/currency_api.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAndroid = true;
  String FromCountry = "USD";
  String ToCountry = "INR";
  int Amount = 0;
  int FromCon = 0;
  int ToCon = 0;

  late String _chosenValue;
  bool _isBackPressedOrTouchedOutSide = false;
  bool _isDropDownOpened = false;
  bool _isPanDown = false;
  bool _navigateToPreviousScreenOnIOSBackPress = true;

  String selectedCountry = 'Select Country Code';

  List<String> currencyCode = [
    'INR',
    'USD',
    'RUB',
    'ALL',
    'AFN',
    'THB',
    'EUR',
  ];

  @override
  Widget build(BuildContext context) {
    return (isAndroid)
        ? MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: Builder(builder: (context) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: Colors.deepPurple.shade50,
                  actions: [
                    Switch.adaptive(
                      value: isAndroid,
                      activeColor: Colors.blue.shade800,
                      onChanged: (val) {
                        setState(() {
                          isAndroid = false;
                        });
                      },
                    ),
                  ],
                ),
                backgroundColor: Colors.deepPurple.shade50,
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Currency",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const Text(
                        "Converter",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "From",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AwesomeDropDown(
                        isPanDown: _isPanDown,
                        dropDownList: currencyCode,
                        selectedItem: FromCountry,
                        onDropDownItemClick: (From) {
                          setState(() {
                            FromCountry = From;
                          });
                        },
                        dropStateChanged: (isOpened) {
                          _isDropDownOpened = isOpened;
                          if (!isOpened) {
                            _isBackPressedOrTouchedOutSide = false;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "To",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AwesomeDropDown(
                        isPanDown: _isPanDown,
                        dropDownList: currencyCode,
                        selectedItem: ToCountry,
                        onDropDownItemClick: (To) {
                          setState(() {
                            ToCountry = To;
                          });
                        },
                        dropStateChanged: (isOpened) {
                          _isDropDownOpened = isOpened;
                          if (!isOpened) {
                            _isBackPressedOrTouchedOutSide = false;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(
                              () {
                                Amount = int.parse(val);
                              },
                            );
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: const Text(
                              "Amount",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: FutureBuilder(
                                    future: ApiHelper.apiHelper.CurrencyApi(
                                      From: FromCountry,
                                      To: ToCountry,
                                      amount: Amount,
                                    ),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasError) {
                                        return Text("${snapShot.error}");
                                      } else if (snapShot.hasData) {
                                        Map? P = snapShot.data;
                                        return Text(
                                          "${P!['new_amount']}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      }
                                      return const Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ToCountry,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : CupertinoApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    backgroundColor: Colors.deepPurple.shade50,
                    trailing: Switch.adaptive(
                        value: isAndroid,
                        onChanged: (val) {
                          setState(() {
                            isAndroid = true;
                          });
                        }),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 90,
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Currency",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                          const Text(
                            "Converter",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                          //From
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "From",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int Select) {
                                setState(() {
                                  FromCon = Select;
                                });
                              },
                              children: List.generate(
                                currencyCode.length,
                                (int index) => Text(
                                  currencyCode[index],
                                ),
                              ),
                            ),
                          ),
                          //To
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text(
                              "To",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (val) {
                                setState(() {
                                  ToCon = val;
                                  // Globals.ToCountry = val.toString();
                                });
                              },
                              children: List.generate(
                                currencyCode.length,
                                (int index) => Text(
                                  currencyCode[index],
                                ),
                              ),
                            ),
                          ),
                          CupertinoTextField(
                            onChanged: (val) {
                              setState(() {
                                Amount = int.parse(val);
                              });
                            },
                            keyboardType: TextInputType.number,
                            placeholder: "Amount",
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: FutureBuilder(
                                        future: ApiHelper.apiHelper.CurrencyApi(
                                          From: FromCountry,
                                          To: ToCountry,
                                          amount: Amount,
                                        ),
                                        builder: (context, snapShot) {
                                          if (snapShot.hasError) {
                                            return Text("${snapShot.error}");
                                          } else if (snapShot.hasData) {
                                            Map? P = snapShot.data;
                                            return Text(
                                              "${P!['new_amount']}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          }
                                          return const Text(
                                            "Result",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      currencyCode[ToCon],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
  }
}
