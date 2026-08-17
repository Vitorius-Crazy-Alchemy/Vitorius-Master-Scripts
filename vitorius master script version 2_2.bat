@echo off
setlocal enabledelayedexpansion

:: =========================================================
:: VITORIUS MASTER TWEAKS v2.2
:: Advanced Edition: Auto-UAC, Dynamic Dashboard, 
:: Secure Passwords, and Backup Restoration.
:: =========================================================

:: ---------------------------------------------------------
:: AUTO-ELEVATION (UAC) CHECK
:: ---------------------------------------------------------
:check_permissions
reg query "HKU\S-1-5-19\Software" >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrative Privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ---------------------------------------------------------
:: VERSION & COLOR VARIABLES
:: ---------------------------------------------------------
set "VERSION=2.2"
for /F %%a in ('"prompt $E$S & echo on & for %%b in (1) do rem"') do set "ESC=%%a"
set "cBlue=%ESC%[94m"
set "cRed=%ESC%[91m"
set "cGreen=%ESC%[92m"
set "cYellow=%ESC%[93m"
set "cReset=%ESC%[0m"

title Vitorius Master Tweaks v%VERSION%

:: ---------------------------------------------------------
:: LOGGING SETUP
:: ---------------------------------------------------------
set "LOGFILE=%~dp0VitoriusTweaks.log"
set "BACKUPDIR=%~dp0backups"
if not exist "%BACKUPDIR%" mkdir "%BACKUPDIR%"

call :log "=========================================="
call :log "Session started - Vitorius Master Tweaks v%VERSION%"
call :log "=========================================="

:: ---------------------------------------------------------
:: DYNAMIC SYSTEM INFO GATHERING
:: ---------------------------------------------------------
cls
echo %cRed%[INFO] Loading creator Vitorius configurations and scanning system...%cReset%
for /f "tokens=*" %%A in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption"') do set "SYS_OS=%%A"
for /f "tokens=*" %%A in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor | Select-Object -First 1).Name"') do set "SYS_CPU=%%A"
for /f "tokens=*" %%A in ('powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)"') do set "SYS_RAM=%%A GB"

:: Clean up the OS string if it has trailing spaces
set "SYS_OS=!SYS_OS:Microsoft =!"
timeout /t 2 /nobreak >nul

:: =========================================================
::                      MAIN MENU
:: =========================================================
:main_menu
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%           VITORIUS MASTER TWEAKS v%VERSION%%cReset%
echo %cBlue%==========================================================%cReset%
echo %cYellow% OS : %SYS_OS%%cReset%
echo %cYellow% CPU: %SYS_CPU%%cReset%
echo %cYellow% RAM: %SYS_RAM%%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  System ^& Recovery
echo   %cBlue%2.%cReset%  CPU ^& GPU Optimization
echo   %cBlue%3.%cReset%  Network ^& DNS
echo   %cBlue%4.%cReset%  Security ^& Privacy
echo   %cBlue%5.%cReset%  Maintenance ^& Cleanup
echo   %cBlue%6.%cReset%  Boot ^& Power Options
echo   %cBlue%7.%cReset%  Utilities ^& Backups
echo   %cBlue%8.%cReset%  Exit
echo.
echo %cBlue%==========================================================%cReset%
choice /c 12345678 /n /m "Select a category (1-8): "
if errorlevel 8 goto exit_routine
if errorlevel 7 goto sub_utilities
if errorlevel 6 goto sub_boot
if errorlevel 5 goto sub_maintenance
if errorlevel 4 goto sub_security
if errorlevel 3 goto sub_network
if errorlevel 2 goto sub_cpugpu
if errorlevel 1 goto sub_system

:: =========================================================
:: SUBMENU 1: SYSTEM & RECOVERY
:: =========================================================
:sub_system
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%              SYSTEM ^& RECOVERY%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Create Heavy System Restore Point (Failsafe)
echo   %cBlue%2.%cReset%  Clear ALL Event Logs (Forceful Dual-Pass Bypass)
echo   %cBlue%3.%cReset%  System Core Scan (Deep Component Cleanup ^& DISM)
echo   %cBlue%4.%cReset%  Change Admin Password (Secure String ^& Complexity)
echo   %cBlue%5.%cReset%  Reboot Options (Force Close Apps)
echo   %cBlue%6.%cReset%  Shutdown Options (Force Close Apps)
echo   %cBlue%7.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 1234567 /n /m "Select an option (1-7): "
if errorlevel 7 goto main_menu
if errorlevel 6 goto op_shutdown
if errorlevel 5 goto op_reboot
if errorlevel 4 goto op_password
if errorlevel 3 goto op_sysscan
if errorlevel 2 goto op_clearlogs
if errorlevel 1 goto op_restore

:: --- RESTORE POINT ---
:op_restore
cls
echo.
echo %cRed%[INFO] Initializing Core System Failsafe Protocol...%cReset%
echo %cRed%[BACKGROUND] Ensuring OS Rollback capabilities before applying kernel and registry level mutations.%cReset%
call :log "[RESTORE] Creating system restore point..."

echo %cRed%[REGISTRY] Overriding Windows 24-Hour Checkpoint Frequency Limit...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f >nul 2>&1

echo %cRed%[KERNEL] Engaging Volume Shadow Copy Service (VSS) on OS Drive...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue" >nul 2>&1

echo %cRed%[WORKING] Generating VITORIUS MASTER TWEAKS Snapshot. This may take a minute...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Vitorius Master v%VERSION% Pre-Tweak' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue"

if %errorlevel% equ 0 (
    echo %cGreen%[SUCCESS] Immutable OS Restore Point established.%cReset%
    call :log "[RESTORE] Restore point created successfully."
) else (
    echo %cYellow%[WARNING] Restore Point creation bypassed. VSS may be deeply disabled.%cReset%
    call :log "[RESTORE] WARNING - Restore point creation failed."
)
pause
goto sub_system

:: --- CLEAR EVENT LOGS ---
:op_clearlogs
cls
echo.
echo %cRed%[INFO] Initiating Forceful Dual-Pass Log Bypass...%cReset%
echo %cRed%[BACKGROUND] Windows stores deep diagnostic data in Event Logs. Clearing these frees up MFT records and destroys forensic diagnostic traces.%cReset%
echo.
echo %cYellow%[WARNING] This action is IRREVERSIBLE. All system event logs will be erased.%cReset%
choice /c YN /n /m "Continue? (Y/N): "
if errorlevel 2 goto sub_system

call :log "[LOGS] Clearing all event logs (dual-pass)..."
echo %cRed%[WORKING] Pass 1: Standard command-line wipe (wevtutil)...%cReset%
for /F "tokens=*" %%G in ('wevtutil.exe el') do (call wevtutil.exe cl "%%G" 2>nul)
echo %cRed%[WORKING] Pass 2: Bypassing Access Denied blocks via .NET EventSession API...%cReset%
powershell -NoProfile -Command "Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -gt 0} | ForEach-Object { try { [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($_.LogName) } catch { } }"
echo %cGreen%[SUCCESS] All telemetry and event logs eradicated.%cReset%
call :log "[LOGS] Event logs cleared successfully."
pause
goto sub_system

