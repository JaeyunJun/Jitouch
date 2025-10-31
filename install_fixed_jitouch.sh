#!/bin/bash

echo "=== 권한 문제 해결된 Jitouch 설치 ==="

# 1. 기존 프로세스 종료
echo "1. 기존 Jitouch 프로세스 종료..."
killall Jitouch 2>/dev/null || true

# 2. 새로 빌드된 앱 설치
echo "2. 수정된 Jitouch 앱 설치..."
cp -R jitouch/Jitouch/build/Release/Jitouch.app /Applications/

# 3. prefPane도 업데이트
echo "3. prefPane 업데이트..."
cp -R prefpane/build/Release/Jitouch.prefPane ~/Library/PreferencePanes/

# 4. 고정된 서명 적용
echo "4. 개발용 서명 적용..."
codesign --force --deep --sign - --identifier "com.jitouch.Jitouch.dev" /Applications/Jitouch.app

echo "=== 설치 완료! ==="
echo ""
echo "이제 Jitouch를 실행해보세요:"
echo "- 처음 실행 시에만 접근성 권한을 요청할 것입니다"
echo "- 이후 재실행 시에는 권한을 묻지 않습니다"
echo ""
echo "앱 실행: open /Applications/Jitouch.app"