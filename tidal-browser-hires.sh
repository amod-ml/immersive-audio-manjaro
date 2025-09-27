#!/bin/bash
# Browser-based TIDAL with Audio Optimizations
# Tries different browsers for best audio output

echo "🌐 TIDAL Browser High-Resolution Audio Test"
echo "==========================================="

# Set optimal audio environment
export PULSE_LATENCY_MSEC=30
export PIPEWIRE_LATENCY=512/48000

echo "🔧 Available browsers with audio optimizations:"
echo

# Test Firefox with audio optimizations
if command -v firefox >/dev/null 2>&1; then
    echo "1. Firefox with audio.rate optimizations"
    echo "   Launch: ./tidal-browser-hires.sh firefox"
fi

# Test Chromium/Chrome with audio flags
if command -v chromium >/dev/null 2>&1; then
    echo "2. Chromium with high-quality audio flags" 
    echo "   Launch: ./tidal-browser-hires.sh chromium"
fi

if command -v google-chrome-stable >/dev/null 2>&1; then
    echo "3. Chrome with high-quality audio flags"
    echo "   Launch: ./tidal-browser-hires.sh chrome"
fi

# Handle browser selection
case "${1:-help}" in
    firefox)
        echo "🦊 Launching Firefox with audio optimizations..."
        # Firefox with audio preferences
        firefox --new-instance \
                --profile ~/.mozilla/firefox/tidal-hires \
                --new-window "https://listen.tidal.com" \
                --app-id="tidal-hires"
        ;;
    chromium)
        echo "🌐 Launching Chromium with high-quality audio..."
        chromium --new-window \
                 --app="https://listen.tidal.com" \
                 --audio-buffer-size=512 \
                 --enable-features=WebRTC-H264WithOpenH264FFmpeg \
                 --force-high-performance-gpu \
                 --disable-background-timer-throttling \
                 --disable-renderer-backgrounding
        ;;
    chrome)
        echo "🎯 Launching Chrome with high-quality audio..."
        google-chrome-stable --new-window \
                            --app="https://listen.tidal.com" \
                            --audio-buffer-size=512 \
                            --enable-features=WebRTC-H264WithOpenH264FFmpeg \
                            --force-high-performance-gpu \
                            --disable-background-timer-throttling \
                            --disable-renderer-backgrounding
        ;;
    *)
        echo "📋 Usage: $0 [firefox|chromium|chrome]"
        echo
        echo "💡 Tips for better browser audio:"
        echo "  • Use Firefox with about:config audio.rate settings"
        echo "  • Use Chromium/Chrome with --audio-buffer-size=512"
        echo "  • Enable 'Exclusive Mode' in TIDAL web settings"
        echo "  • Monitor with pw-top to verify sample rates"
        ;;
esac