:: --- SYSTEM CORE SCAN ---
:op_sysscan
cls
echo.
echo %cRed%[INFO] Launching Deep Core Repair Protocols...%cReset%
echo %cRed%[BACKGROUND] DISM will verify the native component store, followed by SFC replacing any corrupt system DLLs.%cReset%
call :log "[SCAN] Starting DISM + SFC system scan..."
echo %cRed%[WORKING] Stage 1: Running DISM Component Store Cleanup (Purging superseded packages)...%cReset%
call DISM /Online /Cleanup-Image /StartComponentCleanup
echo %cRed%[WORKING] Stage 2: Restoring OS Health from Windows Update payload...%cReset%
call DISM /Online /Cleanup-Image /RestoreHealth
echo %cRed%[WORKING] Stage 3: Scanning OS Integrity (SFC)...%cReset%
call sfc /scannow
echo %cGreen%[SUCCESS] Core OS Verification Complete.%cReset%
call :log "[SCAN] System scan completed."
pause
goto sub_system

:: --- CHANGE PASSWORD (SECURE) ---
:op_password
cls
echo.
echo %cRed%[INFO] Requesting Security Override...%cReset%
echo %cRed%[BACKGROUND] Forcing strict net account policies locally before overwriting the current user's password hash.%cReset%
call :log "[PASSWORD] Admin password change requested for user: %username%"
echo %cRed%[KERNEL] Forcing complexity rules (Min 8 chars, Unlimited Age)...%cReset%
call net accounts /maxpwage:unlimited /minpwlen:8 >nul 2>&1
echo.
echo %cRed%[WORKING] Passing input securely to PowerShell API...%cReset%

:: Use PowerShell to get secure string input and update password directly
powershell -NoProfile -Command "$ErrorActionPreference='Stop'; try { $pass = Read-Host 'Enter New Password' -AsSecureString; $pass2 = Read-Host 'Retype New Password' -AsSecureString; $bstr1 = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass); $bstr2 = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass2); $str1 = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr1); $str2 = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr2); if ($str1 -ne $str2) { Write-Host '[ERROR] Passwords do not match!' -ForegroundColor Red; exit 1 }; $user = [ADSI]\"WinNT://localhost/$env:username,user\"; $user.SetPassword($str1); $user.SetInfo(); Write-Host '[SUCCESS] Password Updated Successfully.' -ForegroundColor Green; exit 0 } catch { Write-Host '[ERROR] Failed to update password. It may not meet the 8-character complexity rule.' -ForegroundColor Red; exit 1 }"

if %errorlevel% equ 0 (
    call :log "[PASSWORD] Password changed successfully for: %username%"
) else (
    call :log "[PASSWORD] ERROR - Password change failed for: %username%"
)
pause
goto sub_system

:: --- REBOOT OPTIONS ---
:op_reboot
cls
echo %cRed%[INFO] Execute Hard Reboot Command%cReset%
echo %cRed%[BACKGROUND] Uses shutdown.exe to send a direct interrupt to the kernel, bypassing application hang states.%cReset%
echo.
echo   %cBlue%1.%cReset% Reboot in 2 minutes
echo   %cBlue%2.%cReset% Reboot in 5 minutes
echo   %cBlue%3.%cReset% Cancel / Go Back
choice /c 123 /n /m "Choice (1-3): "
if errorlevel 3 goto sub_system
if errorlevel 2 (
    call :log "[REBOOT] Scheduled reboot in 300s."
    shutdown.exe /r /f /t 300
    echo %cGreen%[SUCCESS] Reboot signal sent (300s).%cReset%
    pause
    goto sub_system
)
if errorlevel 1 (
    call :log "[REBOOT] Scheduled reboot in 120s."
    shutdown.exe /r /f /t 120
    echo %cGreen%[SUCCESS] Reboot signal sent (120s).%cReset%
    pause
    goto sub_system
)

:: --- SHUTDOWN OPTIONS ---
:op_shutdown
cls
echo %cRed%[INFO] Execute Hard Shutdown Command%cReset%
echo %cRed%[BACKGROUND] Uses shutdown.exe to send a direct ACPI power down signal to the kernel, forcing hung processes to terminate.%cReset%
echo.
echo   %cBlue%1.%cReset% Shutdown in 2 minutes
echo   %cBlue%2.%cReset% Shutdown in 5 minutes
echo   %cBlue%3.%cReset% Cancel / Go Back
choice /c 123 /n /m "Choice (1-3): "
if errorlevel 3 goto sub_system
if errorlevel 2 (
    call :log "[SHUTDOWN] Scheduled shutdown in 300s."
    shutdown.exe /s /f /t 300
    echo %cGreen%[SUCCESS] Shutdown signal sent (300s).%cReset%
    pause
    goto sub_system
)
if errorlevel 1 (
    call :log "[SHUTDOWN] Scheduled shutdown in 120s."
    shutdown.exe /s /f /t 120
    echo %cGreen%[SUCCESS] Shutdown signal sent (120s).%cReset%
    pause
    goto sub_system
)

:: =========================================================
:: SUBMENU 2: CPU & GPU OPTIMIZATION
:: =========================================================
:sub_cpugpu
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%           CPU ^& GPU OPTIMIZATION%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Intel Heavy Auto-Optimization (Aggressive Scheduling)
echo   %cBlue%2.%cReset%  Ryzen Heavy Optimization (Infinity Fabric Override)
echo   %cBlue%3.%cReset%  NVIDIA RTX Performance (MSI ^& Preemption Tweaks)
echo   %cBlue%4.%cReset%  AMD RX Performance (ULPS Disable)
echo   %cBlue%5.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 12345 /n /m "Select an option (1-5): "
if errorlevel 5 goto main_menu
if errorlevel 4 goto op_amdgpu
if errorlevel 3 goto op_nvidia
if errorlevel 2 goto op_ryzen
if errorlevel 1 goto op_intel

:: --- INTEL OPTIMIZATION ---
:op_intel
cls
echo.
echo %cRed%[INFO] Intel 12th Gen+ Thread Director Optimization%cReset%
echo %cRed%[BACKGROUND] Enforces max performance while keeping the Thread Director active for hybrid CPUs.%cReset%
call :log "[INTEL] Starting Intel CPU optimization..."
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Control\Power" "intel_power"

echo %cRed%[WORKING] Restoring native energy estimation for Thread Director accuracy...%cReset%
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /f >nul 2>&1

echo %cRed%[REGISTRY] Enabling Windows Game Mode (Foreground Priority)...%cReset%
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1

echo %cRed%[WORKING] Forcing High Performance Power Profile to unpark P-Cores...%cReset%
call powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v ProcessorNameString | findstr /i "i3-12 i5-12 i7-12 i9-12 i3-13 i5-13 i7-13 i9-13 i3-14 i5-14 i7-14 i9-14 Ultra" >nul
if %errorlevel% equ 0 (
    echo %cRed%[WORKING] Hybrid CPU Detected. Overriding Thread Director HETPOLICY...%cReset%
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 7f2f4cde-f97a-4375-b22c-0e8e2b763952 0 >nul 2>&1
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 93b8b6dc-0698-4d1c-9ee4-0644e900c85d 2 >nul 2>&1
) else (
    echo %cRed%[WORKING] Legacy CPU Detected. Forcing Max C-State and unparking cores...%cReset%
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)
echo %cRed%[KERNEL] Committing Advanced Power Profile...%cReset%
call powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo %cGreen%[SUCCESS] Intel Deep Optimization Applied.%cReset%
call :log "[INTEL] Intel optimization applied successfully."
pause
goto sub_cpugpu

:: --- RYZEN OPTIMIZATION ---
:op_ryzen
cls
echo %cRed%[INFO] Select Target Architecture%cReset%
echo %cRed%[BACKGROUND] Ryzen architectures rely on Infinity Fabric and CPPC. We align the OS scheduler to match AMD's CCX.%cReset%
echo.
echo   %cBlue%1.%cReset% Ryzen 5000 Series (Zen 3)
echo   %cBlue%2.%cReset% Ryzen 7000 Series (Zen 4)
echo   %cBlue%3.%cReset% Ryzen 9000 Series (Zen 5)
echo   %cBlue%4.%cReset% Cancel / Go Back
choice /c 1234 /n /m "Architecture (1-4): "
if errorlevel 4 goto sub_cpugpu
set "ry_c=0"
if errorlevel 3 set "ry_c=3"
if errorlevel 2 if "!ry_c!"=="0" set "ry_c=2"
if errorlevel 1 if "!ry_c!"=="0" set "ry_c=1"

