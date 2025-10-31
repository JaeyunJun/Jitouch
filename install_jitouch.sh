#!/bin/bash

# Jitouch 설치 스크립트
echo "Jitouch 설치 중..."

# 기존 프로세스 종료
echo "기존 Jitouch 프로세스 종료..."
killall Jitouch 2>/dev/null || true

# 기존 파일 백업 (권한 유지를 위해)
if [ -d "/Applications/Jitouch.app" ]; then
    echo "기존 앱 백업..."
    cp -p /Applications/Jitouch.app/Contents/Info.plist /tmp/jitouch_info_backup.plist 2>/dev/null || true
fi

# 새 파일 설치
echo "새 파일 설치..."
cp -R prefpane/build/Release/Jitouch.prefPane ~/Library/PreferencePanes/
cp -R prefpane/build/Release/Jitouch.prefPane/Contents/Resources/Jitouch.app /Applications/

# 권한 정보 복원 시도
if [ -f "/tmp/jitouch_info_backup.plist" ]; then
    echo "권한 정보 복원 시도..."
    # 같은 번들 ID와 버전을 유지
    cp /tmp/jitouch_info_backup.plist /Applications/Jitouch.app/Contents/Info.plist 2>/dev/null || true
    rm /tmp/jitouch_info_backup.plist 2>/dev/null || true
fi

# 권한 확인
echo "설치 완료!"
echo "만약 접근성 권한을 다시 요구하면:"
echo "1. 시스템 설정 > 개인정보 보호 및 보안 > 접근성"
echo "2. Jitouch 체크 해제 후 다시 체크"
echo "3. 또는 터미널에서: sudo tccutil reset Accessibility com.jitouch.Jitouch"

# 앱 실행
echo "Jitouch 실행..."
open /Applications/Jitouch.app