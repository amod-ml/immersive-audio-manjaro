#!/bin/bash
# Persistent High-Resolution Audio Configuration
# Enables sample rate switching for JadeAudio JA11 DAC

echo "🎵 Enabling High-Resolution Audio for JadeAudio JA11"
echo "======================================================"

# Make settings persistent by adding to user's config
mkdir -p ~/.config/pipewire

# Create a minimal pipewire configuration override
cat > ~/.config/pipewire/pipewire.conf.d/99-hires-audio.conf << 'EOF'
# High-Resolution Audio Configuration
# Enable sample rate switching for audiophile DACs

context.properties = {
    default.clock.allowed-rates = [ 44100 48000 88200 96000 176400 192000 352800 384000 ]
    default.clock.force-rate = 0
    default.clock.force-quantum = 0
    resample.quality = 10
    resample.disable = false
}
EOF

# Apply settings immediately
echo "⚙️ Applying PipeWire settings..."
pw-metadata -n settings 0 clock.allowed-rates '[ 44100 48000 88200 96000 176400 192000 352800 384000 ]'
pw-metadata -n settings 0 clock.force-rate 0

echo "✅ Configuration applied successfully!"
echo
echo "📊 Current Settings:"
pw-metadata -n settings 0 | grep -E "(clock.rate|allowed-rates|force-rate)"
echo
echo "🎯 Test your high-resolution audio:"
echo "  mpv your-hires-audio.flac --profile=ja11-hires"
echo "  mpv your-hires-audio.flac --profile=ja11-pipewire"
echo
echo "📈 Monitor sample rates in real-time:"
echo "  pw-top"
echo
echo "🔄 Changes will persist after reboot!"