call :log "[RYZEN] Starting Ryzen Zen !ry_c! optimization..."
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" "ryzen_priority"

echo %cRed%[KERNEL] Unparking logical cores (CPMINCORES 100)...%cReset%
call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
echo %cRed%[REGISTRY] Elevating foreground System Responsiveness and Win32 Separator...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1

if "!ry_c!"=="1" (
    echo %cRed%[REGISTRY] Expanding LargeSystemCache for Zen 3 L3 mapping...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
)
if "!ry_c!"=="2" (
    echo %cRed%[REGISTRY] Boosting PCIe 5.0 I/O limits for Zen 4 bandwidth...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 983040 /f >nul 2>&1
)
if "!ry_c!"=="3" (
    echo %cRed%[REGISTRY] Tuning Zen 5 Interrupt Distribution and massive I/O thresholds...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v DistributeInterrupts /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 1048576 /f >nul 2>&1
)
echo %cRed%[KERNEL] Committing Advanced Power Profile...%cReset%
call powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo %cGreen%[SUCCESS] Ryzen Infinity Optimization Applied.%cReset%
call :log "[RYZEN] Ryzen optimization applied for Zen !ry_c!."
pause
goto sub_cpugpu

:: --- NVIDIA GPU ---
:op_nvidia
cls
echo.
echo %cRed%[INFO] Targeting NVIDIA GPU Subsystem...%cReset%
echo %cRed%[BACKGROUND] Modifying the graphics driver scheduler for Hardware-Accelerated GPU Scheduling and enabling strict Preemption.%cReset%
call :log "[NVIDIA] Applying NVIDIA GPU tweaks..."
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "nvidia_gfx"
echo %cRed%[REGISTRY] Enabling HwSchMode (Value 2)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
echo %cRed%[REGISTRY] Activating GPU Preemption overriding standard WDDM queues...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v EnablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
echo %cGreen%[SUCCESS] RTX Low-Latency Architecture Applied.%cReset%
call :log "[NVIDIA] NVIDIA tweaks applied."
pause
goto sub_cpugpu

:: --- AMD GPU ---
:op_amdgpu
cls
echo.
echo %cRed%[INFO] Targeting AMD GPU Subsystem...%cReset%
echo %cRed%[BACKGROUND] AMD cards utilize Ultra Low Power State (ULPS) which severely throttles clock recovery times.%cReset%
call :log "[AMD GPU] Applying AMD GPU tweaks..."
echo %cRed%[WORKING] Iterating through Class {4d36e968} to disable ULPS...%cReset%
powershell -NoProfile -Command "Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\00*' -ErrorAction SilentlyContinue | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'EnableUlps' -Value 0 -ErrorAction SilentlyContinue }"
echo %cRed%[REGISTRY] Enabling Hardware Scheduling (HwSchMode 2)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
echo %cGreen%[SUCCESS] AMD Performance State Locked.%cReset%
call :log "[AMD GPU] AMD GPU tweaks applied."
pause
goto sub_cpugpu

:: =========================================================
:: SUBMENU 3: NETWORK & DNS
:: =========================================================
:sub_network
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%               NETWORK ^& DNS%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Disable IPv6 (Kernel Level)
echo   %cBlue%2.%cReset%  DNS Options ^& Winsock Reset
echo   %cBlue%3.%cReset%  VPN vs Gaming Latency (BBR Congestion Control)
echo   %cBlue%4.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 1234 /n /m "Select an option (1-4): "
if errorlevel 4 goto main_menu
if errorlevel 3 goto op_vpn
if errorlevel 2 goto op_dns
if errorlevel 1 goto op_ipv6

:: --- DISABLE IPv6 ---
:op_ipv6
cls
echo.
echo %cRed%[INFO] Targeting IPv6 Network Stack...%cReset%
echo %cRed%[BACKGROUND] IPv6 can cause DNS leaks, broadcast overhead, and latency spikes in strictly IPv4 environments.%cReset%
call :log "[IPv6] Disabling IPv6..."
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" "ipv6_params"
echo %cRed%[REGISTRY] Setting DisabledComponents to 255 (Hard Disable)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f >nul 2>&1
echo %cGreen%[SUCCESS] IPv6 disabled at kernel registry level.%cReset%
echo %cYellow%[NOTE] A system reboot is required for this to fully take effect.%cReset%
call :log "[IPv6] IPv6 registry disable applied."
pause
goto sub_network

:: --- DNS & WINSOCK ---
:op_dns
cls
echo %cRed%[INFO] Select Custom DNS Routing%cReset%
echo %cRed%[BACKGROUND] Rebuilding the TCP/IP stack resolves corrupted network caches, while custom DNS routes requests faster.%cReset%
echo.
echo   %cBlue%1.%cReset% Cloudflare (1.1.1.1 / 1.0.0.1) - Fastest Latency
echo   %cBlue%2.%cReset% Google (8.8.8.8 / 8.8.4.4) - Highest Reliability
echo   %cBlue%3.%cReset% Malware ^& Adult Filter (1.1.1.3 / 1.1.1.2) - Secure Routing
echo   %cBlue%4.%cReset% Cancel / Go Back
choice /c 1234 /n /m "Choice (1-4): "
if errorlevel 4 goto sub_network
call :log "[DNS] Applying DNS configuration..."
echo %cRed%[WORKING] Applying DNS Addresses to all NetAdapters...%cReset%
if errorlevel 3 powershell -NoProfile -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '1.1.1.3','1.1.1.2'"
if errorlevel 2 powershell -NoProfile -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '8.8.8.8','8.8.4.4'"
if errorlevel 1 powershell -NoProfile -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '1.1.1.1','1.0.0.1'"
echo %cRed%[KERNEL] Resetting Winsock TCP/IP interface...%cReset%
call netsh winsock reset >nul 2>&1
echo %cRed%[KERNEL] Flushing IP configurations...%cReset%
call ipconfig /flushdns >nul 2>&1
echo %cGreen%[SUCCESS] Deep DNS and Routing Applied.%cReset%
call :log "[DNS] DNS and Winsock reset complete."
pause
goto sub_network

:: --- VPN / GAMING TWEAKS ---
:op_vpn
cls
echo %cRed%[INFO] Target Network Stack Topology%cReset%
echo %cRed%[BACKGROUND] Gaming requires TCPNoDelay (Nagle disable). VPNs require strict MTU limits to prevent fragmentation.%cReset%
echo.
echo   %cBlue%1.%cReset% Optimize FOR VPN (MTU Tweak ^& Stability)
echo   %cBlue%2.%cReset% Optimize WITHOUT VPN (Raw Latency ^& BBR Congestion)
echo   %cBlue%3.%cReset% Cancel / Go Back
choice /c 123 /n /m "Choice (1-3): "
if errorlevel 3 goto sub_network
call :log "[NETWORK] Applying network optimization..."
if errorlevel 2 goto vpn_nogaming
if errorlevel 1 goto vpn_yesvpn

