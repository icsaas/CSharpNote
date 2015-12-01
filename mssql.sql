-- 创建测试主表. ID 是主键.
CREATE TABLE test_main (
id INT,
value VARCHAR(10),
PRIMARY KEY(id) 
);

-- 创建测试子表. 
CREATE TABLE test_sub (
id INT,
main_id INT,
value VARCHAR(10),
PRIMARY KEY(id) 
);

默认外键约束方式
ALTER TABLE test_sub ADD CONSTRAINT main_id_cons FOREIGN KEY (main_id) REFERENCES test_main;

DELETE CASCADE 方式
-- 创建外键(使用 ON DELETE CASCADE 选项，删除主表的时候，同时删除子表)
ALTER TABLE test_sub
ADD CONSTRAINT main_id_cons
FOREIGN KEY (main_id) REFERENCES test_main ON DELETE CASCADE;

UPDATE CASCADE方式
-- 创建外键(使用 ON UPDATE CASCADE 选项，更新主表的主键时候，同时更新子表外键)
ALTER TABLE test_sub
ADD CONSTRAINT main_id_cons
FOREIGN KEY (main_id) REFERENCES test_main ON UPDATE CASCADE;

SET NULL方式
-- 创建外键(使用 ON DELETE SET NULL 选项，删除主表的时候，同时将子表的 main_id 设置为 NULL)
ALTER TABLE test_sub
ADD CONSTRAINT main_id_cons
FOREIGN KEY (main_id) REFERENCES test_main ON DELETE SET NULL;