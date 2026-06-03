#!/bin/bash
#
# Build arti-bitchat for iOS/macOS with aggressive size optimization
#
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CRATE_NAME="arti-bitchat"
LIB_NAME="libarti_bitchat.a"
FRAMEWORK_NAME="arti"
OUTPUT_DIR="$SCRIPT_DIR/Frameworks"

TARGETS=(
    "aarch64-apple-ios"           # iOS device
    "aarch64-apple-ios-sim"       # iOS simulator (Apple Silicon)
    "x86_64-apple-ios"            # iOS simulator (Intel / VMware)
    "aarch64-apple-darwin"        # macOS
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_prerequisites() {
    log_info "Checking prerequisites..."
    if ! command -v rustc &> /dev/null || ! command -v cargo &> /dev/null; then
        log_error "Rust/Cargo is missing."
        exit 1
    fi
    for target in "${TARGETS[@]}"; do
        if ! rustup target list --installed | grep -q "$target"; then
            log_info "Installing target: $target"
            rustup target add "$target"
        fi
    done
    if ! command -v cbindgen &> /dev/null; then
        log_info "Installing cbindgen..."
        cargo install cbindgen
    fi
}

setup_rustflags() {
    local target="$1"
    export RUSTFLAGS="-C opt-level=z -C lto=fat -C codegen-units=1 -C panic=abort -C strip=symbols"
    case "$target" in
        *-apple-ios-sim*|x86_64-apple-ios) export IPHONEOS_DEPLOYMENT_TARGET="16.0" ;;
        *-apple-ios*) export IPHONEOS_DEPLOYMENT_TARGET="16.0" ;;
        *-apple-darwin*) export MACOSX_DEPLOYMENT_TARGET="13.0" ;;
    esac
}

build_target() {
    local target="$1"
    log_info "Building for target: $target"
    setup_rustflags "$target"
    cargo build --release --target "$target" -p "$CRATE_NAME"
}

create_xcframework() {
    log_info "Starting Lipo combination layer..."
    local xcframework_path="$OUTPUT_DIR/$FRAMEWORK_NAME.xcframework"
    rm -rf "$xcframework_path"
    mkdir -p "$OUTPUT_DIR"

    local sim_arm64="$SCRIPT_DIR/target/aarch64-apple-ios-sim/release/$LIB_NAME"
    local sim_x86_64="$SCRIPT_DIR/target/x86_64-apple-ios/release/$LIB_NAME"
    local final_sim_path=""

    # Weld the simulator slices into a single file to bypass Apple's strict duplicate framework block
    if [[ -f "$sim_arm64" && -f "$sim_x86_64" ]]; then
        log_info "Combining simulator targets (arm64 + x86_64) into universal slice..."
        mkdir -p "$SCRIPT_DIR/target/universal-ios-sim/release"
        lipo -create "$sim_arm64" "$sim_x86_64" -output "$SCRIPT_DIR/target/universal-ios-sim/release/$LIB_NAME"
        final_sim_path="$SCRIPT_DIR/target/universal-ios-sim/release/$LIB_NAME"
    elif [[ -f "$sim_arm64" ]]; then
        final_sim_path="$sim_arm64"
    else
        final_sim_path="$sim_x86_64"
    fi

    local cmd="xcodebuild -create-xcframework"

    # 1. Device Slice
    local device_lib="$SCRIPT_DIR/target/aarch64-apple-ios/release/$LIB_NAME"
    if [[ -f "$device_lib" ]]; then
        strip -x "$device_lib" 2>/dev/null || true
        cmd="$cmd -library $device_lib -headers $OUTPUT_DIR/include"
    fi

    # 2. Combined Simulator Slice
    if [[ -f "$final_sim_path" ]]; then
        strip -x "$final_sim_path" 2>/dev/null || true
        cmd="$cmd -library $final_sim_path -headers $OUTPUT_DIR/include"
    fi

    # 3. macOS Slice
    local mac_lib="$SCRIPT_DIR/target/aarch64-apple-darwin/release/$LIB_NAME"
    if [[ -f "$mac_lib" ]]; then
        strip -x "$mac_lib" 2>/dev/null || true
        cmd="$cmd -library $mac_lib -headers $OUTPUT_DIR/include"
    fi

    cmd="$cmd -output $xcframework_path"
    log_info "Running final package aggregation command..."
    eval "$cmd"
    log_info "Framework compiled perfectly!"
}

generate_header() {
    log_info "Generating headers..."
    local header_dir="$OUTPUT_DIR/include"
    mkdir -p "$header_dir"
    cat > "$header_dir/arti.h" << 'EOF'
#ifndef ARTI_H
#define ARTI_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
int32_t arti_start(const char *data_dir, uint16_t socks_port);
int32_t arti_stop(void);
int32_t arti_is_running(void);
int32_t arti_bootstrap_progress(void);
int32_t arti_bootstrap_summary(char *buf, int32_t len);
int32_t arti_go_dormant(void);
int32_t arti_wake(void);
#ifdef __cplusplus
}
#endif
#endif
EOF
}

main() {
    check_prerequisites
    generate_header
    for target in "${TARGETS[@]}"; do
        build_target "$target"
    done
    create_xcframework
}

main "$@"
