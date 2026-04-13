@echo off
setlocal enabledelayedexpansion

:: ---------------------------------------------------------
:: COLOR VARIABLES (ANSI ESCAPE CODES)
:: ---------------------------------------------------------
for /F %%a in ('"prompt $E$S & echo on & for %%b in (1) do rem"') do set "ESC=%%a"
set "cBlue=%ESC%[94m"
set "cRed=%ESC%[91m"
set "cReset=%ESC%[0m"

title Vitorius Master Tweaks

:: ---------------------------------------------------------
:: 1. FULL ELEVATION BYPASS (MUST BE FIRST)
:: ---------------------------------------------------------
reg query "HKU\S-1-5-19\Software" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo %cRed%#######################################################%cReset%
    echo %cRed%# ERROR: ACCESS DENIED                                #%cReset%
    echo %cRed%#######################################################%cReset%
    echo %cRed%# Right-click this file and 'Run as Administrator'.   #%cReset%
    echo %cRed%#######################################################%cReset%
    pause
    exit /b
)

:: ---------------------------------------------------------
:: 2. STARTUP BANNER & MANTRA
:: ---------------------------------------------------------
cls
echo.
echo %cBlue% _____                     _   _  _      _                               %cReset%
echo %cBlue%/  __ \                   / \ ^| ^|^| ^|    ^| ^|                               %cReset%
echo %cBlue%^| /  \/ _ __  __ _  ____  /  ^  \ ^| ^| ___^| ^|__   ___ _ __ ___  _   _      %cReset%
echo %cBlue%^| ^|    ^| '__^|/ _` ^|^|_  / / /_\ \^| ^|/ __^| '_ \ / _ \ '_ ` _ \^| ^| ^| ^|    %cReset%
echo %cBlue%^| \__/\^| ^|  ^| (_^| ^| / / /  ___  \^| ^| (__^| ^| ^| ^|  __/ ^| ^| ^| ^| ^| ^|_^| ^|    %cReset%
echo %cBlue% \____/^|_^|   \__,_^|/___^|\_/   \_/_^|\___^|_^| ^|_^|\___^|_^| ^|_^| ^|_^|\__, ^|    %cReset%
echo %cBlue%                                                             __/ ^|    %cReset%
echo %cBlue%                                                            ^|___/     %cReset%
echo.
echo    We Are One, We Are Many, We Are Crazy Alchemy 332
echo.
echo %cRed%[INFO] Loading creator Vitorius configurations version 1.21%cReset%
timeout /t 6 /nobreak >nul

:menu
cls
echo ======================================================
echo                  VITORIUS MASTER TWEAKS
echo ======================================================
echo %cBlue%1.  Create Heavy System Restore Point (Failsafe)%cReset%
echo %cBlue%2.  Update Hosts (Deep Blacklist ^& Telemetry Block)%cReset%
echo %cBlue%3.  Clear ALL Event Logs (Forceful Dual-Pass Bypass)%cReset%
echo %cBlue%4.  Disable IPv6 (Kernel Level)%cReset%
echo %cBlue%5.  DNS Options ^& Winsock Reset%cReset%
echo %cBlue%6.  Intel Heavy Auto-Optimization (Aggressive Scheduling)%cReset%
echo %cBlue%7.  Ryzen Heavy Optimization (Infinity Fabric Override)%cReset%
echo %cBlue%8.  Modify Security (Deep Registry Hardening)%cReset%
echo %cBlue%9.  NVIDIA RTX Performance (MSI ^& Preemption Tweaks)%cReset%
echo %cBlue%10. AMD RX Performance (ULPS Disable)%cReset%
echo %cBlue%11. Secure Updates Only (Kill Telemetry ^& P2P)%cReset%
echo %cBlue%12. Heavy Server Load (Intel - TCP Stack Hardening)%cReset%
echo %cBlue%13. Heavy Server Load (Ryzen - I/O ^& NUMA Hardening)%cReset%
echo %cBlue%14. System Core Scan (Deep Component Cleanup ^& DISM)%cReset%
echo %cBlue%15. Change Admin Password (Force Complexity)%cReset%
echo %cBlue%16. Reboot Options (Force Close Apps)%cReset%
echo %cBlue%17. Shutdown Options (Force Close Apps)%cReset%
echo %cBlue%18. VPN vs Gaming Latency (BBR Congestion Control)%cReset%
echo %cBlue%19. Reset Wallpaper ^& Wipe Theme Cache%cReset%
echo %cBlue%20. Advanced Boot Subsystem (Legacy F8 ^& No GUI)%cReset%
echo %cBlue%21. Clear Temporary Files (Prefetch ^& Update Cache)%cReset%
echo %cBlue%22. Smart Optimize (Drive Trim ^& MFT Defrag)%cReset%
echo %cBlue%23. Offline Browser Trace ^& Cookie Cleaner%cReset%
echo %cBlue%24. Play Background Music (Loop MP3)%cReset%
echo %cBlue%25. Live System Resource Monitor (CPU/RAM/GPU)%cReset%
echo %cBlue%26. Paranoid Security (Extreme Lockdown)%cReset%
echo %cBlue%27. Exit%cReset%
echo ======================================================
set /p choice="Select an option (1-26): "

:: --- MAPPINGS ---
if "%choice%"=="1" goto op1
if "%choice%"=="2" goto op2
if "%choice%"=="3" goto op3
if "%choice%"=="4" goto op4
if "%choice%"=="5" goto op5
if "%choice%"=="6" goto op6
if "%choice%"=="7" goto op7
if "%choice%"=="8" goto op8
if "%choice%"=="9" goto op9
if "%choice%"=="10" goto op10
if "%choice%"=="11" goto op11
if "%choice%"=="12" goto op12
if "%choice%"=="13" goto op13
if "%choice%"=="14" goto op14
if "%choice%"=="15" goto op15
if "%choice%"=="16" goto op16
if "%choice%"=="17" goto op17
if "%choice%"=="18" goto op18
if "%choice%"=="19" goto op19
if "%choice%"=="20" goto op20
if "%choice%"=="21" goto op21
if "%choice%"=="22" goto op22
if "%choice%"=="23" goto op23
if "%choice%"=="24" goto op24
if "%choice%"=="25" goto op25
if "%choice%"=="26" goto op26
if "%choice%"=="27" goto exit_routine
goto menu

:: --- OPTION 1: HEAVY SYSTEM RESTORE POINT (FAILSAFE) ---
:op1
cls
echo.
echo %cRed%[INFO] Initializing Core System Failsafe Protocol...%cReset%
echo %cRed%[BACKGROUND] Ensuring OS Rollback capabilities before applying kernel and registry level mutations.%cReset%

echo %cRed%[REGISTRY] Overriding Windows 24-Hour Checkpoint Frequency Limit...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f >nul 2>&1

echo %cRed%[KERNEL] Engaging Volume Shadow Copy Service (VSS) on OS Drive...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue" >nul 2>&1

echo %cRed%[WORKING] Generating VITORIUS MASTER TWEAKS Snapshot. This may take a minute...%cReset%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Vitorius Master Pre-Tweak' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue"

if %errorlevel% equ 0 (
    echo %cRed%[SUCCESS] Immutable OS Restore Point established.%cReset%
) else (
    echo %cRed%[WARNING] Restore Point creation bypassed. VSS may be deeply disabled.%cReset%
)
pause
goto menu

:: --- OPTION 2: DEEP BLACKLIST ---
:op2
echo.
echo %cRed%[INFO] Target: Top 10 Blacklist Repositories%cReset%
echo %cRed%[BACKGROUND] Replacing native hosts file to route telemetry, ad-networks, and malicious domains directly to 0.0.0.0, blocking them at the OS level.%cReset%

echo %cRed%[WORKING] Downloading secure hosts file from GitHub...%cReset%
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' -OutFile '%TEMP%\hosts'"

echo %cRed%[WORKING] Purging duplicates and sorting alphanumerically...%cReset%
set "DOMAIN_COUNT=0"
for /f "usebackq tokens=*" %%c in (`powershell -NoProfile -Command "$path = $env:TEMP + '\hosts'; $cleanPath = $env:TEMP + '\hosts_clean'; if (Test-Path $path) { $h = [System.IO.File]::ReadAllLines($path); $u = $h -match '^0\.0\.0\.0\s+' | Sort-Object -Unique; $out = [System.Collections.Generic.List[string]]::new(); $out.Add('127.0.0.1 localhost'); $out.Add('::1 localhost'); $out.AddRange($u); [System.IO.File]::WriteAllLines($cleanPath, $out); $u.Count } else { '0' }"`) do (
    set "DOMAIN_COUNT=%%c"
)

echo %cRed%[WORKING] Overwriting system hosts in System32\drivers\etc...%cReset%
copy /y "%TEMP%\hosts_clean" "C:\Windows\System32\drivers\etc\hosts" >nul

echo %cRed%[KERNEL] Flushing DNS resolver cache to enforce new routing...%cReset%
call ipconfig /flushdns >nul

echo %cRed%[SUCCESS] Hosts updated! Locked and blocked %DOMAIN_COUNT% unique domains.%cReset%
pause
goto menu

:: --- OPTION 3: FORCEFUL LOG CLEAR ---
:op3
echo.
echo %cRed%[INFO] Initiating Forceful Dual-Pass Log Bypass...%cReset%
echo %cRed%[BACKGROUND] Windows stores deep diagnostic data in Event Logs. Clearing these frees up MFT records and destroys forensic diagnostic traces.%cReset%
echo %cRed%[WORKING] Pass 1: Standard command-line wipe (wevtutil)...%cReset%
for /F "tokens=*" %%G in ('wevtutil.exe el') do (call wevtutil.exe cl "%%G" 2>nul)
echo %cRed%[WORKING] Pass 2: Bypassing Access Denied blocks via .NET EventSession API...%cReset%
powershell -Command "Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -gt 0} | ForEach-Object { try { [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($_.LogName) } catch { } }"
echo %cRed%[SUCCESS] All telemetry and event logs eradicated.%cReset%
pause
goto menu

:: --- OPTION 4: KERNEL LEVEL IPV6 DISABLE ---
:op4
echo.
echo %cRed%[INFO] Targeting IPv6 Network Stack...%cReset%
echo %cRed%[BACKGROUND] IPv6 can cause DNS leaks, broadcast overhead, and latency spikes in strictly IPv4 environments (like most gaming/VPN setups).%cReset%
echo %cRed%[WORKING] Unbinding IPv6 from all active physical and virtual adapters...%cReset%
powershell -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_tcpip6"
echo %cRed%[REGISTRY] Setting DisabledComponents to 255 (Hard Disable)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f >nul
echo %cRed%[SUCCESS] IPv6 completely disabled at kernel level.%cReset%
pause
goto menu

:: --- OPTION 5: DNS & WINSOCK RESET ---
:op5
cls
echo %cRed%[INFO] Select Custom DNS Routing%cReset%
echo %cRed%[BACKGROUND] Rebuilding the TCP/IP stack resolves corrupted network caches, while custom DNS routes requests faster than default ISP servers.%cReset%
echo %cBlue%1. Cloudflare (1.1.1.1 / 1.0.0.1) - Fastest Latency%cReset%
echo %cBlue%2. Google (8.8.8.8 / 8.8.4.4) - Highest Reliability%cReset%
echo %cBlue%3. Malware ^& Adult Filter (1.1.1.3 / 1.1.1.2) - Secure Routing%cReset%
set /p nch="Choice: "
echo %cRed%[WORKING] Applying DNS Addresses to all NetAdapters...%cReset%
if "%nch%"=="1" powershell -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '1.1.1.1','1.0.0.1'"
if "%nch%"=="2" powershell -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '8.8.8.8','8.8.4.4'"
if "%nch%"=="3" powershell -Command "Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '1.1.1.3','1.1.1.2'"
echo %cRed%[KERNEL] Resetting Winsock TCP/IP interface...%cReset%
call netsh winsock reset >nul 2>&1
echo %cRed%[KERNEL] Flushing IP configurations...%cReset%
call ipconfig /flushdns >nul 2>&1
echo %cRed%[SUCCESS] Deep DNS and Routing Applied.%cReset%
pause
goto menu

:: --- OPTION 6: INTEL 12TH GEN+ SCHEDULING (SAFE HIGH PERFORMANCE) ---
:op6
echo.
echo %cRed%[INFO] Intel 12th Gen+ Thread Director Optimization%cReset%
echo %cRed%[BACKGROUND] Modern hybrid CPUs rely on native hardware telemetry (Intel ITD). Hardcoding legacy scheduler values breaks P-Core/E-Core assignment. This mode enforces max performance while keeping the Thread Director active.%cReset%

echo %cRed%[WORKING] Restoring native energy estimation for Thread Director accuracy...%cReset%
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /f >nul 2>&1

echo %cRed%[REGISTRY] Enabling Windows Game Mode (Foreground Priority)...%cReset%
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1

echo %cRed%[WORKING] Forcing High Performance Power Profile to unpark P-Cores...%cReset%
call powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

echo %cRed%[SUCCESS] Intel Power and Scheduler states safely optimized.%cReset%

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
echo %cRed%[SUCCESS] Intel Deep Optimization Applied.%cReset%
pause
goto menu

:: --- OPTION 7: RYZEN INFINITY FABRIC OVERRIDE ---
:op7
cls
echo %cRed%[INFO] Select Target Architecture%cReset%
echo %cRed%[BACKGROUND] Ryzen architectures rely heavily on Infinity Fabric and Collaborative Power Performance Control (CPPC). We must align the OS scheduler to match AMD's core complexes (CCX).%cReset%
echo %cBlue%1. Ryzen 5000 Series (Zen 3)%cReset%
echo %cBlue%2. Ryzen 7000 Series (Zen 4)%cReset%
echo %cBlue%3. Ryzen 9000 Series (Zen 5)%cReset%
set /p ry_c="Architecture: "
echo %cRed%[KERNEL] Unparking logical cores (CPMINCORES 100)...%cReset%
call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
echo %cRed%[REGISTRY] Elevating foreground System Responsiveness and Win32 Separator...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1

if "%ry_c%"=="1" (
    echo %cRed%[REGISTRY] Expanding LargeSystemCache for Zen 3 L3 mapping...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
)
if "%ry_c%"=="2" (
    echo %cRed%[REGISTRY] Boosting PCIe 5.0 I/O limits for Zen 4 bandwidth...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 983040 /f >nul 2>&1
)
if "%ry_c%"=="3" (
    echo %cRed%[REGISTRY] Tuning Zen 5 Interrupt Distribution and massive I/O thresholds...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v DistributeInterrupts /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 1048576 /f >nul 2>&1
)
echo %cRed%[KERNEL] Committing Advanced Power Profile...%cReset%
call powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo %cRed%[SUCCESS] Ryzen Infinity Optimization Applied.%cReset%
pause
goto menu

:: --- OPTION 8: DEEP SECURITY HARDENING ---
:op8
cls
echo %cRed%[INFO] Select Security Posture%cReset%
echo %cRed%[BACKGROUND] Standard Windows security is permissive. These profiles manipulate UAC, Windows Defender heuristics, Execution Policies, and Local Security Authority (LSA) limits.%cReset%
echo %cBlue%1. Mid Range (Balanced)%cReset%
echo %cBlue%2. High Range (Active Defender ^& Script Limits)%cReset%
echo %cBlue%3. Extreme (Maximum Home Defense ^& Anti-Exploit)%cReset%
echo %cBlue%4. Corporate (Full Lockdown ^& SMBv1 Kill)%cReset%
echo %cBlue%5. Cancel and Go Back%cReset%

set "sec_choice="
set /p sec_choice="Choice: "
set sec_choice=%sec_choice:"=%

if "%sec_choice%"=="1" goto deploy_sec_1
if "%sec_choice%"=="2" goto deploy_sec_2
if "%sec_choice%"=="3" goto deploy_sec_3
if "%sec_choice%"=="4" goto deploy_sec_4
if "%sec_choice%"=="5" goto menu
goto op8

:deploy_sec_1
echo %cRed%[WORKING] Hardening system policies...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Force"
goto sec_success

:deploy_sec_2
echo %cRed%[WORKING] Hardening system policies...%cReset%
echo %cRed%[REGISTRY] Enforcing UAC prompts and enabling PUA Protection...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -PUAProtection Enabled"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul 2>&1
goto sec_success

:deploy_sec_3
echo %cRed%[WORKING] Hardening system policies...%cReset%
echo %cRed%[REGISTRY] Mandating signed scripts, Controlled Folder Access, and LSA Protection (RunAsPPL)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy AllSigned -Force"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -EnableControlledFolderAccess Enabled"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 1 /f >nul 2>&1
goto sec_success

:deploy_sec_4
echo %cRed%[WORKING] Hardening system policies...%cReset%
echo %cRed%[KERNEL] Disabling Guest accounts, enforcing blank password limits, killing WSH, and stripping SMBv1...%cReset%
call net user guest /active:no >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart"
goto sec_success

:sec_success
echo %cRed%[SUCCESS] Security Profile Deployed.%cReset%
pause
goto menu

:: --- OPTION 9: NVIDIA RTX LATENCY (PREEMPTION) ---
:op9
echo.
echo %cRed%[INFO] Targeting NVIDIA GPU Subsystem...%cReset%
echo %cRed%[BACKGROUND] Modifying the graphics driver scheduler to utilize Hardware-Accelerated GPU Scheduling (HWSchMode) and enabling strict execution Preemption to drop frame latency.%cReset%
echo %cRed%[REGISTRY] Enabling HwSchMode (Value 2)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
echo %cRed%[REGISTRY] Activating GPU Preemption overriding standard WDDM queues...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v EnablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
echo %cRed%[SUCCESS] RTX Low-Latency Architecture Applied.%cReset%
pause
goto menu

:: --- OPTION 10: AMD RX LATENCY (ULPS) ---
:op10
echo.
echo %cRed%[INFO] Targeting AMD GPU Subsystem...%cReset%
echo %cRed%[BACKGROUND] AMD cards utilize Ultra Low Power State (ULPS) which severely throttles clock recovery times. We are searching the registry class to hard-disable this feature.%cReset%
echo %cRed%[WORKING] Iterating through Class {4d36e968-e325-11ce-bfc1-08002be10318} to disable ULPS...%cReset%
powershell -Command "Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\00*' -ErrorAction SilentlyContinue | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'EnableUlps' -Value 0 -ErrorAction SilentlyContinue }"
echo %cRed%[REGISTRY] Enabling Hardware Scheduling (HwSchMode 2)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
echo %cRed%[SUCCESS] AMD Performance State Locked.%cReset%
pause
goto menu

:: --- OPTION 11: SECURE UPDATES / TELEMETRY KILL ---
:op11
echo.
echo %cRed%[INFO] Modifying Windows Update Framework...%cReset%
echo %cRed%[BACKGROUND] Microsoft uses forced telemetry and background Peer-to-Peer (Delivery Optimization) to share updates, eating bandwidth. This locks updates to critical-only.%cReset%
echo %cRed%[REGISTRY] Setting AUOptions to 2 (Notify before download/install)...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul 2>&1
echo %cRed%[REGISTRY] Nullifying AllowTelemetry collection...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[REGISTRY] Killing DODownloadMode (Disabling P2P update sharing)...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[SUCCESS] OS Locked to Secure Patches Only.%cReset%
pause
goto menu

:: --- OPTION 12: DYNAMIC RAM & HEAVY SERVER LOAD (TCP) ---
:op12
echo.
echo %cRed%[INFO] Dynamic Memory ^& Network Optimization...%cReset%
set "RAM_GB=16"
echo %cRed%[WORKING] Detecting System RAM...%cReset%
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)" 2^>nul`) do (
    set "RAM_GB=%%A"
)
set /a RAM_GB=%RAM_GB% 2>nul
if "%RAM_GB%"=="0" set "RAM_GB=16"
echo %cRed%[INFO] Detected/Using %RAM_GB% GB of Physical Memory.%cReset%
set "IOPAGE=1048576"
set "RAM_PROF=Extreme RAM (128GB+)"
if %RAM_GB% LEQ 64 (
    set "IOPAGE=524288"
    set "RAM_PROF=Ultra RAM (64GB)"
)
if %RAM_GB% LEQ 32 (
    set "IOPAGE=262144"
    set "RAM_PROF=High RAM (32GB)"
)
if %RAM_GB% LEQ 16 (
    set "IOPAGE=131072"
    set "RAM_PROF=Standard RAM (16GB)"
)
if %RAM_GB% LEQ 8 (
    set "IOPAGE=65536"
    set "RAM_PROF=Low RAM (8GB)"
)
echo %cRed%[INFO] %RAM_PROF% profile loaded.%cReset%
echo %cRed%[REGISTRY] Setting IoPageLockLimit to %IOPAGE%...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d %IOPAGE% /f >nul 2>&1
echo %cRed%[REGISTRY] Ensuring Legacy LargeSystemCache is disabled...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
echo %cRed%[KERNEL] Optimizing TCP/IP Stack for Server/Heavy Load...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1
call netsh int tcp set global rss=enabled >nul 2>&1
call netsh int tcp set global autotuninglevel=normal >nul 2>&1
echo %cRed%[SUCCESS] Dynamic RAM and TCP optimization applied.%cReset%
pause
goto menu

