# nordic_id

A Flutter plugin for Nordic ID Device to read RFID/UHF tags

## Project Setup

#### Add to Android Project:

#### In the Manifest section add:

1- Add to `<manifest>` tag
`xmlns:tools="http://schemas.android.com/tools`

2- Add permissions inside `<mainfest>` tag before `<application>` tag

```
    <uses-permission
        android:name="android.permission.BLUETOOTH"
        android:maxSdkVersion="30" />
    <uses-permission
        android:name="android.permission.BLUETOOTH_ADMIN"
        android:maxSdkVersion="30" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />

    <uses-permission
        android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="29" />
    <uses-permission
        android:name="android.permission.READ_EXTERNAL_STORAGE"
        android:maxSdkVersion="29" />
    <uses-permission
        android:name="android.permission.MANAGE_EXTERNAL_STORAGE"
        tools:ignore="ScopedStorage" />

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.NFC" />

    <uses-feature
        android:name="android.hardware.nfc"
        android:required="false" />
```

3- Add to `<application>` tag
`tools:replace="android:label"`

4-Add inside `<application>` tag
```


<activity
        android:name="com.nordicid.nurapi.NurDeviceListActivity"
        android:exported="true"
        android:label="@string/app_name"
        android:theme="@android:style/Theme.Dialog" />

<service
        android:name="com.nordicid.nurapi.UartService"
        android:enabled="true"
        android:exported="true" />
```


#### In the `build.gradle` section add:

1- In `defaultConfig` section add
`minSdkVersion 21`


#### In the `strings.xml` section add:

The file in `android/app/src/main/res/values/strings.xml`
Add the following tag BUT with your app name:
<resources>
    <string name="app_name">App Name</string>
</resources>

#### Add libs to your app:
Copy from my library github the libs folder:
https://github.com/amorenew/nordic_id/tree/main/example/android/app/libs
and put the libs folder in your project in the app folder `android/app/`

Then in your build.gradle in `android/app/` folder go to `dependencies` section and add the following libraries 

```
implementation files('libs/NurApiAndroid/NurApiAndroid.aar')
implementation files('libs/NurDeviceUpdate/NurDeviceUpdate.aar')
implementation files('libs/NurSmartPair/NurSmartPair.aar')
```

### Usage

#### Library Pub link
https://pub.dev/packages/nordic_id

- Import the library:
```
import 'package:nordic_id/nordic_id.dart';
import 'package:nordic_id/tag_epc.dart';
```


- Initialize the Nordic ID reader
  `await NordicId.initialize;`

- Open connection to the Nordic ID reader
    `await NordicId.connect`

- Refresh and Start tracing/reading the ids/cards
    `await NordicId.refreshTracing`

- Stop tracing/reading the ids/cards
    `await NordicId.stopTrace`
    
- Is connected and can start tracing/reading the ids/cards
    `bool? isConnected = await NordicId.isConnected`

- Listen to connection status
   
   ```dart
    NordicId.connectionStatusStream
    .receiveBroadcastStream()
    .listen(updateConnection);

    bool isConnectedStatus = false;
    void updateConnection(dynamic result) {
    setState(() {
      isConnectedStatus = result;
    });
  }
   ```
   - Listen to tags status

   ```dart
   NordicId.tagsStatusStream
   .receiveBroadcastStream()
   .listen(updateTags);

   List<TagEpc> _data = [];
   void updateTags(dynamic result) {
       setState(() {
           _data = TagEpc.parseTags(result);
        });
      }
   ```

