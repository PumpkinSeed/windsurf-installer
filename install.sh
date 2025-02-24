#!/bin/sh

echo "Windsurf installer"
echo "=================="

# This part makes a little cleanup by removing the previous installation
echo ""
echo "> Clean previous /tmp/windsurf directory"
rm -rf /tmp/windsurf

echo "> Clean previous $HOME/windsurf directory"
rm -rf "$HOME/windsurf"

echo "> Clean previous Windsurf desktop icon"
rm -rf "$HOME/.local/share/applications/windsurf.desktop"

# Get the latest version of the Windsurf IDE
echo ""
echo "> Figure out the latest version..."

url=$(curl -s 'https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest' | awk -F\" '/url/ { print $4 }')

# Download the latest version of the Windsurf IDE into /tmp
echo ""
echo "> Downloading $url"
echo ">> into /tmp/windsurf/windsurf.tar.gz"
mkdir -p /tmp/windsurf
curl -L "$url" -o /tmp/windsurf/windsurf.tar.gz

# Extract the Windsurf IDE
echo ""
echo "> Extracting /tmp/windsurf/windsurf.tar.gz"
echo ">> into /tmp/windsurf/Windsurf"
tar -xf /tmp/windsurf/windsurf.tar.gz -C /tmp/windsurf

# Copy the resources into the home directory
echo ""
echo "> Installing Windsurf"
echo ">> into $HOME/windsurf"
mkdir -p "$HOME/windsurf"
cp -rf /tmp/windsurf/Windsurf/* "$HOME/windsurf"

# Remove the /tmp created for installation
rm -rf /tmp/windsurf

# Create desktop icon
echo ""
echo "> Installing desktop icon"
echo "[Desktop Entry]
Name=Windsurf
StartupWMClass=windsurf
Comment=The first agentic IDE, and then some. The Windsurf Editor is where the work of developers and AI truly flow together, allowing for a coding experience that feels like literal magic.
GenericName=AI Editor
Exec=$HOME/windsurf/bin/windsurf
Icon=$HOME/windsurf/resources/app/resources/linux/code.png
Type=Application
Categories=Network;
Path=/usr/bin" > "$HOME/.local/share/applications/windsurf.desktop"

chmod 644 "$HOME/.local/share/applications/windsurf.desktop"

# Finalize the installation
echo ""
echo "> Windsurf installed"
echo ">> Add it to the path with:"
echo "  export PATH=\$PATH:$HOME/windsurf/bin"