:: --- OPTION 13: RYZEN SERVER LOAD (NUMA HARDENING) ---
:op13
echo.
echo %cRed%[INFO] Detecting Ryzen Subsystem Natively...%cReset%
echo %cRed%[BACKGROUND] Ryzen architectures require modified Non-Uniform Memory Access (NUMA) parameters and lifted I/O page limits to handle massive concurrent server threads.%cReset%
echo %cRed%[REGISTRY] Disabling Network Throttling Index...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v Size /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v ProcessorNameString | findstr /i "5000 7000 9000" >nul
if %errorlevel% equ 0 (
    echo %cRed%[REGISTRY] Zen 3+ Detected. Unlocking IoPageLockLimit for massive throughput...%cReset%
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 983040 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 24 /f >nul 2>&1
) else (
    echo %cRed%[KERNEL] Legacy Ryzen Detected. Restricting power saving C-States...%cReset%
    call powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
)
echo %cRed%[SUCCESS] Ryzen Server Optimization Active.%cReset%
pause
goto menu

:: --- OPTION 14: SYSTEM SCAN (DEEP COMPONENT) ---
:op14
echo.
echo %cRed%[INFO] Launching Deep Core Repair Protocols...%cReset%
echo %cRed%[BACKGROUND] Windows Deployment Image Servicing and Management (DISM) will verify the native component store, followed by System File Checker (SFC) replacing any corrupt system DLLs.%cReset%
echo %cRed%[WORKING] Stage 1: Running DISM Component Store Cleanup (Purging superseded packages)...%cReset%
call DISM /Online /Cleanup-Image /StartComponentCleanup
echo %cRed%[WORKING] Stage 2: Restoring OS Health from Windows Update payload...%cReset%
call DISM /Online /Cleanup-Image /RestoreHealth
echo %cRed%[WORKING] Stage 3: Scanning OS Integrity (SFC)...%cReset%
call sfc /scannow
echo %cRed%[SUCCESS] Core OS Verification Complete.%cReset%
pause
goto menu

