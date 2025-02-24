#!/bin/sh

echo "Windsurf installer"
echo "=================="

# This part makes a little cleanup by removing the previous installation
echo ""
echo "> Clean previous /tmp/windsurf directory"
rm -rf /tmp/windsurf

echo "> Clean previous /opt/windsurf directory"
rm -rf /opt/windsurf

echo "> Clean previous Windsurf desktop icon"
rm -rf /usr/share/applications/windsurf.desktop

# Get the latest version of the Windsurf IDE
echo ""
echo "> Figure out the latest version..."

url=$(curl -s 'https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest' | awk -F\" '/url/ { print $4 }')

echo ""
echo "> Downloading $url"
echo ">> into /tmp/windsurf/windsurf.tar.gz"
mkdir -p /tmp/windsurf
curl -L "$url" -o /tmp/windsurf/windsurf.tar.gz

echo ""
echo "> Extracting /tmp/windsurf/windsurf.tar.gz"
echo ">> into /tmp/windsurf/Windsurf"
tar -xf /tmp/windsurf/windsurf.tar.gz -C /tmp/windsurf

echo ""
echo "> Installing Windsurf"
echo ">> into /opt/windsurf"
mkdir -p /opt/windsurf
cp -rf /tmp/windsurf/Windsurf/* /opt/windsurf

rm -rf /tmp/windsurf

echo ""
echo "> Installing desktop icon"
echo "[Desktop Entry]
Name=Windsurf
StartupWMClass=windsurf
Comment=The first agentic IDE, and then some. The Windsurf Editor is where the work of developers and AI truly flow together, allowing for a coding experience that feels like literal magic.
GenericName=AI Editor
Exec=/opt/windsurf/bin/windsurf
Icon=/opt/windsurf/resources/app/resources/linux/code.png
Type=Application
Categories=Network;
Path=/usr/bin" > /usr/share/applications/windsurf.desktop

echo ""
echo "> Windsurf installed"
echo ">> Add it to the path with:"
echo "  export PATH=\$PATH:/opt/windsurf/bin"
