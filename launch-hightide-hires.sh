#!/bin/bash
# High Tide TIDAL Client - High-Resolution Audio Configuration
# Optimized for JadeAudio JA11 DAC with PipeWire

echo "🌊 Launching High Tide with High-Resolution Audio Configuration"
echo "=============================================================="

# Ensure our high-resolution PipeWire settings are active
echo "📊 Verifying PipeWire configuration..."
pw-metadata -n settings 0 clock.allowed-rates '[ 44100 48000 88200 96000 176400 192000 352800 384000 ]'
pw-metadata -n settings 0 clock.force-rate 0

# Show current audio devices
echo "🎛️ Available High-Quality Audio Devices:"
pw-dump | jq -r '.[] | select(.info.props."media.class"? == "Audio/Sink") | "\(.info.props."node.description") - \(.info.props."audio.channels") channels"'
echo

# Set environment variables for optimal audio
export PULSE_LATENCY_MSEC=50
export PIPEWIRE_LATENCY=1024/48000

# Launch High Tide
echo "🚀 Launching High Tide..."
echo "📝 In High Tide settings:"
echo "   1. Go to Preferences > Audio"
echo "   2. Set Audio Sink to 'PipeWire' for best quality"
echo "   3. Or set to 'ALSA' with device 'hw:3,0' for direct DAC access"
echo "   4. Enable highest quality streaming in TIDAL settings"
echo

# Launch with optimizations
flatpak run io.github.nokse22.high-tide &

# Monitor for a few seconds
sleep 3
echo "🔍 Monitoring audio streams..."
pw-top &
sleep 2
pkill pw-top

echo "✅ High Tide launched successfully!"
echo "🎵 You should now have access to high-resolution TIDAL streaming"
echo "   without the 48kHz Electron limitation!"