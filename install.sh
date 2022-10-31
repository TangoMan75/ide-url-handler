#!/bin/sh
set -e

#/**
# * IDE URL Handler Installer
# *
# * This script installs / uninstalls URL handler for nano, PHPStorm, Sublime Text, vim and VSCode
# *
# * @license GPL
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 1.0.0
# * @link    https://github.com/TangoMan75/ide-url-handler
# */

## Install URL handlers automatically
install() {
    for ide in \
        atom \
        code \
        nano \
        phpstorm \
        pycharm-community \
        pycharm \
        subl \
        vim \
        webstorm \
    ;
    do
        if [ "$(command -v ${ide})" ]; then
            if [ "${ide}" = pycharm-community ]; then
                install_pycharm_community
            else
                install_${ide}
            fi
        fi
    done;
}

## Uninstall URL handlers
uninstall() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    for ide in \
        atom \
        code \
        nano \
        phpstorm \
        pycharm-community \
        pycharm \
        subl \
        vim \
        webstorm \
    ;
    do
        echo_info "rm -f /usr/bin/${ide}-url-handler\n"
        rm -f /usr/bin/${ide}-url-handler

        echo_info "rm -f /usr/share/applications/${ide}-url-handler.desktop\n"
        rm -f /usr/share/applications/${ide}-url-handler.desktop
    done

    echo_info 'update-desktop-database\n'
    update-desktop-database
}

## Install Atom URL handler
install_atom() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Atom'
    icon='/snap/atom/282/usr/share/pixmaps/atom.png'
    executable='atom'
    # shellcheck disable=SC2016
    command='"${file}:${line}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install Visual Studio Code URL handler
install_code() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Visual Studio Code'
    icon='/snap/code/current/meta/gui/com.visualstudio.code.png'
    executable='code'
    # shellcheck disable=SC2016
    command='--goto "${file}:${line}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install Emacs URL handler
install_emacs() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Emacs'
    icon=''
    executable='emacs'
    # shellcheck disable=SC2016
    command='+${line} ${file}'
    terminal='true'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install Nano URL handler
install_nano() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Nano'
    icon=''
    executable='nano'
    # shellcheck disable=SC2016
    command='+${line} ${file}'
    terminal='true'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install PHPStorm URL handler
install_phpstorm() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='PHPStorm'
    icon='/snap/phpstorm/current/bin/phpstorm.png'
    executable='phpstorm'
    # shellcheck disable=SC2016
    command='--line "${line}" "${file}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install PyCharm URL handler
install_pycharm() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='PyCharm'
    icon='/snap/pycharm-community/current/bin/pycharm.png'
    executable='pycharm'
    # shellcheck disable=SC2016
    command='--line "${line}" "${file}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install PyCharm Community URL handler
install_pycharm_community() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='PyCharm Community'
    icon='/snap/pycharm-community/current/bin/pycharm.png'
    executable='pycharm-community'
    # shellcheck disable=SC2016
    command='--line "${line}" "${file}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install Sublime Text URL handler
install_subl() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Sublime Text'
    icon='sublime-text'
    executable='subl'
    # shellcheck disable=SC2016
    command='"${file}:${line}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install Vim URL handler
install_vim() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='Vim'
    icon='gvim'
    executable='vim'
    # shellcheck disable=SC2016
    command='+${line} ${file}'
    terminal='true'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

## Install WebStorm URL handler
install_webstorm() {
    if [ "$(_is_root)" = false ]; then
        echo_error "\"${USER}\" does not own root privileges\n"
        return 1
    fi

    if [ ! -d /usr/share/applications/ ]; then
        echo_error "\"/usr/share/applications/\" folder not found\n"
        return 1
    fi

    title='WebStorm'
    icon='/snap/webstorm/current/bin/webstorm.png'
    executable='webstorm'
    # shellcheck disable=SC2016
    command='--line "${line}" "${file}"'
    terminal='false'

    alert_primary "Installing ${title} URL Handler"

    _render_handler_script "${title}" "${executable}" "${command}"

    _render_desktop_shortcut "${title}" "${icon}" "${executable}" "${terminal}"
}