:: --- OPTION 15: CHANGE ADMIN PASS (COMPLEXITY) ---
:op15
echo.
echo %cRed%[INFO] Requesting Security Override...%cReset%
echo %cRed%[BACKGROUND] Forcing strict net account policies locally before issuing a direct RPC command to overwrite the current user's password hash.%cReset%
echo %cRed%[KERNEL] Forcing complexity rules (Min 8 chars, Unlimited Age)...%cReset%
call net accounts /maxpwage:unlimited /minpwlen:8 >nul 2>&1

:op15_prompt
set /p opass="Enter Current Password: "
set /p npass="Enter New Password: "
set /p npass2="Retype New Password: "

if not "%npass%"=="%npass2%" (
    echo.
    echo %cRed%[ERROR] Passwords do not match! Please try again.%cReset%
    echo.
    goto op15_prompt
)
echo %cRed%[KERNEL] Committing local credential via NET USER...%cReset%
call net user "%username%" "%npass%" >nul 2>&1

if %errorlevel% equ 0 (
    echo %cRed%[SUCCESS] Hash Updated Successfully.%cReset%
) else (
    echo %cRed%[ERROR] Failed to update. Password may not meet the 8-character minimum complexity.%cReset%
)
pause
goto menu

:: --- OPTION 16: REBOOT OPTIONS (FORCE) ---
:op16
cls
echo %cRed%[INFO] Execute Hard Reboot Command%cReset%
echo %cRed%[BACKGROUND] Uses shutdown.exe to send a direct interrupt to the kernel, bypassing application hang states (Force Flag /f).%cReset%
echo %cBlue%1. Reboot in 2m%cReset%
echo %cBlue%2. Reboot in 5m%cReset%
set /p rbt="Choice: "

