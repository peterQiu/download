#!/data/data/com.termux/files/usr/bin/sh

prepare_jdk() {
    tar -xf jdk8_aarch64.tar.gz -C $PREFIX/share
    chmod +x $PREFIX/share/bin/*
    mv $PREFIX/share/bin/* $PREFIX/bin
    rm -f jdk8_aarch64.tar.gz
    rm -rf $PREFIX/share/bin
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

print_status "prepare jdk"
prepare_jdk
print_status "cleaning up"
cleanup
print_status "prepare mysql"
prepare_mysql
print_status "preparing asset sql"
prepare_asset_sql
print_status "finished"