_render_handler_script() {
    title=$1
    executable=$2
    command=$3

    # create handler script
    echo_info "cat > /usr/bin/${executable}-url-handler<<EOF ...\n"
    cat > /usr/bin/"${executable}"-url-handler<<EOF
#!/usr/bin/env bash

#/**
# * ${title} URL Handler
# *
# * Opens file links : ${executable}://open?url=file://@file&line=@line
# *
# * @license GPL
# * @author "Stefan Auditor" <stefan.auditor@erdfisch.de>
# * @author "Matthias Morin" <mat@tangoman.io>
# */

# https://stackoverflow.com/a/37840948/465732
function urldecode() { : "\${*//+/ }"; echo -e "\${_//%/\\\x}"; }

argument=\$(urldecode "\$1")
pattern=".*file(:\/\/|\=)(.*)&line=(.*)"

file=\$(echo "\${argument}" | sed -r "s/\${pattern}/\2/")
line=\$(echo "\${argument}" | sed -r "s/\${pattern}/\3/")

# check if ${executable} command exists.
if [ -n "\$(command -v ${executable})" ]; then
    ${executable} ${command}
fi

exit 0
EOF

    echo_info "chmod uga+x /usr/bin/${executable}-url-handler\n"
    chmod uga+x /usr/bin/"${executable}"-url-handler
}

_render_desktop_shortcut() {
    title=$1
    icon=$2
    executable=$3
    terminal=$4

    # create desktop shortcut
    echo_info "sh -c \"cat > /usr/share/applications/${executable}-url-handler.desktop<<EOF ...\n"
    sh -c "cat > /usr/share/applications/${executable}-url-handler.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${title} URL Handler
Comment=Handle URL Scheme ${executable}://open?url=file://@file&line=@line and ${executable}://open?file=@file&line=@line
Icon=${icon}
NoDisplay=true
Categories=TextEditor;Utility;
Exec=${executable}-url-handler %u
Terminal=${terminal}
MimeType=x-scheme-handler/${executable};
X-Desktop-File-Install-Version=0.21
EOF"

    echo_info 'update-desktop-database\n'
    update-desktop-database

    echo_info 'test from the terminal with: '
    echo_secondary "xdg-open \"${executable}://open?url=file:///etc/os-release&line=3\"\n"
}

## Check user is root
_is_root() {
    if [ "$(id | awk '{print $1}')" = 'uid=0(root)' ];then
        echo true
        return 0
    fi

    echo false
}

#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; NL='\033[0m\n';
    ALERT_PRIMARY='\033[1;104;97m'; ALERT_SECONDARY='\033[1;45;97m'; ALERT_SUCCESS='\033[1;42;97m'; ALERT_DANGER='\033[1;41;97m'; ALERT_WARNING='\033[1;43;97m'; ALERT_INFO='\033[1;44;97m'; ALERT_LIGHT='\033[1;47;90m'; ALERT_DARK='\033[1;40;37m';
}

echo_primary()   { printf "%b%b${DEFAULT}" "${PRIMARY}"   "${*}"; }
echo_secondary() { printf "%b%b${DEFAULT}" "${SECONDARY}" "${*}"; }
echo_success()   { printf "%b%b${DEFAULT}" "${SUCCESS}"   "${*}"; }
echo_danger()    { printf "%b%b${DEFAULT}" "${DANGER}"    "${*}"; }
echo_warning()   { printf "%b%b${DEFAULT}" "${WARNING}"   "${*}"; }
echo_info()      { printf "%b%b${DEFAULT}" "${INFO}"      "${*}"; }
echo_light()     { printf "%b%b${DEFAULT}" "${LIGHT}"     "${*}"; }
echo_dark()      { printf "%b%b${DEFAULT}" "${DARK}"      "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s ${DEFAULT}" "${SUCCESS}" "$2"; else printf "%b%b ${DEFAULT}" "${SUCCESS}" "${*}"; fi }
echo_error()     { printf "%berror: %b${DEFAULT}" "${DANGER}"  "${*}"; }

