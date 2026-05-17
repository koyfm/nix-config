{
  flake = {
    modules.homeManager.noctalia =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          home.packages = with pkgs; [ qt6.qtwebsockets ];

          programs.noctalia-shell = {
            enable = true;

            plugins = {
              sources = [
                {
                  enabled = true;
                  name = "Official Noctalia Plugins";
                  url = "https://github.com/noctalia-dev/noctalia-plugins";
                }
              ];
              states = {
                hassio = {
                  enabled = true;
                  sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
                };
                privacy-indicator = {
                  enabled = true;
                  sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
                };
                video-wallpaper = {
                  enabled = true;
                  sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
                };
              };
              version = 2;
            };

            settings = {
              settingsVersion = 0;
              bar = {
                barType = "simple";
                position = "top";
                monitors = [ ];
                density = "default";
                showOutline = false;
                showCapsule = true;
                capsuleOpacity = 1;
                capsuleColorKey = "none";
                widgetSpacing = 6;
                contentPadding = 2;
                fontScale = 1;
                enableExclusionZoneInset = true;
                backgroundOpacity = 0.93;
                useSeparateOpacity = false;
                marginVertical = 4;
                marginHorizontal = 4;
                frameThickness = 8;
                frameRadius = 12;
                outerCorners = true;
                hideOnOverview = false;
                displayMode = "always_visible";
                autoHideDelay = 500;
                autoShowDelay = 150;
                showOnWorkspaceSwitch = true;
                widgets = {
                  left = [
                    {
                      id = "Launcher";
                    }
                    {
                      id = "Clock";
                    }
                    {
                      id = "SystemMonitor";
                    }
                    {
                      id = "plugin:privacy-indicator";
                    }
                    {
                      id = "ActiveWindow";
                    }
                    {
                      id = "MediaMini";
                    }
                  ];
                  center = [
                    {
                      id = "Workspace";
                    }
                  ];
                  right = [
                    {
                      id = "Tray";
                    }
                    {
                      id = "plugin:hassio";
                    }
                    {
                      id = "NotificationHistory";
                    }
                    {
                      id = "Battery";
                    }
                    {
                      id = "Volume";
                    }
                    {
                      id = "Brightness";
                    }
                    {
                      id = "ControlCenter";
                    }
                  ];
                };
                mouseWheelAction = "none";
                reverseScroll = false;
                mouseWheelWrap = true;
                middleClickAction = "none";
                middleClickFollowMouse = false;
                middleClickCommand = "";
                rightClickAction = "controlCenter";
                rightClickFollowMouse = true;
                rightClickCommand = "";
                screenOverrides = [ ];
              };
              general = {
                avatarImage = "";
                dimmerOpacity = 0.2;
                showScreenCorners = false;
                forceBlackScreenCorners = false;
                scaleRatio = 1;
                radiusRatio = 1;
                iRadiusRatio = 1;
                boxRadiusRatio = 1;
                screenRadiusRatio = 1;
                animationSpeed = 1;
                animationDisabled = false;
                compactLockScreen = false;
                lockScreenAnimations = false;
                lockOnSuspend = true;
                showSessionButtonsOnLockScreen = true;
                showHibernateOnLockScreen = false;
                enableLockScreenMediaControls = false;
                enableShadows = true;
                enableBlurBehind = true;
                shadowDirection = "bottom_right";
                shadowOffsetX = 2;
                shadowOffsetY = 3;
                language = "";
                allowPanelsOnScreenWithoutBar = true;
                showChangelogOnStartup = true;
                telemetryEnabled = false;
                enableLockScreenCountdown = true;
                lockScreenCountdownDuration = 10000;
                autoStartAuth = false;
                allowPasswordWithFprintd = false;
                clockStyle = "custom";
                clockFormat = "hh\\nmm";
                passwordChars = false;
                lockScreenMonitors = [ ];
                lockScreenBlur = 0;
                lockScreenTint = 0;
                keybinds = {
                  keyUp = [
                    "Up"
                  ];
                  keyDown = [
                    "Down"
                  ];
                  keyLeft = [
                    "Left"
                  ];
                  keyRight = [
                    "Right"
                  ];
                  keyEnter = [
                    "Return"
                    "Enter"
                  ];
                  keyEscape = [
                    "Esc"
                  ];
                  keyRemove = [
                    "Del"
                  ];
                };
                reverseScroll = false;
                smoothScrollEnabled = true;
              };
              ui = {
                fontDefault = "";
                fontFixed = "";
                fontDefaultScale = 1;
                fontFixedScale = 1;
                tooltipsEnabled = true;
                scrollbarAlwaysVisible = true;
                boxBorderEnabled = false;
                panelBackgroundOpacity = 0.93;
                translucentWidgets = false;
                panelsAttachedToBar = true;
                settingsPanelMode = "attached";
                settingsPanelSideBarCardStyle = false;
              };
              location = {
                name = "";
                weatherEnabled = true;
                weatherShowEffects = true;
                weatherTaliaMascotAlways = false;
                useFahrenheit = false;
                use12hourFormat = false;
                showWeekNumberInCalendar = false;
                showCalendarEvents = true;
                showCalendarWeather = true;
                analogClockInCalendar = false;
                firstDayOfWeek = -1;
                hideWeatherTimezone = false;
                hideWeatherCityName = false;
                autoLocate = true;
              };
              calendar = {
                cards = [
                  {
                    enabled = true;
                    id = "calendar-header-card";
                  }
                  {
                    enabled = true;
                    id = "calendar-month-card";
                  }
                  {
                    enabled = true;
                    id = "weather-card";
                  }
                ];
              };
              wallpaper = {
                enabled = true;
                overviewEnabled = false;
                directory = "";
                monitorDirectories = [ ];
                enableMultiMonitorDirectories = false;
                showHiddenFiles = false;
                viewMode = "single";
                setWallpaperOnAllMonitors = true;
                linkLightAndDarkWallpapers = true;
                fillMode = "crop";
                fillColor = "#000000";
                useSolidColor = false;
                solidColor = "#1a1a2e";
                automationEnabled = false;
                wallpaperChangeMode = "random";
                randomIntervalSec = 300;
                transitionDuration = 1500;
                transitionType = [
                  "fade"
                  "disc"
                  "stripes"
                  "wipe"
                  "pixelate"
                  "honeycomb"
                ];
                skipStartupTransition = false;
                transitionEdgeSmoothness = 0.05;
                panelPosition = "follow_bar";
                hideWallpaperFilenames = false;
                useOriginalImages = false;
                overviewBlur = 0.4;
                overviewTint = 0.6;
                useWallhaven = false;
                wallhavenQuery = "";
                wallhavenSorting = "relevance";
                wallhavenOrder = "desc";
                wallhavenCategories = "111";
                wallhavenPurity = "100";
                wallhavenRatios = "";
                wallhavenApiKey = "";
                wallhavenResolutionMode = "atleast";
                wallhavenResolutionWidth = "";
                wallhavenResolutionHeight = "";
                sortOrder = "name";
                favorites = [ ];
              };
              appLauncher =
                let
                  wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";
                in
                {
                  enableClipboardHistory = false;
                  autoPasteClipboard = false;
                  enableClipPreview = true;
                  clipboardWrapText = true;
                  enableClipboardSmartIcons = true;
                  enableClipboardChips = true;
                  clipboardWatchTextCommand = "${wl-paste} --type text --watch cliphist store";
                  clipboardWatchImageCommand = "${wl-paste} --type image --watch cliphist store";
                  position = "center";
                  pinnedApps = [ ];
                  sortByMostUsed = true;
                  terminalCommand = "${lib.getExe config.programs.ghostty.package} -e";
                  customLaunchPrefixEnabled = false;
                  customLaunchPrefix = "";
                  viewMode = "list";
                  showCategories = true;
                  iconMode = "tabler";
                  showIconBackground = false;
                  enableSettingsSearch = true;
                  enableWindowsSearch = true;
                  enableSessionSearch = true;
                  ignoreMouseInput = false;
                  screenshotAnnotationTool = "";
                  overviewLayer = false;
                  density = "default";
                };
              controlCenter = {
                position = "close_to_bar_button";
                diskPath = "/";
                shortcuts = {
                  left = [
                    {
                      id = "Network";
                    }
                    {
                      id = "Bluetooth";
                    }
                    {
                      id = "WallpaperSelector";
                    }
                    {
                      id = "NoctaliaPerformance";
                    }
                  ];
                  right = [
                    {
                      id = "Notifications";
                    }
                    {
                      id = "PowerProfile";
                    }
                    {
                      id = "KeepAwake";
                    }
                    {
                      id = "NightLight";
                    }
                  ];
                };
                cards = [
                  {
                    enabled = true;
                    id = "profile-card";
                  }
                  {
                    enabled = true;
                    id = "shortcuts-card";
                  }
                  {
                    enabled = true;
                    id = "audio-card";
                  }
                  {
                    enabled = false;
                    id = "brightness-card";
                  }
                  {
                    enabled = true;
                    id = "weather-card";
                  }
                  {
                    enabled = true;
                    id = "media-sysmon-card";
                  }
                ];
              };
              systemMonitor = {
                cpuWarningThreshold = 80;
                cpuCriticalThreshold = 90;
                tempWarningThreshold = 80;
                tempCriticalThreshold = 90;
                gpuWarningThreshold = 80;
                gpuCriticalThreshold = 90;
                memWarningThreshold = 80;
                memCriticalThreshold = 90;
                swapWarningThreshold = 80;
                swapCriticalThreshold = 90;
                diskWarningThreshold = 80;
                diskCriticalThreshold = 90;
                diskAvailWarningThreshold = 20;
                diskAvailCriticalThreshold = 10;
                batteryWarningThreshold = 20;
                batteryCriticalThreshold = 5;
                enableDgpuMonitoring = false;
                useCustomColors = false;
                warningColor = "";
                criticalColor = "";
                externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
              };
              noctaliaPerformance = {
                disableWallpaper = true;
                disableDesktopWidgets = true;
              };
              dock = {
                enabled = true;
                position = "bottom";
                displayMode = "auto_hide";
                dockType = "floating";
                backgroundOpacity = 1;
                floatingRatio = 1;
                size = 1;
                onlySameOutput = true;
                monitors = [ ];
                pinnedApps = [ ];
                colorizeIcons = false;
                showLauncherIcon = false;
                launcherPosition = "end";
                launcherUseDistroLogo = false;
                launcherIcon = "";
                launcherIconColor = "none";
                pinnedStatic = false;
                inactiveIndicators = false;
                groupApps = false;
                groupContextMenuMode = "extended";
                groupClickAction = "cycle";
                groupIndicatorStyle = "dots";
                deadOpacity = 0.6;
                animationSpeed = 1;
                sitOnFrame = false;
                showDockIndicator = false;
                indicatorThickness = 3;
                indicatorColor = "primary";
                indicatorOpacity = 0.6;
              };
              network = {
                bluetoothRssiPollingEnabled = false;
                bluetoothRssiPollIntervalMs = 60000;
                networkPanelView = "wifi";
                wifiDetailsViewMode = "grid";
                bluetoothDetailsViewMode = "grid";
                bluetoothHideUnnamedDevices = false;
                disableDiscoverability = false;
                bluetoothAutoConnect = true;
              };
              sessionMenu = {
                enableCountdown = true;
                countdownDuration = 10000;
                position = "center";
                showHeader = true;
                showKeybinds = true;
                largeButtonsStyle = true;
                largeButtonsLayout = "single-row";
                powerOptions = [
                  {
                    action = "lock";
                    enabled = true;
                    keybind = "1";
                  }
                  {
                    action = "suspend";
                    enabled = true;
                    keybind = "2";
                  }
                  {
                    action = "hibernate";
                    enabled = true;
                    keybind = "3";
                  }
                  {
                    action = "reboot";
                    enabled = true;
                    keybind = "4";
                  }
                  {
                    action = "logout";
                    enabled = true;
                    keybind = "5";
                  }
                  {
                    action = "shutdown";
                    enabled = true;
                    keybind = "6";
                  }
                  {
                    action = "rebootToUefi";
                    enabled = true;
                    keybind = "7";
                  }
                ];
              };
              notifications = {
                enabled = true;
                enableMarkdown = false;
                density = "default";
                monitors = [ ];
                location = "top_right";
                overlayLayer = true;
                backgroundOpacity = 1;
                respectExpireTimeout = false;
                lowUrgencyDuration = 3;
                normalUrgencyDuration = 8;
                criticalUrgencyDuration = 15;
                clearDismissed = true;
                saveToHistory = {
                  low = true;
                  normal = true;
                  critical = true;
                };
                sounds = {
                  enabled = false;
                  volume = 0.5;
                  separateSounds = false;
                  criticalSoundFile = "";
                  normalSoundFile = "";
                  lowSoundFile = "";
                  excludedApps = "discord,firefox,chrome,chromium,edge";
                };
                enableMediaToast = false;
                enableKeyboardLayoutToast = true;
                enableBatteryToast = true;
              };
              osd = {
                enabled = true;
                location = "top_right";
                autoHideMs = 2000;
                overlayLayer = true;
                backgroundOpacity = 1;
                enabledTypes = [
                  0
                  1
                  2
                ];
                monitors = [ ];
              };
              audio = {
                volumeStep = 5;
                volumeOverdrive = false;
                spectrumFrameRate = 30;
                visualizerType = "linear";
                spectrumMirrored = true;
                mprisBlacklist = [ ];
                preferredPlayer = "";
                volumeFeedback = false;
                volumeFeedbackSoundFile = "";
              };
              brightness = {
                brightnessStep = 5;
                enforceMinimum = true;
                enableDdcSupport = false;
                backlightDeviceMappings = [ ];
              };
              colorSchemes = {
                useWallpaperColors = false;
                predefinedScheme = "Noctalia (default)";
                darkMode = true;
                schedulingMode = "off";
                manualSunrise = "06:30";
                manualSunset = "18:30";
                generationMethod = "tonal-spot";
                monitorForColors = "";
                syncGsettings = true;
              };
              templates = {
                activeTemplates = [ ];
                enableUserTheming = false;
              };
              nightLight = {
                enabled = false;
                forced = false;
                autoSchedule = true;
                nightTemp = "4000";
                dayTemp = "6500";
                manualSunrise = "06:30";
                manualSunset = "18:30";
              };
              hooks = {
                enabled = false;
                wallpaperChange = "";
                darkModeChange = "";
                screenLock = "";
                screenUnlock = "";
                performanceModeEnabled = "";
                performanceModeDisabled = "";
                startup = "";
                session = "";
                colorGeneration = "";
              };
              plugins = {
                autoUpdate = false;
                notifyUpdates = true;
              };
              idle = {
                enabled = false;
                screenOffTimeout = 600;
                lockTimeout = 660;
                suspendTimeout = 1800;
                fadeDuration = 5;
                screenOffCommand = "";
                lockCommand = "";
                suspendCommand = "";
                resumeScreenOffCommand = "";
                resumeLockCommand = "";
                resumeSuspendCommand = "";
                customCommands = "[]";
              };
              desktopWidgets = {
                enabled = false;
                overviewEnabled = true;
                gridSnap = false;
                gridSnapScale = false;
                monitorWidgets = [ ];
              };
            };
          };

          programs.niri.settings = {
            spawn-at-startup = [
              { command = [ "noctalia-shell" ]; }
            ];
            binds =
              let
                noctalia-shell = lib.getExe config.programs.noctalia-shell.package;
                ipc = cmd: {
                  action.spawn = [
                    noctalia-shell
                    "ipc"
                    "call"
                  ]
                  ++ lib.splitString " " cmd;
                  hotkey-overlay.hidden = true;
                };
              in
              {
                "Mod+Space" = ipc "launcher toggle";
                "Mod+S" = ipc "controlCenter toggle";
                "Mod+Comma" = ipc "settings toggle";

                "Super+Alt+L" = ipc "lockScreen lock";

                "XF86AudioRaiseVolume" = ipc "volume increase";
                "XF86AudioLowerVolume" = ipc "volume decrease";
                "XF86AudioMute" = ipc "volume muteOutput";
                "XF86AudioMicMute" = ipc "volume muteInput";

                "XF86AudioPlay" = ipc "media playPause";
                "XF86AudioStop" = ipc "media pause";
                "XF86AudioPrev" = ipc "media previous";
                "XF86AudioNext" = ipc "media next";

                "XF86MonBrightnessUp" = ipc "brightness increase";
                "XF86MonBrightnessDown" = ipc "brightness decrease";
              };
          };
        };
      };
  };
}
