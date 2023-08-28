import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int userRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate the Application'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'How would you rate us?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          userRating = i; // Update the user's rating
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: 40.0,
                        color: i <= userRating ? Colors.orange : Colors.grey,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Please tell people about your experience:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt('userRating', userRating);

                  Navigator.pop(
                      context, userRating); // Pass the userRating as the result
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