alert_primary()   { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "${*}" "${ALERT_PRIMARY}"   ''; }
alert_secondary() { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "${*}" "${ALERT_SECONDARY}" ''; }
alert_success()   { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "${*}" "${ALERT_SUCCESS}"   ''; }
alert_danger()    { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "${*}" "${ALERT_DANGER}"    ''; }
alert_warning()   { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "${*}" "${ALERT_WARNING}"   ''; }
alert_info()      { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "${*}" "${ALERT_INFO}"      ''; }
alert_light()     { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_LIGHT}"     '' "${ALERT_LIGHT}"     "${*}" "${ALERT_LIGHT}"     ''; }
alert_dark()      { printf "${NL}%b%64s${NL}%b %-63s${NL}%b%64s${NL}\n" "${ALERT_DARK}"      '' "${ALERT_DARK}"      "${*}" "${ALERT_DARK}"      ''; }

#--------------------------------------------------

## Print this help (default)
help() {
    alert_primary 'IDE URL Handler Installer'

    echo_warning 'Infos:\n'
    echo_label 10 '  author';  echo_primary '"Matthias Morin" <mat@tangoman.io>\n'
    echo_label 10 '  version'; echo_primary '1.0.0\n'
    echo_label 10 '  link';    echo_primary 'https://github.com/TangoMan75/ide-url-handler\n\n'

    echo_warning 'Description:\n'
    echo_primary '  This script installs / uninstalls URL handler for multiple IDEs\n\n'

    echo_warning 'Usage:\n'
    echo_success '  sh ide-url-handler.sh '
    echo_secondary '['
    echo_warning 'command'
    echo_secondary ']\n\n'

    echo_warning 'Command:\n'
    echo_label 28 '  install';                   echo_primary 'Install URL handlers automatically\n'
    echo_label 28 '  uninstall';                 echo_primary 'Uninstall URL handlers\n'
    echo_label 28 '  install_atom';              echo_primary 'Install Atom URL handler\n'
    echo_label 28 '  install_code';              echo_primary 'Install Visual Studio Code URL handler\n'
    echo_label 28 '  install_emacs';             echo_primary 'Install Emacs URL handler\n'
    echo_label 28 '  install_nano';              echo_primary 'Install Nano URL handler\n'
    echo_label 28 '  install_phpstorm';          echo_primary 'Install PHPStorm URL handler\n'
    echo_label 28 '  install_pycharm';           echo_primary 'Install PyCharm URL handler\n'
    echo_label 28 '  install_pycharm_community'; echo_primary 'Install PyCharm Community URL handler\n'
    echo_label 28 '  install_subl';              echo_primary 'Install Sublime Text URL handler\n'
    echo_label 28 '  install_vim';               echo_primary 'Install Vim URL handler\n'
    echo_label 28 '  install_webstorm';          echo_primary 'Install WebStorm URL handler\n'
    echo_label 28 '  help';                      echo_primary 'Print this help (default)\n\n'
}

#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    if [ $# -gt 1 ]; then
        echo_error "too many arguments ($#)\n"
        help
        exit 1
    fi

    case $1 in
        install)                   install;;
        uninstall)                 uninstall;;
        install_atom)              install_atom;;
        install_code)              install_code;;
        install_emacs)             install_emacs;;
        install_nano)              install_nano;;
        install_phpstorm)          install_phpstorm;;
        install_pycharm)           install_pycharm;;
        install_pycharm_community) install_pycharm_community;;
        install_subl)              install_subl;;
        install_vim)               install_vim;;
        install_webstorm)          install_webstorm;;
        help)                      help;;
        *) echo_danger "error: \"$1\" is not a valid command\n";
        exit 1;;
    esac
}

_main "$@"
