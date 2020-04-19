create user 'eproof'@'127.0.0.1' identified by 'eproof123456';
grant all privileges on *.* to 'eproof'@'127.0.0.1' ;
flush privileges;
create database if not exists eproof CHARSET=utf8;
