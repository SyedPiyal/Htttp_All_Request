import 'package:flutter/material.dart';
import '../http_requests/service.dart';
import '../model/post.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late Future<List<Post>> _futurePosts;

  // To track the status of the fetch request
  String _fetchStatus = '';

  @override
  void initState() {
    super.initState();
    // We don't fetch the data here initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //------------------------------
              // get request button
              //------------------------------

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Fetch data when the button is clicked
                    _futurePosts = PostService().fetchPosts();
                    // Reset fetch status
                    _fetchStatus = '';
                  });
                },
                child: const Text('Get'),
              ),

              //------------------------------
              // post request button
              //------------------------------

              ElevatedButton(
                onPressed: () async {
                  // Create a new post
                  Post newPost = Post(
                    userId: 1, // Example userId
                    id: null, // The server will assign an ID
                    title: 'New Post', // Example title
                    body: 'This is the body of the new post.', // Example body
                  );

                  try {
                    await PostService()
                        .createPost(newPost); // Make the post request
                    setState(() {
                      _fetchStatus = 'Success'; // Update fetch status
                    });
                  } catch (e) {
                    setState(() {
                      _fetchStatus = 'Failed'; // Update fetch status
                    });
                  }
                },
                child: const Text('Post'),
              ),

              //------------------------------
              // update request button
              //------------------------------

              ElevatedButton(
                onPressed: () async {
                  // Create an updated post
                  Post updatedPost = Post(
                    userId: 1, // Example userId
                    id: 1, // Example ID of the post to be updated
                    title: 'Updated Post', // Example updated title
                    body:
                        'This is the updated body of the post.', // Example updated body
                  );

                  try {
                    await PostService()
                        .updatePost(updatedPost); // Make the update request
                    setState(() {
                      _fetchStatus = 'Success'; // Update fetch status
                    });
                  } catch (e) {
                    setState(() {
                      _fetchStatus = 'Failed'; // Update fetch status
                    });
                  }
                },
                child: const Text('Update'),
              ),

              //------------------------------
              // delete request button
              //------------------------------

              ElevatedButton(
                onPressed: () async {
                  // ID of the post to be deleted
                  int postIdToDelete = 1; // Example post ID

                  try {
                    // Make the delete request
                    await PostService().deletePost(postIdToDelete);
                    setState(() {
                      _fetchStatus = 'Success'; // Update fetch status
                    });
                  } catch (e) {
                    setState(() {
                      _fetchStatus = 'Failed'; // Update fetch status
                    });
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _fetchStatus.isNotEmpty ? _fetchStatus : "Result",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (_fetchStatus.isNotEmpty)
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Post post = snapshot.data![index];
                        return ListTile(
                          title: Text(post.title ?? ''),
                          subtitle: Text(post.body ?? ''),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  // Return an empty container by default
                  return Container();
                },
              ),
            ),
        ],
      ),
    );
  }
}
