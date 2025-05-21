#!/bin/sh

set -xe

basedir="$(realpath "${0}")"
basedir="$(dirname "${basedir}")"

icon_ver="v1.1.5"
icon_file="oxylite-icon-theme-${icon_ver}.tar.gz"
icon_url="https://github.com/mx-2/oxylite-icon-theme/releases/download/${icon_ver}/${icon_file}"
icons_dir="${HOME}/.local/share/icons"
setup_icon() {
    mkdir -p "${icons_dir}"
    cd "${icons_dir}"

    if test ! -f "${icon_file}"; then
        curl -LO "${icon_url}"
    fi

    if test ! -d "oxylite"; then
        tar -xa -f "${icon_file}"
    fi

    gsettings set org.gnome.desktop.interface icon-theme oxylite
}

theme_rel_location=".local/share/themes/Skewaita"
themes_dir="${HOME}/.local/share/themes"
setup_gtk_theme() {
    cd "${basedir}"

    git submodule init
    git submodule update

    cd "${theme_rel_location}/source/templates"
    ./use_scheme.sh colorscheme-light-blue.sh
    cd ..
    ./compile.sh dark

    mkdir -p "${themes_dir}"
    if test ! -h "${themes_dir}/Skewaita"; then
        ln -s "${basedir}/${theme_rel_location}" "${themes_dir}/"
    fi

    gsettings set org.gnome.desktop.interface gtk-theme Skewaita
    # gsettings set org.gnome.desktop.interface color-scheme prefer-dark
}

setup_fonts() {
    gsettings set org.gnome.desktop.interface font-name "Source Sans 3 12"
    gsettings set org.gnome.desktop.interface monospace-font-name "Source Code Pro 12"
    gsettings set org.gnome.desktop.interface document-font-name "Source Seirf 4 12"
}

case "$1" in
    "all")
        setup_icon
        setup_gtk_theme
        setup_fonts
        ;;

    "icon")
        setup_icon
        ;;

    "theme")
        setup_gtk_theme
        ;;

    "font")
        setup_fonts
        ;;

    *)
        echo "Usage: $0 <icon/theme/font/all>"
        ;;
esac
