select id, [value] = stuff((select ',' + [value] from tb t where id = tb.id for xml path('')) , 1 , 1 , '')  
from tb  
group by id  
--开始查询
select cust_num,compCode,product=stuff((select ','+name from tpm 
                                        where t.cust_num=cust_num for xml path('')),1,1,'') 
from info t
--测试结果
/*
cust_num compCode    product
-------- ----------- -----------------------
a        20000001    电脑,电视机
b        20000002    电视机,电冰箱,洗衣机
*/
select memo +'//' from a for xml path('')


