@echo off

unix echo DOSEMU2 PID: `cut "-d ' '" -f 4 /proc/$$/stat`

unix find /proc/`cut "-d ' '" -f 4 /proc/$$/stat`/fd -lname '/dev/kvm' -exec false {} +
if not errorlevel 0 echo KVM: used
if errorlevel 0 echo KVM: unused