:vpn_yesvpn
echo %cRed%[KERNEL] Clamping MTU to 1400 to prevent VPN encapsulation drops...%cReset%
call netsh interface ipv4 set subinterface "Ethernet" mtu=1400 store=persistent >nul 2>&1
call netsh interface ipv4 set subinterface "Wi-Fi" mtu=1400 store=persistent >nul 2>&1
echo %cRed%[REGISTRY] Setting TcpAckFrequency and TCPNoDelay on ALL interface GUIDs...%cReset%
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*' | ForEach-Object { Set-ItemProperty $_.PSPath -Name TcpAckFrequency -Value 1 -ErrorAction SilentlyContinue; Set-ItemProperty $_.PSPath -Name TCPNoDelay -Value 1 -ErrorAction SilentlyContinue }"
echo %cGreen%[SUCCESS] VPN Network Optimization Complete.%cReset%
call :log "[NETWORK] VPN optimization applied."
pause
goto sub_network

:vpn_nogaming
echo %cRed%[KERNEL] Restoring MTU 1500 and wiping NetworkThrottlingIndex...%cReset%
call netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[REGISTRY] Setting TcpAckFrequency and TCPNoDelay on ALL interface GUIDs...%cReset%
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*' | ForEach-Object { Set-ItemProperty $_.PSPath -Name TcpAckFrequency -Value 1 -ErrorAction SilentlyContinue; Set-ItemProperty $_.PSPath -Name TCPNoDelay -Value 1 -ErrorAction SilentlyContinue }"
echo %cRed%[KERNEL] Injecting advanced BBR2 Congestion Provider into TCP stack...%cReset%
call netsh int tcp set supplemental template=custom icw=10 congestionprovider=bbr2 >nul 2>&1
echo %cGreen%[SUCCESS] Gaming Network Optimization Complete.%cReset%
call :log "[NETWORK] Gaming/BBR optimization applied."
pause
goto sub_network

:: =========================================================
:: SUBMENU 4: SECURITY & PRIVACY
:: =========================================================
:sub_security
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%             SECURITY ^& PRIVACY%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Modify Security (Deep Registry Hardening)
echo   %cBlue%2.%cReset%  Update Hosts (Deep Blacklist ^& Telemetry Block)
echo   %cBlue%3.%cReset%  Secure Updates Only (Kill Telemetry ^& P2P)
echo   %cBlue%4.%cReset%  Paranoid Security (Extreme Lockdown)
echo   %cBlue%5.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 12345 /n /m "Select an option (1-5): "
if errorlevel 5 goto main_menu
if errorlevel 4 goto op_paranoid
if errorlevel 3 goto op_updates
if errorlevel 2 goto op_hosts
if errorlevel 1 goto op_security

:: --- SECURITY POSTURE ---
:op_security
cls
echo %cRed%[INFO] Select Security Posture%cReset%
echo %cRed%[BACKGROUND] Standard Windows security is permissive. These profiles manipulate UAC, Defender heuristics, and LSA limits.%cReset%
echo.
echo   %cBlue%1.%cReset% Mid Range (Balanced)
echo   %cBlue%2.%cReset% High Range (Active Defender ^& Script Limits)
echo   %cBlue%3.%cReset% Extreme (Maximum Home Defense ^& Anti-Exploit)
echo   %cBlue%4.%cReset% Corporate (Full Lockdown ^& SMBv1 Kill)
echo   %cBlue%5.%cReset% Cancel / Go Back
choice /c 12345 /n /m "Choice (1-5): "
if errorlevel 5 goto sub_security
call :log "[SECURITY] Applying security profile..."
call :backup_reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "security_uac"
if errorlevel 4 goto sec_4
if errorlevel 3 goto sec_3
if errorlevel 2 goto sec_2
if errorlevel 1 goto sec_1

:sec_1
echo %cRed%[WORKING] Hardening system policies (Balanced)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Force"
goto sec_done
:sec_2
echo %cRed%[WORKING] Hardening system policies (High)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -PUAProtection Enabled"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul 2>&1
goto sec_done
:sec_3
echo %cRed%[WORKING] Hardening system policies (Extreme)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy AllSigned -Force"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -EnableControlledFolderAccess Enabled"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 1 /f >nul 2>&1
goto sec_done
:sec_4
echo %cRed%[WORKING] Hardening system policies (Corporate)...%cReset%
call net user guest /active:no >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart"
goto sec_done
:sec_done
echo %cGreen%[SUCCESS] Security Profile Deployed.%cReset%
call :log "[SECURITY] Security profile applied."
pause
goto sub_security

:: --- HOSTS BLACKLIST ---
:op_hosts
cls
echo.
echo %cRed%[INFO] Target: Top 10 Blacklist Repositories%cReset%
echo %cRed%[BACKGROUND] Replacing native hosts file to route telemetry, ad-networks, and malicious domains to 0.0.0.0.%cReset%
call :log "[HOSTS] Updating hosts blacklist..."
echo %cRed%[WORKING] Downloading secure hosts file from GitHub...%cReset%
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' -OutFile '%TEMP%\hosts'"

echo %cRed%[WORKING] Purging duplicates and sorting alphanumerically...%cReset%
set "DOMAIN_COUNT=0"
for /f "usebackq tokens=*" %%c in (`powershell -NoProfile -Command "$path = $env:TEMP + '\hosts'; $cleanPath = $env:TEMP + '\hosts_clean'; if (Test-Path $path) { $h = [System.IO.File]::ReadAllLines($path); $u = $h -match '^0\.0\.0\.0\s+' | Sort-Object -Unique; $out = [System.Collections.Generic.List[string]]::new(); $out.Add('127.0.0.1 localhost'); $out.Add('::1 localhost'); $out.AddRange($u); [System.IO.File]::WriteAllLines($cleanPath, $out); $u.Count } else { '0' }"`) do (
    set "DOMAIN_COUNT=%%c"
)

echo %cRed%[WORKING] Overwriting system hosts in System32\drivers\etc...%cReset%
copy /y "%TEMP%\hosts_clean" "C:\Windows\System32\drivers\etc\hosts" >nul
echo %cRed%[KERNEL] Flushing DNS resolver cache to enforce new routing...%cReset%
call ipconfig /flushdns >nul
echo %cGreen%[SUCCESS] Hosts updated! Locked and blocked %DOMAIN_COUNT% unique domains.%cReset%
call :log "[HOSTS] Blocked %DOMAIN_COUNT% domains."
pause
goto sub_security

:: --- SECURE UPDATES ---
:op_updates
cls
echo.
echo %cRed%[INFO] Modifying Windows Update Framework...%cReset%
echo %cRed%[BACKGROUND] Microsoft uses forced telemetry and P2P to share updates, eating bandwidth. This locks updates to critical-only.%cReset%
call :log "[UPDATES] Applying telemetry kill..."
call :backup_reg "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "telemetry"
echo %cRed%[REGISTRY] Setting AUOptions to 2 (Notify before download/install)...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul 2>&1
echo %cRed%[REGISTRY] Nullifying AllowTelemetry collection...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[REGISTRY] Killing DODownloadMode (Disabling P2P update sharing)...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
echo %cGreen%[SUCCESS] OS Locked to Secure Patches Only.%cReset%
call :log "[UPDATES] Telemetry and P2P disabled."
pause
goto sub_security

:: --- PARANOID SECURITY ---
:op_paranoid
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%                 PARANOID SECURITY%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo %cYellow%[WARNING] This is an EXTREME lockdown profile.%cReset%
echo.
echo This option will:
echo  1. Disable Windows Script Host (Breaks background music option).
echo  2. Disable PowerShell 2.0 (Blocks legacy exploit vectors).
echo  3. Force SEHOP (Structured Exception Handling Overwrite Protection).
echo  4. Disable LLMNR (Prevents local network credential sniffing).
echo  5. Kill SMBv1, v2, and v3 (Breaks all local file/printer sharing).
echo  6. Set UAC to maximum (Requires password for all admin tasks).
echo  7. Disable Remote Desktop (RDP) completely.
echo.
echo %cYellow%[WARNING] This action is IRREVERSIBLE without manual registry restoration.%cReset%
echo.
choice /c YN /n /m "Proceed with Paranoid Security? (Y/N): "
if errorlevel 2 goto sub_security

