PS1='[\u@\h \W]\$ '

PATH="/var/lib/flatpak/exports/bin:$PATH"
PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"

PATH="/opt/go/bin:$PATH"
PATH="/opt/node/bin:$PATH"
PATH="/opt/clojure/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

JAVA_HOME="/opt/jdk"
PATH="${JAVA_HOME}/bin:$PATH"

export PATH JAVA_HOME
