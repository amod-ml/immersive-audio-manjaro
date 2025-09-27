#!/bin/bash
# Icon Test Utility for TIDAL High-Resolution Audio Tools

echo "🎨 TIDAL Icon Test Utility"
echo "========================="
echo

echo "📁 Checking icon installation..."
for icon in tidal tidal-hifi tidal-hires high-tide; do
    if [[ -f ~/.local/share/icons/hicolor/scalable/apps/${icon}.svg ]]; then
        echo "✅ ${icon}.svg - Installed"
    else
        echo "❌ ${icon}.svg - Missing"
    fi
done

echo
echo "🔍 Desktop entries using TIDAL icons:"
grep -l "Icon=tidal" ~/.local/share/applications/*.desktop 2>/dev/null | while read file; do
    app_name=$(grep "^Name=" "$file" | cut -d'=' -f2)
    icon_name=$(grep "^Icon=" "$file" | cut -d'=' -f2)
    echo "  📱 $app_name → $icon_name"
done

echo
echo "🖼️ Testing icon display (if available):"
if command -v gio >/dev/null 2>&1; then
    echo "Using gio to check icon theme integration..."
    for icon in tidal tidal-hires; do
        if gio info --attributes=standard::icon ~/.local/share/icons/hicolor/scalable/apps/${icon}.svg >/dev/null 2>&1; then
            echo "✅ Icon theme recognizes: $icon"
        else
            echo "⚠️  Icon theme integration: $icon (may need cache refresh)"
        fi
    done
fi

echo
echo "🔄 To refresh icon cache manually:"
echo "  gtk-update-icon-cache ~/.local/share/icons/hicolor/"
echo "  update-desktop-database ~/.local/share/applications"
echo
echo "🎯 Icons should appear in:"
echo "  • Application Menu → AudioVideo"
echo "  • KDE System Settings → Applications"  
echo "  • Taskbar when pinned"