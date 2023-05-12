import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/utils/availabilityColorFunction.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

import '../../models/stationModel.dart';

class FavouriteSceen extends StatefulWidget {
  String userId;
  FavouriteSceen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => FavouriteSceenState();
}

class FavouriteSceenState extends State<FavouriteSceen> {
  List<FovouriteStationDetailsModel> favouriteList = [];

  Future<void> getFavouriteList() async {
    try {
      // var data = await GetMethod.getRequest(
      //     'http://192.168.0.243:8097/manageUser/getFavorites?userId=${widget.userId}');
      var data = await GetMethod.getRequest(
          'http://192.168.0.41:8097/manageUser/getFavorites?userId=USR20230420100343328');
      if (data != null && data.isNotEmpty) {
        favouriteList.clear();
        setState(() {
          for (int i = 0; i < data.length; i++) {
            favouriteList.add(FovouriteStationDetailsModel.fromJson(data[i]));
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Favourites'),
        ),
        body: favouriteList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: favouriteList.length,
                itemBuilder: (contexr, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StationsSpecificDetails(
                                  userId: widget.userId,
                                  stationId: favouriteList[index].stationId!)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                          vertical: Get.width * 0.02,
                          horizontal: Get.width * 0.02),
                      color: Color.fromARGB(255, 228, 249, 255),
                      child: Padding(
                          padding: EdgeInsets.all(Get.width * 0.01),
                          child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: Row(
                              children: [
                                //Column for station name and address
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //station Name
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.002),
                                        child: Text(
                                          favouriteList[index].stationName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Get.width * 0.045),
                                        ),
                                      ),

                                      //station address
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.008),
                                        child: Text(
                                          '${favouriteList[index].stationCity}, ${favouriteList[index].stationAddressLineOne}',
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 132, 132, 132)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //Column for station Status and number of chargers
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        //station status
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.008),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: AvaliblityColor
                                                .getAvailablityColor(
                                                    favouriteList[index]
                                                        .stationStatus!),
                                          ),
                                        ),

                                        //station number of chargers
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.008),
                                          child: Text(
                                            'Chargers: 2/3',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          )),
                    ),
                  );
                }),
      ),
    );
  }
}



/*
ListTile(
                        //leading
                        leading: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    AvaliblityColor.getAvailablityColor(
                                        favouriteList[index].stationStatus!),
                              )
                            ]),

                        //title
                        title: Padding(
                          padding: EdgeInsets.symmetric(vertical: Get.height * 0.008),
                          child: Text(
                            favouriteList[index].stationName!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        //subtitle
                        subtitle: Padding(
                          padding: EdgeInsets.symmetric(vertical: Get.height * 0.008),
                          child: Text(
                            '${favouriteList[index].stationCity}, ${favouriteList[index].stationAddressLineOne}',
                            maxLines: 2,
                          ),
                        ),
                      ),
*/
