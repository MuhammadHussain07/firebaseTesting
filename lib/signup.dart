import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
 class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  String UID='';
GlobalKey _formkey=GlobalKey();
TextEditingController _emailcontroller = TextEditingController();
TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: ((context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                  snapshot) {

                   if (snapshot.hasData)
                   {

                    var data=snapshot.data!.docs;
                    print("has  data");
               
                  
                   return Container(
                    height: 300,
                    width: 300,
                    color:Colors.red,
                    child: ListView.builder(
                      itemCount:data.length,
                    itemBuilder: ((context, index) {
                    
                    return Padding(padding: EdgeInsets.all(8),
                    child: Container(
                       height: 300,
                    width: 300,
                    color:Colors.red,
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Name : "),
                              SizedBox(width: 5,),
                              Text('${data[index].get('Name')}'),
                            ],
                            
                          ),
                          SizedBox(
                            height: 5,
                          ),
                           Row(
                            children: [
                              Text("Email : "),
                              SizedBox(width: 5,),
                              Text('${data[index].get('email')}'),
                            ],
                            
                          ),
                          SizedBox(
                            height: 5,
                          ),
                           Row(
                            children: [
                              Text("Phone : "),
                              SizedBox(width: 5,),
                              Text('${data[index].get('phone')}'),
                            ],
                            
                          ),
                           SizedBox(
                            height: 5,
                          ),
                           Row(
                            children: [
                              Text("Age : "),
                              SizedBox(width: 5,),
                              Text('${data[index].get('age')}'),
                            ],
                            
                          ),
                        ],
                      ),
                    ),
                    ),
                    );  
                    }
                    ),
                     ),
                   );
                  }
                  return Text("No Data");
                  }
                  ),

                ),
                
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'email',
                    prefixIcon:Icon(Icons.email)
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordcontroller,
                  obscureText: true,
                   decoration: InputDecoration(
                    hintText: 'password',
                    prefixIcon:Icon(Icons.password)
                  ),
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Psddword';
                    }
                    return null;
                  },
                ),
              ],

            ),
            ),
            ElevatedButton(onPressed: (() {
              FirebaseFirestore.instance.collection('users').doc().set(
                {
                  'Name':'Mujahid',
                  'age':23,
                  'phone':0345958151,
                  'email':'gmk@gmail.com'
                },
              );
            }
            ),
            child: Text('Login')
            ),
        ],
        
      ),
      
    );
  }
}