call :log "[PARANOID] Executing extreme lockdown..."
call :backup_reg "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" "paranoid_wsh"
call :backup_reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "paranoid_uac"

echo %cRed%[1/7] Disabling Windows Script Host (Blocks .vbs / .js malware)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[2/7] Disabling PowerShell 2.0 (Legacy engine used by hackers)...%cReset%
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root -NoRestart" >nul 2>&1
echo %cRed%[3/7] Forcing SEHOP...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableExceptionChainValidation /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[4/7] Disabling LLMNR...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[5/7] Disabling SMB v1, v2, and v3...%cReset%
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart" >nul 2>&1
sc config lanmanserver start= disabled >nul 2>&1
sc stop lanmanserver /y >nul 2>&1
echo %cRed%[6/7] Hardening UAC to maximum...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
echo %cRed%[7/7] Disabling RDP...%cReset%
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo %cGreen%[SUCCESS] HARDENING COMPLETE.%cReset%
echo %cYellow%Note: Local File Sharing (SMB) and VBScripts are now BLOCKED.%cReset%
echo %cYellow%Please restart your computer for all changes to apply.%cReset%
echo %cYellow%Registry backups saved to: %BACKUPDIR%%cReset%
call :log "[PARANOID] Extreme lockdown applied."
pause
goto sub_security

:: =========================================================
:: SUBMENU 5: MAINTENANCE & CLEANUP
:: =========================================================
:sub_maintenance
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%           MAINTENANCE ^& CLEANUP%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Clear Temporary Files (Prefetch ^& Update Cache)
echo   %cBlue%2.%cReset%  Smart Optimize (Drive Trim ^& Defrag)
echo   %cBlue%3.%cReset%  Offline Browser Trace ^& Cookie Cleaner
echo   %cBlue%4.%cReset%  Secure Free Space Wipe (Cryptographic Zeroing)
echo   %cBlue%5.%cReset%  RAM Purge (Deep API Working Set Clear)
echo   %cBlue%6.%cReset%  Heavy Server Load (Intel - TCP Stack Hardening)
echo   %cBlue%7.%cReset%  Heavy Server Load (Ryzen - I/O ^& NUMA Hardening)
echo   %cBlue%8.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 12345678 /n /m "Select an option (1-8): "
if errorlevel 8 goto main_menu
if errorlevel 7 goto op_ryzenserver
if errorlevel 6 goto op_intelserver
if errorlevel 5 goto op_rampurge
if errorlevel 4 goto op_freewipe
if errorlevel 3 goto op_browser
if errorlevel 2 goto op_smartdrive
if errorlevel 1 goto op_tempclean

:: --- TEMP CLEANER ---
:op_tempclean
cls
echo.
echo %cRed%[INFO] Executing Volatile Memory Purge...%cReset%
echo %cRed%[BACKGROUND] Deleting Prefetch forces Windows to rebuild optimal load paths. Clearing SoftwareDistribution fixes corrupted updates.%cReset%
call :log "[TEMP] Clearing temporary files..."
echo %cRed%[WORKING] Wiping User AppData Temps...%cReset%
del /s /f /q %temp%\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping Core System Temps...%cReset%
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping SuperFetch / Prefetch Data...%cReset%
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping Stale Windows Updates (SoftwareDistribution)...%cReset%
del /s /f /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
echo %cGreen%[SUCCESS] Storage Optimization Complete.%cReset%
call :log "[TEMP] Temp files cleared."
pause
goto sub_maintenance

:: --- SMART DRIVE OPTIMIZE ---
:: FIXED: Resolves SSD Wear Bug from v2.1
:op_smartdrive
cls
echo.
echo %cRed%[INFO] Accessing Logical Disk Manager...%cReset%
echo %cRed%[BACKGROUND] Detects SSD vs HDD. Applies ReTrim only for SSDs, full Defrag only for HDDs.%cReset%
call :log "[DRIVE] Running smart drive optimization..."
echo %cRed%[KERNEL] Ensuring FSUTIL TRIM is enabled...%cReset%
call fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
echo %cRed%[WORKING] Detecting drive media types and optimizing accordingly...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' } | ForEach-Object {" ^
    "  $vol = $_;" ^
    "  $media = (Get-Partition -DriveLetter $vol.DriveLetter -ErrorAction SilentlyContinue | Get-Disk -ErrorAction SilentlyContinue).MediaType;" ^
    "  if ($media -match 'SSD|NVMe') {" ^
    "    Write-Host \"[SSD] $($vol.DriveLetter): - Applying ReTrim only...\" -ForegroundColor Cyan;" ^
    "    Optimize-Volume -DriveLetter $vol.DriveLetter -ReTrim -ErrorAction SilentlyContinue" ^
    "  } elseif ($media -eq 'HDD') {" ^
    "    Write-Host \"[HDD] $($vol.DriveLetter): - Applying full Defrag...\" -ForegroundColor Yellow;" ^
    "    Optimize-Volume -DriveLetter $vol.DriveLetter -Defrag -ErrorAction SilentlyContinue" ^
    "  } else {" ^
    "    Write-Host \"[Unknown] $($vol.DriveLetter): - Applying ReTrim...\" -ForegroundColor Green;" ^
    "    Optimize-Volume -DriveLetter $vol.DriveLetter -ReTrim -ErrorAction SilentlyContinue" ^
    "  }" ^
    "}"
echo %cGreen%[SUCCESS] Volume I/O Restored.%cReset%
call :log "[DRIVE] Smart drive optimization complete."
pause
goto sub_maintenance

:: --- BROWSER CLEANER ---
:: FIXED: Removed placebo IE cache command for Win11 24H2 compatibility
:op_browser
cls
echo.
echo %cRed%[INFO] Initializing Offline Browser Trace ^& Cookie Cleaner...%cReset%
echo %cRed%[BACKGROUND] Forcibly closing browsers to unlock files, then wiping cache, cookies, and history.%cReset%
echo.
echo %cYellow%[WARNING] This will FORCE-CLOSE all open browsers and DELETE cookies/history.%cReset%
choice /c YN /n /m "Continue? (Y/N): "
if errorlevel 2 goto sub_maintenance

call :log "[BROWSER] Cleaning all browser data..."
echo %cRed%[WORKING] Terminating active browser processes...%cReset%
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1
taskkill /F /IM opera.exe /T >nul 2>&1

echo %cRed%[WORKING] Cleaning Google Chrome...%cReset%
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Network\Cookies" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History" >nul 2>&1

echo %cRed%[WORKING] Cleaning Microsoft Edge...%cReset%
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Network\Cookies" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History" >nul 2>&1

echo %cRed%[WORKING] Cleaning Mozilla Firefox...%cReset%
for /d %%x in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    del /q /f /s "%%x\cache2\*.*" >nul 2>&1
    del /q /f "%%x\cookies.sqlite" >nul 2>&1
    del /q /f "%%x\places.sqlite" >nul 2>&1
)

echo %cRed%[WORKING] Cleaning Brave Browser...%cReset%
del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache\*.*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Network\Cookies" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\History" >nul 2>&1

echo %cRed%[WORKING] Cleaning Opera...%cReset%
del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Cache\*.*" >nul 2>&1
del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Network\Cookies" >nul 2>&1
del /q /f /s "%APPDATA%\Opera Software\Opera Stable\History" >nul 2>&1

