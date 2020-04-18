#!/data/data/com.termux/files/usr/bin/sh

print_status() {
    printf "[*] ${1}...\n"
}

get_tar() {
    wget -c https://github.com/peterQiu/download/blob/master/jdk8_aarch64.tar.gz -O jdk8_aarch64.tar.gz
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
  cd $home
  mysql_install_db
  nohup mysqld &
  echo -e '\n'
}
prepare_asset_sql(){
  wget -c https://github.com/peterQiu/download/blob/master/database.sql -O database.sql
  wget -c https://github.com/peterQiu/download/blob/master/schema.sql -O schema.sql
  wget -c https://github.com/peterQiu/download/blob/master/data.sql -O data.sql
  sleep 5
  mysql < ./database.sql
  mysql < ./schema.sql
  mysql < ./data.sql
}

prepare_asset_jar(){
  wget -c https://github.com/peterQiu/download/blob/master/asset.jar -O asset.jar
  nohup java -jar asset.jar &
  echo -e '\n'
}

print_status "prepare"
prepare
print_status "getting tar file and setting all things"
get_tar
print_status "cleaning up"
cleanup
print_status "installing mysql"
prepare_mysql
print_status "preparing asset sql"
prepare_asset_sql
print_status "preparing asset jar"
prepare_asset_jar
print_status "finished"


