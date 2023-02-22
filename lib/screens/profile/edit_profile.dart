import 'package:digi_store/controllers/auth_controller.dart';
import 'package:digi_store/controllers/user_controller.dart';
import 'package:digi_store/models/user.dart';
import 'package:digi_store/widgets/auth_button.dart';
import 'package:digi_store/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final User user;
  EditProfile({super.key, required this.user}) {
    authController.textEditingControllerEmail.text = user.email!;
    authController.textEditingControllerName.text = user.username!;
    authController.textEditingControllerPhone.text = user.phone!;
  }
  UserController userController = Get.find<UserController>();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    user.profileImage == ""
                        ? CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              "assets/images/profile.jpeg",
                            ))
                        : CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              user.profileImage!,
                            ),
                          ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Text(
                                            "Select Picture",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Get.back();
                                                userController.getImage(
                                                    type: "camera");
                                              },
                                              child: Text("Camera")),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Get.back();
                                                userController.getImage(
                                                    type: "gallery");
                                              },
                                              child: Text("Gallery"))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              smallTitle(title: "UserName", color: Colors.grey, size: 10),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: authController.textEditingControllerName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.green),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              smallTitle(title: "Email", color: Colors.grey, size: 10),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: authController.textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              smallTitle(title: "Phone", color: Colors.grey, size: 10),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: authController.textEditingControllerPhone,
                keyboardType: TextInputType.number,
                inputFormatters: [],
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.phone, color: Colors.green),
                  fillColor: Colors.grey.withOpacity(0.2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: 30),
              authButton(
                  widget: Center(
                    child: Text(
                      "Save Changes".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
