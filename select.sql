select id, [value] = stuff((select ',' + [value] from tb t where id = tb.id for xml path('')) , 1 , 1 , '')  
from tb  
group by id  
--��ʼ��ѯ
select cust_num,compCode,product=stuff((select ','+name from tpm 
                                        where t.cust_num=cust_num for xml path('')),1,1,'') 
from info t
--���Խ��
/*
cust_num compCode    product
-------- ----------- -----------------------
a        20000001    ����,���ӻ�
b        20000002    ���ӻ�,�����,ϴ�»�
*/
select memo +'//' from a for xml path('')