echo %cGreen%[SUCCESS] All modern browser traces and cookies eradicated offline.%cReset%
call :log "[BROWSER] Browser cleaning complete."
pause
goto sub_maintenance

:: --- FREE SPACE WIPE ---
:op_freewipe
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%       SECURE FREE SPACE WIPE (MODULAR)%cReset%
echo %cBlue%==========================================================%cReset%
echo %cRed%[WORKING] Scanning active logical drives...%cReset%
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -in 2,3 } | ForEach-Object { $size=[math]::Round($_.Size/1GB, 2); $free=[math]::Round($_.FreeSpace/1GB, 2); $msg = '    [' + $_.DeviceID + '] - ' + $_.Description + ' | Total: ' + $size + 'GB | Free: ' + $free + 'GB'; Write-Host $msg -ForegroundColor Cyan }"
echo.
echo   Type a drive letter (e.g. C, D) or %cBlue%M%cReset% to go back.
echo.
set "wipe_drive="
set /p wipe_drive="Select Drive Letter: "
if not defined wipe_drive goto op_freewipe
set "wipe_drive=!wipe_drive:"=!"
if /i "!wipe_drive!"=="m" goto sub_maintenance
set "wipe_drive=!wipe_drive:~0,1!"

if not exist "!wipe_drive!:\" (
    echo %cRed%[ERROR] Drive !wipe_drive!: does not exist or is not mounted.%cReset%
    pause
    goto op_freewipe
)

:op_freewipe_mode
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%         WIPE TARGET: !wipe_drive!:\%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset% 1-Pass Rapid Zero-Fill (Best for SSDs/NVMe)
echo   %cBlue%2.%cReset% 3-Pass DoD Cryptographic Wipe (Maximum Paranoia)
echo   %cBlue%3.%cReset% Cancel / Go Back
choice /c 123 /n /m "Select Wipe Intensity (1-3): "
if errorlevel 3 goto sub_maintenance
if errorlevel 2 goto wipe_3pass
if errorlevel 1 goto wipe_1pass

:wipe_1pass
cls
echo %cYellow%[WARNING] This will fill ALL free space on !wipe_drive!: with zeroes. This is IRREVERSIBLE.%cReset%
choice /c YN /n /m "Confirm? (Y/N): "
if errorlevel 2 goto sub_maintenance
call :log "[WIPE] 1-pass zero-fill on !wipe_drive!: starting..."
echo %cRed%[INFO] Streaming pure zeroes into unallocated sectors...%cReset%
echo %cYellow%[WARNING] Windows may briefly display a 'Low Disk Space' pop-up. This is normal.%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference = 'SilentlyContinue'; $path = '!wipe_drive!:\Vitorius_Zero_Temp.tmp'; $buffer = New-Object byte[] (64 * 1024 * 1024); try { $fs = [System.IO.File]::Create($path); while ($true) { $fs.Write($buffer, 0, $buffer.Length) } } catch { }; if ($fs) { $fs.Close() }; Remove-Item -Path $path -Force"
echo %cGreen%[SUCCESS] Free space on !wipe_drive!: zero-filled (1-Pass).%cReset%
call :log "[WIPE] 1-pass complete on !wipe_drive!:"
pause
goto sub_maintenance

:wipe_3pass
cls
echo %cYellow%[WARNING] 3-pass DoD wipe on !wipe_drive!: — this will take a VERY long time. IRREVERSIBLE.%cReset%
choice /c YN /n /m "Confirm? (Y/N): "
if errorlevel 2 goto sub_maintenance
call :log "[WIPE] 3-pass cipher wipe on !wipe_drive!: starting..."
echo %cRed%[INFO] Pass 1: Zeroes (0x00) / Pass 2: Ones (0xFF) / Pass 3: Pseudorandom%cReset%
cipher /w:!wipe_drive!:\
echo %cGreen%[SUCCESS] Free space on !wipe_drive!: cryptographically eradicated (3-Pass).%cReset%
call :log "[WIPE] 3-pass complete on !wipe_drive!:"
pause
goto sub_maintenance

:: --- RAM PURGE ---
:: FIXED: Escape parentheses in C# injection block to prevent batch crashing
:op_rampurge
cls
echo.
echo %cRed%[INFO] Initializing Deep RAM Purge...%cReset%
echo %cRed%[BACKGROUND] Forcing Windows Memory Manager to flush process Working Sets and run garbage collection.%cReset%
call :log "[RAM] RAM purge starting..."

echo %cRed%[WORKING] Generating C# P/Invoke payload for native API access...%cReset%
set "ps1=%TEMP%\rampurge.ps1"

(
echo $cs = @"
echo using System;
echo using System.Runtime.InteropServices;
echo public class MemPurge {
echo     [DllImport("psapi.dll"^)]
echo     public static extern int EmptyWorkingSet(IntPtr hwProc^);
echo }
echo "@
echo Add-Type -TypeDefinition $cs -ErrorAction SilentlyContinue
echo Get-Process ^| ForEach-Object { try { [MemPurge]::EmptyWorkingSet($_.Handle^) ^| Out-Null } catch {} }
echo [GC]::Collect(^)
echo [GC]::WaitForPendingFinalizers(^)
) > "%ps1%"

echo %cRed%[KERNEL] Executing payload and clearing process memory pages...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -File "%ps1%" >nul 2>&1

echo %cRed%[WORKING] Sweeping residual temporary scripts...%cReset%
del /f /q "%ps1%" >nul 2>&1

echo %cGreen%[SUCCESS] RAM Purge Complete. Task Manager will show a massive drop in used memory.%cReset%
call :log "[RAM] RAM purge complete."
pause
goto sub_maintenance

:: --- INTEL SERVER LOAD ---
:op_intelserver
cls
echo.
echo %cRed%[INFO] Dynamic Memory ^& Network Optimization...%cReset%
call :log "[SERVER-INTEL] Starting server load optimization..."
set "RAM_GB=16"
echo %cRed%[WORKING] Detecting System RAM...%cReset%
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)" 2^>nul`) do (
    set "RAM_GB=%%A"
)
set /a RAM_GB=%RAM_GB% 2>nul
if "%RAM_GB%"=="0" set "RAM_GB=16"
echo %cRed%[INFO] Detected %RAM_GB% GB of Physical Memory.%cReset%
set "IOPAGE=1048576"
set "RAM_PROF=Extreme RAM (128GB+)"
if %RAM_GB% LEQ 64 ( set "IOPAGE=524288" & set "RAM_PROF=Ultra RAM (64GB)" )
if %RAM_GB% LEQ 32 ( set "IOPAGE=262144" & set "RAM_PROF=High RAM (32GB)" )
if %RAM_GB% LEQ 16 ( set "IOPAGE=131072" & set "RAM_PROF=Standard RAM (16GB)" )
if %RAM_GB% LEQ 8 ( set "IOPAGE=65536" & set "RAM_PROF=Low RAM (8GB)" )
echo %cRed%[INFO] %RAM_PROF% profile loaded.%cReset%
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "server_memory"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d %IOPAGE% /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[KERNEL] Optimizing TCP/IP Stack for Server/Heavy Load...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1
call netsh int tcp set global rss=enabled >nul 2>&1
call netsh int tcp set global autotuninglevel=normal >nul 2>&1
echo %cGreen%[SUCCESS] Dynamic RAM and TCP optimization applied.%cReset%
call :log "[SERVER-INTEL] Server optimization applied (RAM: %RAM_GB%GB, IoPage: %IOPAGE%)."
pause
goto sub_maintenance

