
-- +migrate Up
create table if not exists users (
  id int  NOT NULL AUTO_INCREMENT primary key ,
  name varchar(255) ,
  level float
  );
-- +migrate Down
drop table if exists users;