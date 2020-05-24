import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

const debug = true;

class Notes extends StatefulWidget {
  final TargetPlatform platform;

  Notes({Key key, this.title, this.platform}) : super(key: key);

  final String title;

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  
  final _documents = [
    {
      'name': 'Learning Android Studio',
      'link':
          'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
    },
    {
      'name': 'Android Programming Cookbook',
      'link':
          'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
    },
    {
      'name': 'iOS Programming Guide',
      'link':
          'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
    },
    {
      'name': 'Objective-C Programming (Pre-Course Workbook',
      'link':
          'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
    },
  ];

  List<_TaskInfo> _tasks;
  List<_ItemHolder> _items;
  bool _isLoading;
  bool _permissionReady;
  String _localPath;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      final task = _tasks?.firstWhere((task) => task.taskId == id);
      if (task != null) {
        setState(() {
          task.status = status;
          task.progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _permissionReady
              ? Container(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    children: _items
                        .map((item) => item.task == null
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18.0),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 8.0),
                                child: InkWell(
                                  onTap: item.task.status ==
                                          DownloadTaskStatus.complete
                                      ? () {
                                          _openDownloadedFile(item.task)
                                              .then((success) {
                                            if (!success) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Cannot open this file')));
                                            }
                                          });
                                        }
                                      : null,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 64.0,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                item.name,
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: _buildActionForTask(
                                                  item.task),
                                            ),
                                          ],
                                        ),
                                      ),
                                      item.task.status ==
                                                  DownloadTaskStatus.running ||
                                              item.task.status ==
                                                  DownloadTaskStatus.paused
                                          ? Positioned(
                                              left: 0.0,
                                              right: 0.0,
                                              bottom: 0.0,
                                              child: LinearProgressIndicator(
                                                value: item.task.progress / 100,
                                              ),
                                            )
                                          : Container()
                                    ].where((child) => child != null).toList(),
                                  ),
                                ),
                              ))
                        .toList(),
                  ),
                )
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'Please grant accessing storage permission to continue -_-',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            _checkPermission().then((hasGranted) {
                              setState(() {
                                _permissionReady = hasGranted;
                              });
                            });
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          _requestDownload(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              _pauseDownload(task);
            },
            child: Icon(
              Icons.pause,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _cancelDownload(task);
            },
            child:  Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            shape:  CircleBorder(),
            constraints:  BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          ),
        ],
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          _resumeDownload(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Ready',
            style: TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              _delete(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Text('Canceled', style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Failed', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              _retryDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _requestDownload(_TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(_TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
  }

  void _resumeDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _retryDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo task) {
    return FlutterDownloader.open(taskId: task.taskId);
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        Map<Permission, PermissionStatus> permissions = await [
          Permission.storage,
        ].request();
        if (permissions[Permission.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];
    _items = [];

    _tasks.addAll(_documents.map((document) =>
        _TaskInfo(name: document['name'], link: document['link'])));

    _items.add(_ItemHolder(name: 'Notes'));
    for (int i = count; i < _tasks.length; i++) {
      _items.add(_ItemHolder(name: _tasks[i].name, task: _tasks[i]));
      count++;
    }

    tasks?.forEach((task) {
      for (_TaskInfo info in _tasks) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    });

    _permissionReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}
