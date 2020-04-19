#!/data/data/com.termux/files/usr/bin/sh

print_status() {
    printf "[*] ${1}...\n"
}
prepare_jdk() {
    tar -xf jdk8_aarch64.tar.gz -C $PREFIX/share
    chmod +x $PREFIX/share/bin/*
    mv $PREFIX/share/bin/* $PREFIX/bin
    rm -f jdk8_aarch64.tar.gz
    rm -rf $PREFIX/share/bin
}

prepare_mysql(){
  pkg install mariadb
}

print_status "prepare install mysql "
prepare_mysql
print_status "prepare install jdk "
prepare_jdk
print_status "finished"


