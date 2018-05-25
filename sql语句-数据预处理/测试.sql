--alter table mrwang90hou.[dbo].BG_gongGao
--add pic_exist float null;
--SELECT TOP 1000 [BGid],[BGmarkName],[BGstyle],[BGappPerson] = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,''),[BGdaili_company],[pic_exist] FROM [mrwang90hou].[dbo].[BG_gongGao] where [BGappPerson] like '%[(]%' and [BGappPerson] like '%)%' order by cast(BGid as int)		--共计2017行

use mrwang90hou
--update BG_gongGao 
--set pic_exist = replace(BGappPerson,substring(BGappPerson,2,2),'')


--update BG_gongGao set pic_exist = 0.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'
--reverse(substring(reverse(words) ,charindex('(',reverse(words)) + 1 , len(words)))
--select * from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'
--select * from BG_gongGao where pic_exist = 0.11
--添加修改后的数据，标记为1.11

--select count(id) from Chinese_words	--共计行数：380555

--DECLARE： 定义变量，变量第一个字母是“@”
--SET：设置变量
--IF NOT EXISTS：如果不存在数据，执行BEGIN-END模块中的语句
--GO：批解释信号，告诉编辑器代码已结束。
--select count(BGid) from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'	

--方法一：通过建立中间表存储操作
--select [BGid,BGmarkName,BGstyle,BGappPerson,BGdaili_company,pic_exist] into BG_gongGao2 from BG_gongGao where 1=1   

select * into BG_gongGao2 from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'

update BG_gongGao2 set BGappPerson = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,'') ,pic_exist = 1.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'

insert into BG_gongGao select * from BG_gongGao2;
drop table BG_gongGao2
--delete from BG_gongGao where BGmarkName is null or pic_exist =1.11
/*
--insert into BG_gongGao select * from BG_gongGao2 
----2)更新到一个已经有数据的表中
--insert into BG_gongGao2 select * from BG_gongGao where 1
--use mrwang90hou
--insert into BG_gongGao(BGid,BGappPerson)  select BGid,BGappPerson from BG_gongGao2;


--insert into tableb..bb(b1,b2,b3) select a1,a2,a3 from tablea..aa 

--insert into BG_gongGao2 select * from BG_gongGao;
--BG_gongGao2 select * 
--这是原型
--insert into ncdbmZ14092400001--表名
-- select
-- recorderNO,--主键（类型为varchar）
--ncd40924ncdrw02, --字段
--curStatus,--字段
--ncd40924ncjrw05,--字段
--procID,--字段
--curNodeID,--字段
--linkRecordID  --字段
--from ncdbmZ14092400001 --表名
--where procID='条件' and curNodeID='条件' and linkRecordID ='条件';
 
--这是我要操作的数据
--insert into ncdbmZ14092400001--表名
-- select
-- ‘替换成想插入的数据’,--主键（类型为varchar），主键不能重复
--ncd40924ncdrw02, --字段
--curStatus,--字段
--ncd40924ncjrw05,--字段
--procID,--字段
--'替换成想插入的数据',--字段,
--'替换成想插入的数据'  --字段
--from ncdbmZ14092400001 --表名
--where procID='条件' and curNodeID='条件' and linkRecordID ='条件';
*/


--方法二：通过存储过程进行操作
--declare @newDatas nvarchar(50)

--SET @newDatas = (SELECT BGappPerson FROM BG_gongGao WHERE BGmarkName ='wangning')  

--declare @MyCounter INT
--declare @totalNumber INT
--set @MyCounter = 0            /*设置变量*/
--set @totalNumber = (select count(BGid) from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%')		/*设置*/
--WHILE (@MyCounter < @totalNumber)     /*设置循环次数*/
--BEGIN
--  --insert into t_class(name)  values('班级')
--  INSERT INTO BG_gongGao( [BGid]
--      ,[BGmarkName]
--      ,[BGstyle]
--      ,[BGappPerson]
--      ,[BGdaili_company]
--      ,[pic_exist]) VALUES(178847	'LONG CHAMP'	24	'U兰简甲.股份有限公司 S.A.S.JEAN CASSEGRAIN'	'北M伟和知识产权代理有限公司'	0.11);
--  select @newDatas
--  SET @MyCounter = @MyCounter + 1
--END