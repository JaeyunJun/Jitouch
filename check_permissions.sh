#!/bin/bash

echo "=== Jitouch 권한 상태 확인 ==="
echo ""

# 1. 프로세스 상태 확인
echo "1. Jitouch 프로세스 상태:"
JITOUCH_PID=$(pgrep -f "Jitouch")
if [ -n "$JITOUCH_PID" ]; then
    echo "   ✅ Jitouch가 실행 중입니다 (PID: $JITOUCH_PID)"
else
    echo "   ❌ Jitouch가 실행되지 않았습니다"
fi
echo ""

# 2. 접근성 권한 확인 (간접적)
echo "2. 접근성 권한 상태:"
# TCC 데이터베이스에서 확인 시도
ACCESSIBILITY_STATUS=$(sqlite3 ~/Library/Application\ Support/com.apple.TCC/TCC.db "SELECT allowed FROM access WHERE service='kTCCServiceAccessibility' AND client LIKE '%jitouch%' OR client LIKE '%Jitouch%';" 2>/dev/null | head -1)

if [ "$ACCESSIBILITY_STATUS" = "1" ]; then
    echo "   ✅ 접근성 권한이 허용되어 있습니다"
elif [ "$ACCESSIBILITY_STATUS" = "0" ]; then
    echo "   ❌ 접근성 권한이 거부되어 있습니다"
else
    echo "   ⚠️  권한 상태를 확인할 수 없습니다 (시스템 설정에서 직접 확인하세요)"
fi
echo ""

# 3. 권한 상태 확인 완료
echo "3. 권한 상태 확인 완료"
echo ""

# 4. 권한 문제 해결 방법 안내
echo "4. 문제 해결 방법:"
echo "   - 시스템 설정 > 개인정보 보호 및 보안 > 접근성"
echo "   - Jitouch 항목을 찾아서 체크박스 활성화"
echo "   - 또는 터미널에서: sudo tccutil reset Accessibility com.jitouch.Jitouch"
echo ""

echo "=== 확인 완료 ==="