if "%rbt%"=="1" goto rbt_1
if "%rbt%"=="2" goto rbt_2
goto menu

:rbt_1
shutdown.exe /r /f /t 120
echo %cRed%[SUCCESS] RPC Reboot signal sent (120s).%cReset%
pause
goto menu

:rbt_2
shutdown.exe /r /f /t 300
echo %cRed%[SUCCESS] RPC Reboot signal sent (300s).%cReset%
pause
goto menu

:: --- OPTION 17: SHUTDOWN OPTIONS (FORCE) ---
:op17
cls
echo %cRed%[INFO] Execute Hard Shutdown Command%cReset%
echo %cRed%[BACKGROUND] Uses shutdown.exe to send a direct ACPI power down signal to the kernel, forcing hung processes to terminate.%cReset%
echo %cBlue%1. Shutdown in 2m%cReset%
echo %cBlue%2. Shutdown in 5m%cReset%
set /p sht="Choice: "

if "%sht%"=="1" goto sht_1
if "%sht%"=="2" goto sht_2
goto menu

:sht_1
shutdown.exe /s /f /t 120
echo %cRed%[SUCCESS] RPC Shutdown signal sent (120s).%cReset%
pause
goto menu

:sht_2
shutdown.exe /s /f /t 300
echo %cRed%[SUCCESS] RPC Shutdown signal sent (300s).%cReset%
pause
goto menu