:: --- RYZEN SERVER LOAD ---
:op_ryzenserver
cls
echo.
echo %cRed%[INFO] Detecting Ryzen Subsystem Natively...%cReset%
echo %cRed%[BACKGROUND] Ryzen architectures require modified NUMA parameters and lifted I/O page limits.%cReset%
call :log "[SERVER-RYZEN] Starting Ryzen server optimization..."
call :backup_reg "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "ryzen_server_memory"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v Size /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v ProcessorNameString | findstr /i "5000 7000 9000" >nul
if %errorlevel% equ 0 (
    echo %cRed%[REGISTRY] Zen 3+ Detected. Unlocking IoPageLockLimit...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 983040 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 24 /f >nul 2>&1
) else (
    echo %cRed%[KERNEL] Legacy Ryzen Detected. Restricting C-States...%cReset%
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
)
echo %cGreen%[SUCCESS] Ryzen Server Optimization Active.%cReset%
call :log "[SERVER-RYZEN] Ryzen server optimization applied."
pause
goto sub_maintenance

:: =========================================================
:: SUBMENU 6: BOOT & POWER OPTIONS
:: =========================================================
:sub_boot
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%            BOOT ^& POWER OPTIONS%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Enable Legacy F8 Boot Menu ^& Disable Auto-Repair
echo   %cBlue%2.%cReset%  Enable "No GUI" Boot (Faster Startup)
echo   %cBlue%3.%cReset%  Reboot to Safe Mode (Minimal)
echo   %cBlue%4.%cReset%  Reboot to Safe Mode (With Networking)
echo   %cBlue%5.%cReset%  Restore Default Normal Boot
echo   %cBlue%6.%cReset%  Reset Wallpaper ^& Wipe Theme Cache
echo   %cBlue%7.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 1234567 /n /m "Select an option (1-7): "
if errorlevel 7 goto main_menu
if errorlevel 6 goto op_wallpaper
if errorlevel 5 goto op_bootrestore
if errorlevel 4 goto op_safenet
if errorlevel 3 goto op_safemin
if errorlevel 2 goto op_nogui
if errorlevel 1 goto op_f8menu

:op_f8menu
cls
call :log "[BOOT] Enabling legacy F8 menu..."
echo %cRed%[KERNEL] Injecting Legacy F8 Menu into BCD...%cReset%
bcdedit /set {default} bootmenupolicy legacy >nul 2>&1
echo %cRed%[KERNEL] Disabling Auto-Repair loops and ignoring failures...%cReset%
bcdedit /set {default} recoveryenabled No >nul 2>&1
bcdedit /set {default} bootstatuspolicy ignoreallfailures >nul 2>&1
echo %cGreen%[SUCCESS] Bootloader hardened.%cReset%
call :log "[BOOT] F8 menu enabled, auto-repair disabled."
pause
goto sub_boot

:op_nogui
cls
call :log "[BOOT] Enabling No-GUI boot..."
echo %cRed%[KERNEL] Stripping Windows Boot GUI from BCD global settings...%cReset%
bcdedit /set {globalsettings} custom:16000067 true >nul 2>&1
bcdedit /set {default} quietboot yes >nul 2>&1
bcdedit /set {default} bootuxdisabled on >nul 2>&1
echo %cGreen%[SUCCESS] Headless boot enabled.%cReset%
call :log "[BOOT] No-GUI boot enabled."
pause
goto sub_boot

:: FIXED: Loop prevention now correctly targets {current}
:op_safemin
cls
echo %cYellow%[WARNING] This will immediately reboot into Safe Mode (Minimal).%cReset%
choice /c YN /n /m "Continue? (Y/N): "
if errorlevel 2 goto sub_boot
call :log "[BOOT] Rebooting to Safe Mode (Minimal)..."
echo %cRed%[WORKING] Injecting Safe Mode Loop Prevention...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "ClearSafeBoot" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot" /f >nul 2>&1
powercfg /h off >nul 2>&1
bcdedit /set {current} safeboot minimal >nul 2>&1
shutdown.exe /r /f /t 0
goto sub_boot

:: FIXED: Loop prevention now correctly targets {current}
:op_safenet
cls
echo %cYellow%[WARNING] This will immediately reboot into Safe Mode (With Networking).%cReset%
choice /c YN /n /m "Continue? (Y/N): "
if errorlevel 2 goto sub_boot
call :log "[BOOT] Rebooting to Safe Mode (Network)..."
echo %cRed%[WORKING] Injecting Safe Mode Loop Prevention...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "ClearSafeBoot" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot" /f >nul 2>&1
powercfg /h off >nul 2>&1
bcdedit /set {current} safeboot network >nul 2>&1
shutdown.exe /r /f /t 0
goto sub_boot

:op_bootrestore
cls
call :log "[BOOT] Restoring default boot config..."
echo %cRed%[KERNEL] Purging Safe Mode flags from current BCD...%cReset%
bcdedit /deletevalue {current} safeboot >nul 2>&1
echo %cRed%[KERNEL] Restoring Standard Boot Menu and Recovery logic...%cReset%
bcdedit /set {default} bootmenupolicy standard >nul 2>&1
bcdedit /set {default} recoveryenabled Yes >nul 2>&1
bcdedit /deletevalue {default} quietboot >nul 2>&1
echo %cGreen%[SUCCESS] Normal boot restored.%cReset%
call :log "[BOOT] Default boot config restored."
pause
goto sub_boot

:op_wallpaper
cls
echo.
echo %cRed%[INFO] Initializing Theme Purge...%cReset%
echo %cRed%[BACKGROUND] Windows caches compressed wallpapers in hidden AppData directories.%cReset%
call :log "[THEME] Resetting wallpaper and theme cache..."
echo %cRed%[WORKING] Destroying cached TranscodedWallpaper files...%cReset%
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*" >nul 2>&1
echo %cRed%[REGISTRY] Overwriting HKCU Desktop variables...%cReset%
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d "" /f >nul 2>&1
echo %cRed%[WORKING] Broadcasting update signal via user32.dll...%cReset%
call RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo %cGreen%[SUCCESS] Desktop reset to factory default.%cReset%
call :log "[THEME] Theme cache wiped."
pause
goto sub_boot

:: =========================================================
:: SUBMENU 7: UTILITIES & BACKUPS
:: =========================================================
:sub_utilities
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%                 UTILITIES ^& BACKUPS%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo   %cBlue%1.%cReset%  Play Background Music (Loop WAV)
echo   %cBlue%2.%cReset%  Live System Resource Monitor (CPU/RAM/GPU)
echo   %cBlue%3.%cReset%  Restore Registry Backups
echo   %cBlue%4.%cReset%  Back to Main Menu
echo.
echo %cBlue%==========================================================%cReset%
choice /c 1234 /n /m "Select an option (1-4): "
if errorlevel 4 goto main_menu
if errorlevel 3 goto op_restorebak
if errorlevel 2 goto op_monitor
if errorlevel 1 goto op_music

:: --- RESTORE BACKUPS ---
:op_restorebak
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%              RESTORE REGISTRY BACKUPS%cReset%
echo %cBlue%==========================================================%cReset%
echo.
echo %cRed%[INFO] Scanning for available registry backups...%cReset%
set "count=0"
for %%F in ("%BACKUPDIR%\*.reg") do (
    set /a count+=1
    set "backup[!count!]=%%~nxF"
    set "backuppath[!count!]=%%~fF"
)

if %count%==0 (
    echo %cYellow%No backups found in "%BACKUPDIR%".%cReset%
    pause
    goto sub_utilities
)

