# Install Debian in Linux Deploy
1. Root android phone
2. Install Linux Deploy
    - from Google play
3. Install Debian in Linux Deploy
    - debian arm64
# Install Home Assistant
1. Dependencies
    - Apt packages
        ```shell
        sudo apt update
        sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
        sudo apt install -y --no-install-recommends curl xz-utils
        ```
    - python 3.11
        ```
        curl -O https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tar.xz
        tar -xvf Python-3.11.6.tar.xz
        cd Python-3.11.6
        ./configure --enable-optimizations
        make -j `nproc`
        nohup make -j `nproc` > nohup.log 2>&1 &
        make altinstall
        sudo make bininstall
        python3 -V
        ```
    - Sqlite, old version not supportted
        ```
        sudo apt remove -y libsqlite3-0 libsqlite3-dev
        cd ~
        curl -O https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz
        tar xvfz sqlite-autoconf-3440000.tar.gz 
        cd sqlite-autoconf-3440000
        ./configure
        make -j `nproc`
        sudo make install
        sqlite3 --version

        ```
    3. install Home Assistant
        ```
        cd ~
        mkdir hass
        cd hass
        python3 -m venv .
        . bin/activate
        pip config set global.index-url http://mirrors.ustc.edu.cn/pypi/web/simple
        pip config set global.trusted-host mirrors.ustc.edu.cn
        pip install -U pip homeassistant
        hass -v
        ```
# setup Home Assistant as Service
1. copy hass_daemon to the home directory (or somewhere) in Debian(android)
2. then run:
    ```shell
    chmod a+x install_service.sh
    sudo ./install_service.sh
    ```