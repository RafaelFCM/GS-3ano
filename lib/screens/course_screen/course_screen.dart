import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:pharmaconnect_project/screens/test_screen/test_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class CourseScreen extends StatefulWidget {
  final int courseId;
  final int userId;

  CourseScreen({required this.courseId, required this.userId});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late YoutubePlayerController _controller;
  int _currentLessonIndex = 0;
  List<Map<String, dynamic>> lessons = [];
  bool _isLessonSeen = false;
  bool _allLessonsCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadLessons();
    _checkAllLessonsCompleted();
  }

  Future<void> _loadLessons() async {
    final loadedLessons = await DBService().getLessons(widget.courseId);
    if (loadedLessons.isNotEmpty) {
      setState(() {
        lessons = loadedLessons;
        _initializeVideoController(_currentLessonIndex);
      });
    }
  }

  Future<void> _checkAllLessonsCompleted() async {
    final allSeen =
        await DBService().areAllLessonsSeen(widget.userId, widget.courseId);
    setState(() {
      _allLessonsCompleted = allSeen;
    });
  }

  void _initializeVideoController(int index) {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(lessons[index]['videoUrl']!)!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        if (_controller.value.position >= _controller.metadata.duration) {
          setState(() {
            _isLessonSeen = true;
          });
        }
      });
  }

  Future<void> _markLessonAsSeen(int lessonId) async {
    await DBService()
        .markLessonAsSeen(widget.userId, widget.courseId, lessonId);
    await _updateCourseProgress();
    await _checkAllLessonsCompleted();
    setState(() {
      _isLessonSeen = false;
    });
  }

  Future<void> _updateCourseProgress() async {
    final totalLessons = lessons.length;
    final seenLessons =
        await DBService().getSeenLessonsCount(widget.userId, widget.courseId);
    final progress = (seenLessons / totalLessons) *
        0.9; // Adjusting progress to go up to 0.9
    await DBService()
        .updateUserCourseProgress(widget.userId, widget.courseId, progress);
  }

  void _loadLesson(int index) {
    setState(() {
      _currentLessonIndex = index;
      _isLessonSeen = false;
      _controller
          .load(YoutubePlayer.convertUrlToId(lessons[index]['videoUrl']!)!);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Curso'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          _controller.addListener(() {
            if (_controller.value.isFullScreen) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
            }
          });
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(lessons[_currentLessonIndex]['title']),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lessons[_currentLessonIndex]['title'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(lessons[_currentLessonIndex]['description']),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _isLessonSeen
                    ? () async {
                        await _markLessonAsSeen(
                            lessons[_currentLessonIndex]['lessonsId']);
                        if (_currentLessonIndex < lessons.length - 1) {
                          _loadLesson(_currentLessonIndex + 1);
                        }
                      }
                    : null,
                child: Text('Vi a Lição'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLessonSeen ? Colors.green : Colors.grey,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    var lesson = lessons[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: ListTile(
                        title: Text(lesson['title']),
                        subtitle: Text(lesson['description']),
                        trailing: Icon(Icons.play_arrow),
                        selected: _currentLessonIndex == index,
                        onTap: () {
                          _loadLesson(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _allLessonsCompleted
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(
                                courseId: widget.courseId,
                                userId: widget.userId,
                                onComplete: () async {
                                  await DBService().updateUserCourseProgress(
                                      widget.userId, widget.courseId, 1.0);
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text('Fazer Avaliação'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _allLessonsCompleted ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
