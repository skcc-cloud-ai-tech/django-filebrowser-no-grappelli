#!/bin/bash

DJANGO_VERSIONS=("2.0" "3.0" "4.0")
VIRTUALENV_DIR="envs"
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p $VIRTUALENV_DIR

for version in "${DJANGO_VERSIONS[@]}"
do
    echo "--------"
    echo "DJANGO $version"
    echo "--------"

    echo "install last django"
    if [ ! -d "$VIRTUALENV_DIR/$version" ]; then
        virtualenv --system-site-packages --python=python3 "$VIRTUALENV_DIR/$version"
    fi
    source "$VIRTUALENV_DIR/$version/bin/activate"
    pip install "django~=$version.0"

    echo "install test dependencies"
    pip install -r "$BASEDIR/tests/requirements.txt"

    echo "run filebrowser test"
    python "$BASEDIR/runtests.py"
done
