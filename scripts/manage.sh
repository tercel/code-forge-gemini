#!/bin/bash

# Configuration
SKILLS_DIR="skills"
COMMANDS_DIR="commands"
DIST_DIR="dist"

# Auto-detect package_skill.cjs path
PACKAGER_PATH=$(npm list -g @google/gemini-cli --parseable 2>/dev/null | head -n 1)/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs
if [ ! -f "$PACKAGER_PATH" ]; then
    PACKAGER_PATH="/Users/tercel/.nvm/versions/node/v22.22.0/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
fi

function package_all() {
    echo "📦 Packaging all skills..."
    rm -rf "$DIST_DIR"
    mkdir -p "$DIST_DIR"
    
    for dir in "$SKILLS_DIR"/*/; do
        if [ -f "${dir}SKILL.md" ]; then
            skill_name=$(basename "$dir")
            echo "   -> Packaging: $skill_name"
            node "$PACKAGER_PATH" "$dir" "$DIST_DIR"
        fi
    done
    echo "✅ Packaging complete. Output directory: $DIST_DIR"
}

function install_all() {
    scope=${1:-user}
    echo "🚀 Installing all skills (Scope: $scope)..."
    
    if [ ! -d "$DIST_DIR" ] || [ -z "$(ls -A $DIST_DIR/*.skill 2>/dev/null)" ]; then
        echo "❌ Error: No .skill files found. Please run 'package' first."
        exit 1
    fi

    # Install .skill files
    for skill in "$DIST_DIR"/*.skill; do
        echo "   -> Installing skill: $(basename "$skill")"
        gemini skills install "$skill" --scope "$scope" --consent
    done

    # Sync custom commands (.toml)
    if [ "$scope" == "user" ]; then
        CMD_TARGET="$HOME/.gemini/commands/code-forge"
    else
        CMD_TARGET="./.gemini/commands/code-forge"
    fi

    echo "🚀 Syncing custom commands to $CMD_TARGET..."
    mkdir -p "$CMD_TARGET"
    cp "$COMMANDS_DIR"/*.toml "$CMD_TARGET/"
    
    echo "✨ Installation complete!"
    echo "🔔 Please run '/skills reload' and '/commands reload' in your Gemini CLI session."
}

function uninstall_all() {
    scope=${1:-user}
    echo "🗑️ Uninstalling all skills (Scope: $scope)..."
    
    # Uninstall skills
    for dir in "$SKILLS_DIR"/*/; do
        if [ -f "${dir}SKILL.md" ]; then
            skill_name=$(basename "$dir")
            echo "   -> Uninstalling skill: $skill_name"
            gemini skills uninstall "$skill_name" --scope "$scope"
        fi
    done

    # Remove custom commands
    if [ "$scope" == "user" ]; then
        CMD_TARGET="$HOME/.gemini/commands/code-forge"
    else
        CMD_TARGET="./.gemini/commands/code-forge"
    fi

    echo "🗑️ Removing custom commands from $CMD_TARGET..."
    rm -rf "$CMD_TARGET"
    
    echo "✅ Uninstallation complete!"
    echo "🔔 Please run '/skills reload' and '/commands reload' in your Gemini CLI session."
}

case "$1" in
    package)
        package_all
        ;;
    install)
        install_all "$2"
        ;;
    uninstall)
        uninstall_all "$2"
        ;;
    all)
        package_all
        install_all "$2"
        ;;
    *)
        echo "Usage: $0 {package | install [user|workspace] | uninstall [user|workspace] | all [user|workspace]}"
        exit 1
        ;;
esac
