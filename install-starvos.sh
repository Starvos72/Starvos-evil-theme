#!/bin/bash

THEME_NAME="starvos"
CONTAINER="pterodactyl_panel"
TMP_DIR="/tmp/$THEME_NAME-theme"

echo "📥 Downloading Starvos Blood Theme..."
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR" && cd "$TMP_DIR"

curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/starvos-blood-theme-installer/main/starvos_blood_theme.zip -o starvos.zip
unzip -o starvos.zip

echo "🐳 Copying theme into Docker container..."
docker cp . "$CONTAINER:/app/resources/themes/$THEME_NAME"

echo "📝 Creating theme.json inside container..."
docker exec "$CONTAINER" bash -c "cat > /app/resources/themes/$THEME_NAME/theme.json" <<'EOF'
{
  "name": "Starvos Blood Theme",
  "description": "Dark theme with blood drops",
  "inject": {
    "css": ["css/style.css"],
    "js": ["js/script.js"]
  }
}
EOF

echo "⚙️ Updating APP_THEME in .env..."
docker exec "$CONTAINER" sed -i 's/^APP_THEME=.*/APP_THEME=starvos/' /app/.env

echo "♻️ Clearing view cache..."
docker exec "$CONTAINER" php /app/artisan view:clear

echo "🔁 Restarting container..."
docker restart "$CONTAINER"

echo "✅ Starvos Blood Theme installed!"
