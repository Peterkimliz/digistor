import 'package:digi_store/controllers/auth_controller.dart';
import 'package:digi_store/screens/products/favourite_page.dart';
import 'package:digi_store/screens/user/adress/address_page.dart';
import 'package:digi_store/widgets/big_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: bigTitle(
          title: "Account",
          color: Colors.black,
        ),
        actions: [
          InkWell(
            onTap: () => Get.to(() => FavouritePage()),
            child: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.notifications_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: Colors.pink.withOpacity(0.2))),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/162712/egg-white-food-protein-162712.jpeg?auto=compress&cs=tinysrgb&w=600",
                                  ))),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.25 - 30,
                          child:
                              authController.currentUser.value!.profileImage ==
                                      ""
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        "assets/images/profile.jpeg",
                                      ))
                                  : CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        authController
                                            .currentUser.value!.profileImage!,
                                      ),
                                    ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            "${authController.currentUser.value!.username!}"
                                .capitalize!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(authController.currentUser.value!.email!,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () => Get.to(() => AddressPage()),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                  ),
                                  Text("Address")
                                ],
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Icon(
                                  Icons.book,
                                  color: Colors.black,
                                ),
                                Text("My Order")
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
              color: Colors.pink.withOpacity(0.2),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  profileItems(
                      icon: Icons.person_outlined,
                      title: "Edit Profile",
                      onpressed: () {}),
                  SizedBox(height: 20),
                  profileItems(
                      icon: Icons.lock_outline,
                      title: "Edit Password",
                      onpressed: () {}),
                  SizedBox(height: 20),
                  profileItems(
                      icon: Icons.favorite_outline,
                      title: "Favourite List",
                      onpressed: () => Get.to(() => FavouritePage())),
                  SizedBox(height: 20),
                  profileItems(
                      icon: Icons.notifications_outlined,
                      title: "Notifications",
                      onpressed: () {}),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 16,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Logout", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profileItems(
      {required IconData icon,
      required title,
      required VoidCallback onpressed}) {
    return InkWell(
      onTap: () => onpressed(),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.black54,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "$title",
            style: TextStyle(color: Colors.black54),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
