#!/bin/bash

# 간단한 Jitouch 업데이트 스크립트 (권한 유지)

echo "Jitouch 업데이트 중..."

# 프로세스 종료
killall Jitouch 2>/dev/null || true

# 바이너리만 교체 (메타데이터 유지)
echo "바이너리 업데이트..."
cp prefpane/build/Release/Jitouch.prefPane/Contents/Resources/Jitouch.app/Contents/MacOS/Jitouch /Applications/Jitouch.app/Contents/MacOS/

# prefPane 업데이트
echo "prefPane 업데이트..."
cp -R prefpane/build/Release/Jitouch.prefPane ~/Library/PreferencePanes/

# 서명 다시 적용 (같은 식별자로)
codesign --force --deep --sign - --identifier "com.jitouch.Jitouch.dev" /Applications/Jitouch.app

echo "업데이트 완료! 앱을 실행하세요."
open /Applications/Jitouch.app