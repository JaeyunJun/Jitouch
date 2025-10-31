#!/bin/bash

# Jitouch 권한 문제 해결 스크립트

echo "=== Jitouch 권한 문제 해결 중 ==="

# 1. 기존 프로세스 종료
echo "1. 기존 Jitouch 프로세스 종료..."
killall Jitouch 2>/dev/null || true

# 2. 앱 백업
echo "2. 현재 앱 백업..."
if [ -d "/Applications/Jitouch.app" ]; then
    cp -R /Applications/Jitouch.app /tmp/Jitouch_backup.app
fi

# 3. 새 앱 설치
echo "3. 새 앱 설치..."
cp -R prefpane/build/Release/Jitouch.prefPane/Contents/Resources/Jitouch.app /Applications/

# 4. 고정된 번들 식별자와 버전으로 수정
echo "4. 앱 메타데이터 고정..."
cat > /Applications/Jitouch.app/Contents/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>Jitouch</string>
	<key>CFBundleIconFile</key>
	<string>jitouchicon.icns</string>
	<key>CFBundleIdentifier</key>
	<string>com.jitouch.Jitouch.dev</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>Jitouch</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>2.82.1-dev</string>
	<key>CFBundleSignature</key>
	<string>JiDv</string>
	<key>CFBundleVersion</key>
	<string>2.82.1.999</string>
	<key>LSApplicationCategoryType</key>
	<string>public.app-category.utilities</string>
	<key>LSMinimumSystemVersion</key>
	<string>10.13</string>
	<key>NSAppleEventsUsageDescription</key>
	<string>Jitouch needs Apple Events access to control other applications.</string>
	<key>NSHumanReadableCopyright</key>
	<string>Copyright © 2021 Supasorn Suwajanakorn and Sukolsak Sakshuwong. All rights reserved.</string>
	<key>NSMainNibFile</key>
	<string>MainMenu</string>
	<key>NSPrincipalClass</key>
	<string>NSApplication</string>
	<key>NSUIElement</key>
	<string>1</string>
</dict>
</plist>
EOF

# 5. 고정된 서명 적용
echo "5. 고정된 개발 서명 적용..."
codesign --force --deep --sign - --identifier "com.jitouch.Jitouch.dev" /Applications/Jitouch.app

# 6. 권한 데이터베이스에서 이전 항목 제거
echo "6. 권한 데이터베이스 정리..."
sudo tccutil reset Accessibility com.jitouch.Jitouch 2>/dev/null || true
sudo tccutil reset Accessibility com.jitouch.Jitouch.dev 2>/dev/null || true

# 7. prefPane도 업데이트
echo "7. prefPane 업데이트..."
cp -R prefpane/build/Release/Jitouch.prefPane ~/Library/PreferencePanes/

echo "=== 완료! ==="
echo ""
echo "이제 다음 단계를 수행하세요:"
echo "1. 시스템 설정 > 개인정보 보호 및 보안 > 접근성"
echo "2. Jitouch를 찾아서 체크박스 활성화"
echo "3. 앱 실행: open /Applications/Jitouch.app"
echo ""
echo "앞으로는 이 스크립트로 업데이트하면 권한을 다시 묻지 않을 것입니다."