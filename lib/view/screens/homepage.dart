import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; // Required for BackdropFilter

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data = [];

  getData() {
    rootBundle.loadString("assets/planets.json").then((response) {
      setState(() {
        data = json.decode(response);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: NetworkImage("https://i.pinimg.com/736x/8a/0e/d2/8a0ed2f012ee4fd971a230c7d6f29360.jpg"),
                image: NetworkImage("https://st.depositphotos.com/27201292/53650/i/450/depositphotos_536500110-stock-photo-vertical-shot-milky-way-starry.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child:  Center(
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Galaxy Planet',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed("Like");
                        }, icon: Icon(Icons.favorite),color: Colors.white,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'Detailpage', arguments: item);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    // Planet Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item['image'],
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    // Planet Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Distance: ${item['distance']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
