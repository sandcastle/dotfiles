export ZELLIJ_VERSION="0.42.2"
export ZELLIJ_ARCH="aarch64-apple-darwin"
export ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-${ZELLIJ_ARCH}.tar.gz"

rm -rf /tmp/zellij.tar.gz /tmp/zellij >/dev/null
curl -fsSL ${ZELLIJ_URL} -o /tmp/zellij.tar.gz >/dev/null
tar -xzf /tmp/zellij.tar.gz -C /tmp >/dev/null
sudo install -m 755 /tmp/zellij /usr/local/bin/zellij >/dev/null
rm -rf /tmp/zellij.tar.gz /tmp/zellij >/dev/null

mkdir -p ~/.config/zellij/themes
[ ! -f "$HOME/.config/zellij/config.kdl" ] && cp ~/.local/share/omakub/configs/zellij.kdl ~/.config/zellij/config.kdl
cp ~/.local/share/omakub/themes/tokyo-night/zellij.kdl ~/.config/zellij/themes/tokyo-night.kdl