for /L %%I in (1,1,%count%) do (
    echo   %cBlue%%%I.%cReset% !backup[%%I]!
)
echo   %cBlue%0.%cReset% Cancel / Go Back
echo.
set "res_choice="
set /p res_choice="Select a backup to restore (0-%count%): "
if not defined res_choice goto op_restorebak
set "res_choice=!res_choice:"=!"
if "!res_choice!"=="0" goto sub_utilities

:: Validate input
set "selected_path=!backuppath[%res_choice%]!"
if not defined selected_path (
    echo %cRed%Invalid selection.%cReset%
    pause
    goto op_restorebak
)

echo %cYellow%[WARNING] You are about to merge: !backup[%res_choice%]!%cReset%
choice /c YN /n /m "Are you sure? (Y/N): "
if errorlevel 2 goto op_restorebak

echo %cRed%[WORKING] Merging registry file...%cReset%
reg import "!selected_path!" >nul 2>&1
if %errorlevel% equ 0 (
    echo %cGreen%[SUCCESS] Registry backup restored successfully.%cReset%
    call :log "[RESTORE-BAK] Restored: !backup[%res_choice%]!"
) else (
    echo %cRed%[ERROR] Failed to restore registry backup.%cReset%
    call :log "[RESTORE-BAK] Failed to restore: !backup[%res_choice%]!"
)
pause
goto op_restorebak

:: --- BACKGROUND MUSIC ---
:: FIXED: Rewritten in pure PowerShell to remove VBScript/WMP dependencies, now supports MP3 and WAV.
:op_music
cls
echo %cRed%[INFO] Initializing Background Audio Subsystem (Native PowerShell)...%cReset%
echo.
echo   %cBlue%1.%cReset% Play "trough-pain-comes-salvation.mp3" (Default)
echo   %cBlue%2.%cReset% Enter a custom WAV/MP3 filename
echo   %cBlue%3.%cReset% Stop current music
echo   %cBlue%4.%cReset% Return to Utilities Menu
choice /c 1234 /n /m "Select Audio Option (1-4): "
if errorlevel 4 goto sub_utilities
if errorlevel 3 (
    powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -match 'bgmusic.ps1' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"
    echo %cGreen%[SUCCESS] Audio playback stopped.%cReset%
    call :log "[MUSIC] Playback stopped."
    pause
    goto sub_utilities
)
set "mp3name="
if errorlevel 2 (
    set /p mp3name="Enter the exact WAV/MP3 filename (e.g., song.mp3): "
    set "mp3name=!mp3name:"=!"
)
if errorlevel 1 if not defined mp3name set "mp3name=trough-pain-comes-salvation.mp3"

if not exist "%~dp0!mp3name!" (
    echo %cRed%[ERROR] File '!mp3name!' not found in script directory. Please ensure it is a valid audio file.%cReset%
    pause
    goto sub_utilities
)

echo %cRed%[WORKING] Locating App PID for lifecycle binding...%cReset%
set "APP_PID="
for /f "tokens=2 delims=," %%A in ('tasklist /nh /v /fo csv ^| findstr /i "Vitorius Master Tweaks"') do set "APP_PID=%%~A"

:: Kill existing playback
powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -match 'bgmusic.ps1' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"

echo %cRed%[WORKING] Engaging Native Audio Stream (MP3/WAV)...%cReset%
set "ps1=%TEMP%\bgmusic.ps1"
(
echo param($appPID, $mp3path^)
echo Add-Type -AssemblyName PresentationCore
echo $player = New-Object System.Windows.Media.MediaPlayer
echo $player.Open($mp3path^)
echo Register-ObjectEvent -InputObject $player -EventName MediaEnded -Action { 
echo     $Event.Sender.Position = [TimeSpan]::Zero
echo     $Event.Sender.Play(^) 
echo } ^| Out-Null
echo $player.Play(^)
echo $timer = New-Object System.Timers.Timer(5000^)
echo Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {
echo     if ($appPID^) {
echo         if (-not (Get-Process -Id $appPID -ErrorAction SilentlyContinue^)^) {
echo             [System.Environment]::Exit(0^)
echo         }
echo     }
echo } ^| Out-Null
echo $timer.Start(^)
echo [System.Windows.Threading.Dispatcher]::Run(^)
) > "%ps1%"

start "" powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%ps1%" "%APP_PID%" "%~dp0!mp3name!"

echo %cGreen%[SUCCESS] Audio is now looping in the background.%cReset%
call :log "[MUSIC] Playing: !mp3name!"
pause
goto sub_utilities

:: --- LIVE SYSTEM MONITOR ---
:: FIXED: Proper string interpolation for clean UI rendering
:op_monitor
:op_monitor_loop
cls
echo %cBlue%==========================================================%cReset%
echo %cBlue%        LIVE SYSTEM MONITOR (Auto-refreshes 5s)%cReset%
echo %cBlue%==========================================================%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$cpu = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average;" ^
    "$mem = Get-CimInstance Win32_OperatingSystem;" ^
    "$totalMem = $mem.TotalVisibleMemorySize;" ^
    "$freeMem = $mem.FreePhysicalMemory;" ^
    "$memUsage = [math]::Round((($totalMem - $freeMem) / $totalMem) * 100, 2);" ^
    "Write-Host \"CPU Usage: ${cpu}%% | RAM Usage: ${memUsage}%%\" -ForegroundColor Cyan;" ^
    "try {" ^
    "  $gpu = Get-Counter '\GPU Engine(*)\Utilization Percentage' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Measure-Object -Property CookedValue -Sum;" ^
    "  $gpuVal = [math]::Round($gpu.Sum, 2);" ^
    "  Write-Host \"GPU Usage: ${gpuVal}%%\" -ForegroundColor Green;" ^
    "} catch {" ^
    "  Write-Host 'GPU Usage: Counter Busy/Unavailable' -ForegroundColor Yellow;" ^
    "}" ^
    "Write-Host '---------------------------------------------------------';" ^
    "Write-Host 'TOP 10 PROCESSES (CPU/RAM):' -ForegroundColor White;" ^
    "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 -Property Name, @{N='CPU(s)';E={$_.CPU}}, @{N='RAM(MB)';E={[math]::Round($_.WorkingSet / 1MB, 2)}} | Format-Table -AutoSize"
echo.
choice /c RM /n /t 5 /d R /m "Press [R] to refresh now, or [M] to return to Utilities Menu... "
if errorlevel 2 goto sub_utilities
if errorlevel 1 goto op_monitor_loop

:: =========================================================
:: UTILITY FUNCTIONS (SUBROUTINES)
:: =========================================================

:: --- LOG FUNCTION ---
:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
goto :eof

:: --- REGISTRY BACKUP FUNCTION ---
:backup_reg
:: Usage: call :backup_reg "HKLM\Path\To\Key" "backup_name"
set "REGPATH=%~1"
set "BKNAME=%~2"
set "BKFILE=%BACKUPDIR%\%BKNAME%_%date:~-4%%date:~-7,2%%date:~-10,2%.reg"
reg export "%REGPATH%" "%BKFILE%" /y >nul 2>&1
if %errorlevel% equ 0 (
    echo %cYellow%[BACKUP] Registry key backed up to: %BKFILE%%cReset%
    call :log "[BACKUP] Created registry backup: %BKFILE%"
) else (
    echo %cYellow%[BACKUP-WARN] Could not backup key ^(may not exist or access denied^).%cReset%
    call :log "[BACKUP-WARN] Failed to backup registry key: %REGPATH%"
)
goto :eof

:: --- EXIT ROUTINE ---
:exit_routine
cls
echo %cBlue%Exiting Vitorius Master Tweaks v%VERSION%. Goodbye.%cReset%
call :log "Session ended."
timeout /t 2 >nul
exit /b
