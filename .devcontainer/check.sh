#!/usr/bin/env bash
# OSTEP homework 실습 환경 점검 (학생 Codespace용)
ROOT=${ROOT:-/workspaces/ostep-codespace-lab}
HW="$ROOT/ext/ostep-homework"; CODE="$ROOT/ext/ostep-code"
PASS=0; FAIL=0; LOG=/tmp/ostep-check.log; : > "$LOG"
ok(){ printf '  [PASS] %s\n' "$1"; PASS=$((PASS+1)); }
ng(){ printf '  [FAIL] %s  <- %s\n' "$1" "$2"; FAIL=$((FAIL+1)); }
run(){ d=$1; shift; out=$("$@" 2>&1); rc=$?; echo "== $d (rc=$rc)" >> "$LOG"; echo "$out" >> "$LOG"
  if [ $rc -eq 0 ]; then ok "$d"; else ng "$d" "$(echo "$out" | grep -v '^\s*$' | tail -1)"; fi; }

echo "[1] 기본 환경"
run "Ubuntu 24.04"            grep -qx 'VERSION_CODENAME=noble' /etc/os-release
run "python 명령 = Python 3"  sh -c 'python --version 2>&1 | grep -q "^Python 3"'
run "tkinter"                 python3 -c 'import tkinter'
for t in gcc make gdb strace ltrace valgrind vmstat; do run "$t 설치" sh -c "command -v $t"; done
run "gdb로 프로그램 실행"      sh -c 'gdb -batch -ex run --args /bin/true 2>&1 | grep -q "exited normally"'
run "strace 권한"             strace -o /dev/null /bin/true

echo "[2] 저장소와 homework 코드"
run "저장소 폴더"             test -d "$ROOT/.git"
run "origin이 학생 fork"      sh -c "git -C '$ROOT' remote get-url origin | grep -vq 'github.com/pythonandbenjamin/'"
run "ext/ostep-homework"      test -d "$HW/.git"
run "ext/ostep-code"          test -d "$CODE/.git"
run "homework 버전 afb36ca"   sh -c "git -C '$HW' rev-parse --short=7 HEAD | grep -qx afb36ca"
run "ext/는 git 추적 제외"    git -C "$ROOT" check-ignore -q ext

# 원본 ext 폴더를 건드리지 않도록 임시 복사본에서 점검
T=/tmp/ostep-check; rm -rf "$T"; mkdir -p "$T"
[ -d "$HW" ] && cp -r "$HW" "$T/hw"; [ -d "$CODE" ] && cp -r "$CODE" "$T/code"

echo "[3] Python 시뮬레이터 (README 예시 옵션 + -c)"
if [ -d "$T/hw" ]; then
  cd "$T/hw"
  for f in */*.py; do
    dir=${f%/*}; py=${f#*/}
    case "$f" in
      file-raid/raid-graphics.py) echo "  [SKIP] $f  (Python 2 전용 그래픽 버전)"; continue;;
      file-ffs/ffs.py) args="-f in.example1 -c";;
      cpu-intro/process-run.py|file-devices/process-run.py) args="-l 5:100 -c";;
      file-implementation/vsfs.py) args="-n 6 -s 16 -c";;
      threads-intro/x86.py) args="-p simple-race.s -t 1 -c";;
      threads-locks/x86.py) args="-p flag.s -c";;
      *) args="-c";;
    esac
    out=$(cd "$dir" && timeout 30 "./$py" $args </dev/null 2>&1); rc=$?
    echo "== $f (rc=$rc)" >> "$LOG"; echo "$out" | tail -20 >> "$LOG"
    if [ $rc -ne 0 ] || echo "$out" | grep -qE 'Traceback|No such file'; then ng "$f" "$(echo "$out" | tail -1)"; else ok "$f"; fi
  done
fi

echo "[4] C 과제 빌드 (make)"
for d in threads-api threads-cv threads-bugs vm-beyondphys; do
  [ -d "$T/hw/$d" ] && run "homework/$d" make -C "$T/hw/$d" -s
done
for d in intro cpu-api vm-intro threads-intro threads-api threads-locks threads-cv threads-sema threads-bugs file-intro dist-intro cpu-sched-lottery; do
  [ -f "$T/code/$d/Makefile" ] && run "code/$d" make -C "$T/code/$d" -s
done

echo "[5] 실행 확인"
[ -x "$T/hw/threads-api/main-race" ] && run "helgrind가 경쟁 조건 탐지" sh -c "valgrind --tool=helgrind '$T/hw/threads-api/main-race' 2>&1 | grep -q 'Possible data race'"
[ -x "$T/hw/vm-beyondphys/mem" ] && run "mem 실행 (3초)" sh -c "timeout 3 '$T/hw/vm-beyondphys/mem' 1 >/dev/null 2>&1; [ \$? -eq 124 ]"
run "vmstat 실행"             vmstat 1 2
[ -x "$T/code/intro/cpu" ] && run "code/intro/cpu 실행" sh -c "timeout 3 '$T/code/intro/cpu' A >/dev/null 2>&1; [ \$? -eq 124 ]"

echo
echo "결과: PASS $PASS / FAIL $FAIL   (상세 로그: $LOG)"
[ $FAIL -eq 0 ] && echo "OSTEP homework를 수행할 준비가 되었습니다." || echo "FAIL 항목과 로그를 확인하세요."