:: --- OPTION 18: VPN / GAMING TWEAKS (BBR) ---
:op18
cls
echo %cRed%[INFO] Target Network Stack Topology%cReset%
echo %cRed%[BACKGROUND] Gaming requires TCPNoDelay (Nagle's Algorithm disable) to process tiny packets fast. VPNs require strict MTU limits to prevent packet fragmentation. BBR2 is a modern Google congestion algorithm.%cReset%
echo %cBlue%1. Optimize FOR VPN (MTU Tweak ^& Stability)%cReset%
echo %cBlue%2. Optimize WITHOUT VPN (Raw Latency ^& BBR Congestion)%cReset%
set /p vpnch="Choice: "
echo %cRed%[WORKING] Rewriting Network Registries...%cReset%
if "%vpnch%"=="1" (
    echo %cRed%[KERNEL] Clamping MTU to 1400 to prevent VPN encapsulation drops...%cReset%
    call netsh interface ipv4 set subinterface "Ethernet" mtu=1400 store=persistent >nul 2>&1
    call netsh interface ipv4 set subinterface "Wi-Fi" mtu=1400 store=persistent >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)
if "%vpnch%"=="2" (
    echo %cRed%[KERNEL] Restoring MTU 1500 and wiping NetworkThrottlingIndex...%cReset%
    call netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
    powershell -Command "Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\* | ForEach-Object {Set-ItemProperty $_.PSPath -Name TcpAckFrequency -Value 1 -ErrorAction SilentlyContinue}"
    echo %cRed%[KERNEL] Injecting advanced BBR2 Congestion Provider into TCP stack...%cReset%
    call netsh int tcp set supplemental template=custom icw=10 congestionprovider=bbr2 >nul 2>&1
)
echo %cRed%[SUCCESS] Network Modification Complete.%cReset%
pause
goto menu

:: --- OPTION 19: RESET WALLPAPER/SCREENSAVER (WIPE CACHE) ---
:op19
echo.
echo %cRed%[INFO] Initializing Theme Purge...%cReset%
echo %cRed%[BACKGROUND] Windows caches compressed wallpapers in hidden AppData directories. We delete these files and force the Desktop Window Manager (DWM) to reload registry defaults.%cReset%
echo %cRed%[WORKING] Destroying cached TranscodedWallpaper files...%cReset%
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*" >nul 2>&1
echo %cRed%[REGISTRY] Overwriting HKCU Desktop variables...%cReset%
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d "" /f >nul 2>&1
echo %cRed%[WORKING] Broadcasting update signal via user32.dll...%cReset%
call RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo %cRed%[SUCCESS] Desktop reset to factory default.%cReset%
pause
goto menu

:: --- OPTION 20: ADVANCED BOOT SUBSYSTEM (FLATTENED / CRASH PROOF) ---
:op20
cls
echo %cRed%[INFO] Advanced Kernel Boot Subsystem%cReset%
echo %cRed%[BACKGROUND] Interacts directly with the Windows Boot Configuration Data (BCD). Allows overriding default GUI loads, disabling auto-repair loops, and restoring the legacy F8 interrupt key.%cReset%
echo %cBlue%1. Enable Legacy F8 Boot Menu ^& Disable Auto-Repair%cReset%
echo %cBlue%2. Enable "No GUI" Boot (Faster Startup)%cReset%
echo %cBlue%3. Reboot to Safe Mode (Minimal)%cReset%
echo %cBlue%4. Reboot to Safe Mode (With Networking)%cReset%
echo %cBlue%5. Restore Default Normal Boot%cReset%
set /p bootmode="Choice: "

if "%bootmode%"=="1" goto boot_1
if "%bootmode%"=="2" goto boot_2
if "%bootmode%"=="3" goto boot_3
if "%bootmode%"=="4" goto boot_4
if "%bootmode%"=="5" goto boot_5
goto menu

:boot_1
echo %cRed%[KERNEL] Injecting Legacy F8 Menu into BCD...%cReset%
bcdedit /set {default} bootmenupolicy legacy >nul 2>&1
echo %cRed%[KERNEL] Disabling Auto-Repair loops and ignoring failures...%cReset%
bcdedit /set {default} recoveryenabled No >nul 2>&1
bcdedit /set {default} bootstatuspolicy ignoreallfailures >nul 2>&1
echo %cRed%[SUCCESS] Bootloader hardened.%cReset%
pause
goto menu

:boot_2
echo %cRed%[KERNEL] Stripping Windows Boot GUI from BCD global settings...%cReset%
bcdedit /set {globalsettings} custom:16000067 true >nul 2>&1
bcdedit /set {default} quietboot yes >nul 2>&1
bcdedit /set {default} bootuxdisabled on >nul 2>&1
echo %cRed%[SUCCESS] Headless boot enabled.%cReset%
pause
goto menu

:boot_3
echo %cRed%[KERNEL] Sidelining OS hibernation (powercfg /h off)...%cReset%
powercfg /h off >nul 2>&1
echo %cRed%[KERNEL] Writing Safe Mode (Minimal) to current BCD identifier...%cReset%
bcdedit /set {current} safeboot minimal >nul 2>&1
echo %cRed%[SUCCESS] Executing Hard Reboot...%cReset%
shutdown.exe /r /f /t 0
goto menu

:boot_4
echo %cRed%[KERNEL] Sidelining OS hibernation (powercfg /h off)...%cReset%
powercfg /h off >nul 2>&1
echo %cRed%[KERNEL] Writing Safe Mode (Network) to current BCD identifier...%cReset%
bcdedit /set {current} safeboot network >nul 2>&1
echo %cRed%[SUCCESS] Executing Hard Reboot...%cReset%
shutdown.exe /r /f /t 0
goto menu

:boot_5
echo %cRed%[KERNEL] Purging Safe Mode flags from current BCD...%cReset%
bcdedit /deletevalue {current} safeboot >nul 2>&1
echo %cRed%[KERNEL] Restoring Standard Boot Menu and Recovery logic...%cReset%
bcdedit /set {default} bootmenupolicy standard >nul 2>&1
bcdedit /set {default} recoveryenabled Yes >nul 2>&1
bcdedit /deletevalue {default} quietboot >nul 2>&1
echo %cRed%[SUCCESS] Normal boot restored.%cReset%
pause
goto menu

:: --- OPTION 21: TEMP CLEANER (PREFETCH & UPDATES) ---
:op21
echo.
echo %cRed%[INFO] Executing Volatile Memory Purge...%cReset%
echo %cRed%[BACKGROUND] Eliminates fragmented temporary data. Deleting Prefetch forces Windows to rebuild optimal load paths for software. Deleting SoftwareDistribution clears corrupted Windows Update payloads.%cReset%
echo %cRed%[WORKING] Wiping User AppData Temps...%cReset%
del /s /f /q %temp%\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping Core System Temps...%cReset%
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping SuperFetch / Prefetch Data...%cReset%
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1
echo %cRed%[WORKING] Wiping Stale Windows Updates (SoftwareDistribution)...%cReset%
del /s /f /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
echo %cRed%[SUCCESS] Storage Optimization Complete.%cReset%
pause
goto menu

:: --- OPTION 22: SMART SSD/HDD OPTIMIZE (MFT DEFRAG) ---
:op22
echo.
echo %cRed%[INFO] Accessing Logical Disk Manager...%cReset%
echo %cRed%[BACKGROUND] Ensures native OS TRIM functionality is active, then executes a PowerShell command to identify Fixed Drive types, applying a Retrim for SSD/NVMe or a Defrag for HDD.%cReset%
echo %cRed%[KERNEL] Ensuring Native FSUTIL DisableDeleteNotify is 0 (TRIM Enabled)...%cReset%
call fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
echo %cRed%[WORKING] Parsing Fixed Drives for Defrag/ReTrim execution via Storage API...%cReset%
powershell -Command "Get-Volume | Where-Object {$_.DriveType -eq 'Fixed'} | Optimize-Volume -Defrag -ReTrim -Verbose"
echo %cRed%[SUCCESS] Volume I/O Restored.%cReset%
pause
goto menu

:: --- OPTION 23: OFFLINE BROWSER TRACE & COOKIE CLEANER ---
:op23
echo.
echo %cRed%[INFO] Initializing Offline Browser Trace ^& Cookie Cleaner...%cReset%
echo %cRed%[BACKGROUND] Forcibly closing browsers to unlock files, then wiping cache, cookies, and history across major browsers locally.%cReset%

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

echo %cRed%[KERNEL] Executing Windows Internet Cache wipe (Sync)...%cReset%
start /wait "" RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255

echo %cRed%[SUCCESS] All browser traces and cookies eradicated offline.%cReset%
pause
goto menu

:: --- OPTION 24: BACKGROUND MUSIC (MP3 LOOP) ---
:op24
cls
echo %cRed%[INFO] Initializing Background Audio Subsystem...%cReset%
echo %cRed%[BACKGROUND] Spawning an invisible audio host hooked to this CMD instance.%cReset%
echo.
echo %cBlue%1. Play "trough-pain-comes-salvation.mp3" (Default)%cReset%
echo %cBlue%2. Enter a custom MP3 filename%cReset%
echo %cBlue%3. Stop current music%cReset%
echo %cBlue%4. Return to Main Menu%cReset%
set /p m_choice="Select Audio Option (1-4): "

if "%m_choice%"=="1" set "mp3name=trough-pain-comes-salvation.mp3"
if "%m_choice%"=="2" set /p mp3name="Enter the exact MP3 filename (e.g., song.mp3): "
if "%m_choice%"=="3" (
    wmic process where "name='wscript.exe' and commandline like '%%vbgm.vbs%%'" call terminate >nul 2>&1
    echo.
    echo %cRed%[SUCCESS] Audio playback stopped.%cReset%
    pause
    goto menu
)
if "%m_choice%"=="4" goto menu

if not exist "%~dp0!mp3name!" (
    echo.
    echo %cRed%[ERROR] File '!mp3name!' not found! Ensure it is in the exact same folder as this script.%cReset%
    pause
    goto menu
)

echo %cRed%[WORKING] Locating App Process ID (PID) for lifecycle binding...%cReset%
set "APP_PID="
for /f "tokens=2 delims=," %%A in ('tasklist /nh /v /fo csv ^| findstr /i "Vitorius Master Tweaks"') do set "APP_PID=%%~A"

echo %cRed%[WORKING] Generating VBScript Audio Host...%cReset%
wmic process where "name='wscript.exe' and commandline like '%%vbgm.vbs%%'" call terminate >nul 2>&1

echo Set wmp = CreateObject("WMPlayer.OCX"^) > "%TEMP%\vbgm.vbs"
echo wmp.settings.setMode "loop", True >> "%TEMP%\vbgm.vbs"
echo wmp.URL = WScript.Arguments(0^) >> "%TEMP%\vbgm.vbs"
echo wmp.controls.play >> "%TEMP%\vbgm.vbs"
echo Set objWMI = GetObject("winmgmts:\\.\root\cimv2"^) >> "%TEMP%\vbgm.vbs"
echo appPID = WScript.Arguments(1^) >> "%TEMP%\vbgm.vbs"
echo Do While wmp.playState ^<^> 1 >> "%TEMP%\vbgm.vbs"
echo      WScript.Sleep 2000 >> "%TEMP%\vbgm.vbs"
echo      If Len(appPID^) ^> 0 Then >> "%TEMP%\vbgm.vbs"
echo          Set colProc = objWMI.ExecQuery("Select * from Win32_Process where ProcessID = " ^& appPID^) >> "%TEMP%\vbgm.vbs"
echo          If colProc.Count = 0 Then Exit Do >> "%TEMP%\vbgm.vbs"
echo      End If >> "%TEMP%\vbgm.vbs"
echo Loop >> "%TEMP%\vbgm.vbs"

echo %cRed%[WORKING] Engaging Audio Stream...%cReset%
start "" wscript "%TEMP%\vbgm.vbs" "%~dp0!mp3name!" "!APP_PID!"

echo %cRed%[SUCCESS] Audio is now looping in the background.%cReset%
pause
goto menu

:: --- OPTION 25: LIVE SYSTEM RESOURCE MONITOR ---
:op25
:op25_loop
cls
echo ======================================================
echo               LIVE SYSTEM MONITOR (Auto-refreshes 5s)
echo ======================================================
:: Using a more stable PowerShell block
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$cpu = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average;" ^
    "$mem = Get-WmiObject Win32_OperatingSystem;" ^
    "$totalMem = $mem.TotalVisibleMemorySize;" ^
    "$freeMem = $mem.FreePhysicalMemory;" ^
    "$memUsage = [math]::Round((($totalMem - $freeMem) / $totalMem) * 100, 2);" ^
    "Write-Host 'CPU Usage: ' $cpu'%% | RAM Usage: ' $memUsage'%%' -ForegroundColor Cyan;" ^
    "try {" ^
    "  $gpu = Get-Counter '\GPU Engine(*)\Utilization Percentage' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Measure-Object -Property CookedValue -Sum;" ^
    "  $gpuVal = [math]::Round($gpu.Sum, 2);" ^
    "  Write-Host 'GPU Usage: ' $gpuVal'%%' -ForegroundColor Green;" ^
    "} catch {" ^
    "  Write-Host 'GPU Usage: Counter Busy/Unavailable' -ForegroundColor Yellow;" ^
    "}" ^
    "Write-Host '---------------------------------------------------------';" ^
    "Write-Host 'TOP 10 PROCESSES (CPU/RAM):' -ForegroundColor White;" ^
    "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 -Property Name, @{N='CPU(s)';E={$_.CPU}}, @{N='RAM(MB)';E={[math]::Round($_.WorkingSet / 1MB, 2)}} | Format-Table -AutoSize"

:: Enhanced escape mechanism instead of standard timeout
echo.
choice /c rM /n /t 5 /d r /m "Press [R] to refresh now, or [M] to return to Main Menu... "
if errorlevel 2 goto menu
if errorlevel 1 goto op25_loop

:: --- OPTION 26: PARANOID SECURITY (EXTREME LOCKDOWN) ---
:op26
cls
echo ======================================================
echo                  PARANOID SECURITY
echo ======================================================
echo %cRed%[WARNING] This is an extreme lockdown profile.%cReset%
echo.
echo This option will perform the following actions:
echo 1. Disable Windows Script Host (Note: Breaks Option 24 background music).
echo 2. Disable PowerShell 2.0 (Blocks legacy exploit vectors).
echo 3. Force SEHOP (Structured Exception Handling Overwrite Protection).
echo 4. Disable LLMNR (Prevents local network credential sniffing).
echo 5. Kill SMBv1, v2, and v3 completely (Breaks all local file/printer sharing).
echo 6. Set UAC to maximum (Requires password for all admin tasks).
echo 7. Disable Remote Desktop (RDP) completely.
echo ======================================================
echo %cBlue%1. Proceed with Paranoid Security%cReset%
echo %cBlue%2. Go Back to Main Menu%cReset%
set /p parachoice="Select an option (1-2): "

if "%parachoice%"=="1" goto execute_paranoid
if "%parachoice%"=="2" goto menu
goto op26

:execute_paranoid
echo.
echo %cRed%[WORKING] Executing System Core Hardening...%cReset%

echo %cRed%[1/6] Disabling Windows Script Host (Blocks .vbs / .js malware)...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo %cRed%[2/6] Disabling PowerShell 2.0 (Legacy engine used by hackers)...%cReset%
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root" >nul 2>&1

echo %cRed%[3/6] Forcing Structured Exception Handling Overwrite Protection (SEHOP)...%cReset%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableExceptionChainValidation /t REG_DWORD /d 0 /f >nul 2>&1

echo %cRed%[4/6] Disabling LLMNR (Prevents credential sniffing/spoofing)...%cReset%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f >nul 2>&1

echo %cRed%[5/6] Disabling SMB v1, v2, and v3 (Stops unauthorized file sharing access)...%cReset%
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart" >nul 2>&1
sc config lanmanserver start= disabled >nul 2>&1
sc stop lanmanserver /y >nul 2>&1

echo %cRed%[6/6] Hardening UAC to maximum and Disabling RDP...%cReset%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo %cRed%======================================================%cReset%
echo %cRed%HARDENING COMPLETE.%cReset%
echo %cRed%Note: Local File Sharing (SMB) and VBScripts are now BLOCKED.%cReset%
echo %cRed%Please restart your computer for all changes to apply.%cReset%
echo %cRed%======================================================%cReset%
pause
goto menu

:: --- EXIT ROUTINE ---
:exit_routine
cls
echo %cBlue%Exiting Vitorius Master Tweaks. Goodbye.%cReset%
timeout /t 2 >nul
exit /b