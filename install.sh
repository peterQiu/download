#!/data/data/com.termux/files/usr/bin/sh

print_status() {
    printf "[*] ${1}...\n"
}

install_jdk() {
    tar -xf jdk8_aarch64.tar.gz -C $PREFIX/share
    chmod +x $PREFIX/share/bin/*
    mv $PREFIX/share/bin/* $PREFIX/bin
}

cleanup() {
    rm -f jdk8_aarch64.tar.gz
    rm -rf $PREFIX/share/bin
}

prepare(){
  termux-wake-lock
  pkg install proot
  termux-chroot
}
prepare_mysql(){
  pkg install mariadb
  mysql_install_db
  nohup mysqld &
  echo -e '\n'
}
prepare_asset_sql(){
  sleep 5
  mysql < ./database.sql
  mysql < ./schema.sql
  mysql < ./data.sql
}

prepare_asset_jar(){
  nohup java -jar asset.jar &
  echo -e '\n'
}

print_status "prepare"
prepare
print_status "installing jdk"
install_jdk
print_status "cleaning up"
cleanup
print_status "installing mysql"
prepare_mysql
print_status "preparing asset sql"
prepare_asset_sql
print_status "preparing asset jar"
prepare_asset_jar
print_status "finished"


