
-- +migrate Up
create table if not exists tasks (
  id int  NOT NULL AUTO_INCREMENT primary key ,
  user_id  int NOT NULL REFERENCES users (id) ,
  task varchar(255) ,
  exp int,
  due datetime,
  done tinyint
  );
-- +migrate Down
drop table if exists tasks;