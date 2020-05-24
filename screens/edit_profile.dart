import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/students.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/Edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _emailIdFocusNode = FocusNode();
  final _parentNameFocusNode = FocusNode();
  final _mobileNumberFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Students _edits;
  Student _editProfile;

  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'id': '',
    'name': '',
    'parentName': '',
    'mobileNumber': '',
    'emailId': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _edits = Provider.of<Students>(context);
      _editProfile = _edits.items[0];
      _initValues = {
        'id': _editProfile.id,
        'name': _editProfile.name,
        'parentName': _editProfile.parentName,
        'emailId': _editProfile.emailId,
        'mobileNumber': _editProfile.mobileNumber,
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _parentNameFocusNode.dispose();
    _emailIdFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editProfile.id != null) {
      await Provider.of<Students>(context, listen: false)
          .updateProfile(_editProfile.id, _editProfile);
      Navigator.of(context).pop();
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error Occured'),
          content: Text('Something Went Wrong'),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
            // onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailIdFocusNode);
                      },
                      onSaved: (value) {
                        _editProfile = Student(
                            id: _editProfile.id,
                            name: value,
                            parentName: _editProfile.parentName,
                            imageUrl: _editProfile.imageUrl,
                            emailId: _editProfile.emailId,
                            mobileNumber: _editProfile.mobileNumber);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['emailId'],
                      decoration: InputDecoration(labelText: 'emailId'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailIdFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_mobileNumberFocusNode);
                      },
                      onSaved: (value) {
                        _editProfile = Student(
                            id: _editProfile.id,
                            name: _editProfile.name,
                            parentName: _editProfile.parentName,
                            imageUrl: _editProfile.imageUrl,
                            emailId: value,
                            mobileNumber: _editProfile.mobileNumber);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['mobileNumber'],
                      decoration: InputDecoration(labelText: 'mobileNumber'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _mobileNumberFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_parentNameFocusNode);
                      },
                      onSaved: (value) {
                        _editProfile = Student(
                            id: _editProfile.id,
                            name: _editProfile.name,
                            parentName: _editProfile.parentName,
                            imageUrl: _editProfile.imageUrl,
                            emailId: _editProfile.emailId,
                            mobileNumber: int.parse(value).toString());
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['parentName'],
                      decoration: InputDecoration(labelText: 'Parent Name'),
                      focusNode: _parentNameFocusNode,
                      onSaved: (value) {
                        _editProfile = Student(
                            id: _editProfile.id,
                            name: _editProfile.name,
                            parentName: value,
                            imageUrl: _editProfile.imageUrl,
                            emailId: _editProfile.emailId,
                            mobileNumber: _editProfile.mobileNumber);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
