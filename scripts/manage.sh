#!/bin/bash

# Configuration
SKILLS_DIR="skills"
COMMANDS_DIR="commands"
DIST_DIR="dist"

# Auto-detect package_skill.cjs path
function find_packager() {
    # 1. Try to find relative to gemini executable
    local gemini_bin=$(command -v gemini)
    if [ -n "$gemini_bin" ]; then
        local real_bin=$(readlink -f "$gemini_bin" 2>/dev/null || realpath "$gemini_bin" 2>/dev/null || echo "$gemini_bin")
        local current_dir="$real_bin"
        
        # Climb up 5 levels to look for node_modules/@google/gemini-cli-core
        for i in {1..5}; do
            current_dir=$(dirname "$current_dir")
            local target="$current_dir/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
            if [ -f "$target" ]; then
                echo "$target"
                return
            fi
        done
    fi

    # 2. Try npm list -g
    local npm_path=$(npm list -g @google/gemini-cli --parseable 2>/dev/null | head -n 1)
    if [ -n "$npm_path" ]; then
        local target="$npm_path/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
        if [ -f "$target" ]; then
            echo "$target"
            return
        fi
    fi

    # 3. Last resort fallback to common locations
    local fallbacks=(
        "/usr/local/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
        "/opt/homebrew/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
        "/opt/homebrew/Cellar/gemini-cli/0.31.0/libexec/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/skills/builtin/skill-creator/scripts/package_skill.cjs"
    )
    for fb in "${fallbacks[@]}"; do
        if [ -f "$fb" ]; then
            echo "$fb"
            return
        fi
    done
}

PACKAGER_PATH=$(find_packager)

if [ -z "$PACKAGER_PATH" ] || [ ! -f "$PACKAGER_PATH" ]; then
    echo "❌ Error: Could not find 'package_skill.cjs'. Please ensure @google/gemini-cli is installed."
    exit 1
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
