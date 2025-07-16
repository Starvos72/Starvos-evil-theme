#!/bin/bash

THEME_NAME="starvos"
PANEL_PATH="/var/www/pterodactyl"
TMP_DIR="/tmp/${THEME_NAME}-theme"

echo "📥 Downloading Starvos Evil Full Theme..."
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

curl -sL https://raw.githubusercontent.com/Starvos72/starvos-evil-theme/main/starvos_evil_fulltheme.zip -o starvos.zip

echo "📦 Unzipping theme..."
unzip -o starvos.zip > /dev/null

echo "📁 Installing theme to Pterodactyl directory..."
rm -rf "$PANEL_PATH/resources/themes/$THEME_NAME"
mkdir -p "$PANEL_PATH/resources/themes/$THEME_NAME"
cp -r . "$PANEL_PATH/resources/themes/$THEME_NAME"

echo "📝 Updating .env to use theme..."
sed -i 's/^APP_THEME=.*/APP_THEME=starvos/' "$PANEL_PATH/.env"

echo "♻️ Clearing view cache..."
cd "$PANEL_PATH"
php artisan view:clear

echo "✅ Starvos Evil Theme has been installed!"
echo "💡 Visit your panel to see the bloody new look."
