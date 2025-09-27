#!/bin/bash
# High-Resolution Audio Quick Launcher
# Perfect for taskbar integration

# Create a simple GUI menu using kdialog (KDE)
if command -v kdialog >/dev/null 2>&1; then
    choice=$(kdialog --title "HiRes Audio Tools" \
                    --menu "Choose an audio application:" \
                    1 "🌊 High Tide TIDAL (High-Res)" \
                    2 "⚙️ Configure Audio Settings" \
                    3 "🧪 Test Audio Quality" \
                    4 "📊 Monitor PipeWire" \
                    5 "🌐 Browser TIDAL Options")
    
    case $choice in
        1) /home/amod/Projects/iamf/launch-hightide-hires.sh ;;
        2) konsole -e /home/amod/Projects/iamf/enable-hires-audio.sh ;;
        3) konsole -e /home/amod/Projects/iamf/test-hires-audio.sh ;;
        4) konsole -e pw-top ;;
        5) /home/amod/Projects/iamf/tidal-browser-hires.sh ;;
    esac
elif command -v zenity >/dev/null 2>&1; then
    # Fallback to zenity for other desktop environments
    choice=$(zenity --list \
                   --title="HiRes Audio Tools" \
                   --text="Choose an audio application:" \
                   --column="Option" \
                   "High Tide TIDAL (High-Res)" \
                   "Configure Audio Settings" \
                   "Test Audio Quality" \
                   "Monitor PipeWire" \
                   "Browser TIDAL Options")
    
    case "$choice" in
        "High Tide TIDAL (High-Res)") /home/amod/Projects/iamf/launch-hightide-hires.sh ;;
        "Configure Audio Settings") konsole -e /home/amod/Projects/iamf/enable-hires-audio.sh ;;
        "Test Audio Quality") konsole -e /home/amod/Projects/iamf/test-hires-audio.sh ;;
        "Monitor PipeWire") konsole -e pw-top ;;
        "Browser TIDAL Options") /home/amod/Projects/iamf/tidal-browser-hires.sh ;;
    esac
else
    # Terminal fallback
    echo "🎵 HiRes Audio Tools"
    echo "=================="
    echo "1. High Tide TIDAL (High-Res)"
    echo "2. Configure Audio Settings"  
    echo "3. Test Audio Quality"
    echo "4. Monitor PipeWire"
    echo "5. Browser TIDAL Options"
    echo
    read -p "Choose (1-5): " choice
    
    case $choice in
        1) /home/amod/Projects/iamf/launch-hightide-hires.sh ;;
        2) /home/amod/Projects/iamf/enable-hires-audio.sh ;;
        3) /home/amod/Projects/iamf/test-hires-audio.sh ;;
        4) pw-top ;;
        5) /home/amod/Projects/iamf/tidal-browser-hires.sh ;;
    esac
fi