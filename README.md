# video_player

## 프로젝트 개요

- video_player 플러그인 학습
- image_picker 플러그인 학습
- Stack 위젯
- AspectRatio 위젯

## 노트

- package
  - video_player
  - image_picker
    - 파일 권한을 얻어야 함 -> 라이브러리 문서에서 확인
    - ios:
      - ios -> Runner -> info.plist
      - 갤러리 권한: NSPhotoLibraryUsageDescription
      - 카메라 권한: NSCameraUsageDescription
      - 마이크 권한: NSMicrophoneUsageDescription
    - android:
      - android:requestLegacyExternalStorage="true"

videoplayer

- 갤러리의 이미지 또는 비디오를 ImagePicker로 가져온다
- XFile 데이터를 File경로로 변환하여 VideoPlayer로 재생한다
- aspectRatio

Slider

- min, max
- value
- onChanged

LifeCycle

- didUpdateWidget
  - 위젯의 상태가 변경되었을 경우 동작 정의

## error

- MissingPluginException
  - 제대로 플러그인이 설치가 안된것
  - flutter clean, flutter pub get, 앱 종료 후 다시 시작해보기
