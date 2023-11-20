script_dir="$(dirname "$0")"

# run as root
sudo -s

apt update
apt install -y --no-install-recommends build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
apt install -y --no-install-recommends curl xz-utils git

cd ~
curl -O https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tar.xz
tar -xvf Python-3.11.6.tar.xz
cd Python-3.11.6
./configure --enable-optimizations
make -j $(nproc)
nohup make -j $(nproc) >nohup.log 2>&1 &
make altinstall
make bininstall
python3 -V

apt remove -y libsqlite3-0 libsqlite3-dev
cd ~
curl -O https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz
tar xvfz sqlite-autoconf-3440000.tar.gz
cd sqlite-autoconf-3440000
./configure
make -j $(nproc)
make install
sqlite3 --version

cd ~
mkdir hass
cd hass
python3 -m venv .
. bin/activate
pip config set global.index-url http://mirrors.ustc.edu.cn/pypi/web/simple
pip config set global.trusted-host mirrors.ustc.edu.cn
pip install -U pip homeassistant
hass -v

cd $script_dir
chmod a+x install_service.sh
./install_service.sh

# env
cat <<EOF >>/root/.bashrc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/;/usr/lib/aarch64-linux-gnu/
EOF

# service
ln -sf /root/HASS_Linux_Deploy/hass_daemon /etc/init.d/

# [optional] HACS - Home Assistant Community Store
# https://github.com/hacs/integration/releases
wget -O - https://get.hacs.xyz | bash -
