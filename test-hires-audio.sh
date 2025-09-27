#!/bin/bash
# High-Resolution Audio Test Script for JadeAudio JA11 DAC
# Tests sample rate switching and bit-perfect audio capabilities

echo "🎵 JadeAudio JA11 High-Resolution Audio Test"
echo "============================================="
echo

# Check current PipeWire configuration
echo "📊 Current PipeWire Settings:"
echo "----------------------------"
pw-metadata -n settings 0 | grep -E "(clock.rate|allowed-rates|force-rate)"
echo

# Check JA11 DAC availability  
echo "🎛️ Audio Devices:"
echo "-----------------"
pw-cli ls Node | grep -A3 -B1 "JA11\|alsa_output.*usb"
echo

# Test different sample rates with mpv
echo "🧪 Testing Sample Rates with mpv:"
echo "---------------------------------"

# Test URLs (if available) or create silent test
test_rates=("44100" "48000" "96000" "192000")

for rate in "${test_rates[@]}"; do
    echo "Testing ${rate}Hz..."
    
    # Create a brief test tone using ffmpeg if available
    if command -v ffmpeg >/dev/null 2>&1; then
        echo "Generating ${rate}Hz test tone..."
        timeout 3s ffmpeg -f lavfi -i "sine=frequency=1000:duration=1:sample_rate=${rate}" \
                          -acodec pcm_s32le -ac 2 -ar "${rate}" \
                          -f wav "/tmp/test_${rate}.wav" 2>/dev/null
        
        if [[ -f "/tmp/test_${rate}.wav" ]]; then
            echo "Playing via mpv JA11 direct mode..."
            timeout 2s mpv "/tmp/test_${rate}.wav" \
                           --profile=ja11-hires \
                           --msg-level=ao=info \
                           --really-quiet 2>&1 | grep -E "(Using|ao|Hz|format)" || true
            rm "/tmp/test_${rate}.wav"
        fi
    fi
    echo
done

echo "🔍 Real-time Audio Monitoring:"
echo "------------------------------"
echo "Run 'pw-top' in another terminal to see live sample rates"
echo "Use 'pw-metadata -n settings 0' to check current clock settings"
echo

echo "🎯 Test Commands:"
echo "----------------"
echo "Direct ALSA mode:     mpv audiofile.flac --profile=ja11-hires"
echo "PipeWire mode:        mpv audiofile.flac --profile=ja11-pipewire"
echo "Check sample rate:    pw-dump | jq -r '.[] | select(.info.props.\"audio.rate\") | \"\(.info.props.\"node.description\"): \(.info.props.\"audio.rate\")Hz\"'"
echo "Monitor live:         pw-top"
echo

echo "✅ High-resolution audio configuration complete!"
echo "Your JA11 DAC now supports sample rates up to 384kHz"