--alter table mrwang90hou.[dbo].BG_gongGao
--add pic_exist float null;
--SELECT TOP 1000 [BGid],[BGmarkName],[BGstyle],[BGappPerson] = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,''),[BGdaili_company],[pic_exist] FROM [mrwang90hou].[dbo].[BG_gongGao] where [BGappPerson] like '%[(]%' and [BGappPerson] like '%)%' order by cast(BGid as int)		--共计2017行

use mrwang90hou
--update BG_gongGao 
--set pic_exist = replace(BGappPerson,substring(BGappPerson,2,2),'')


update BG_gongGao set pic_exist = 0.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'
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


/*********************************************************自定义function函数学习***************************************************************************/
--提取字符串中的不同类型字符
 
use PracticeDB
go
create   function   fun_getCN(@str   nvarchar(4000))   
  returns   nvarchar(4000)   
  as   
  begin   
  declare   @word   nchar(1),@CN   nvarchar(4000)   
  set   @CN=''   
  while   len(@str)>0   
  begin   
  set   @word=left(@str,1)   
  if unicode(@word)   between   19968   and   19968+20901 
      set   @CN=@CN+@word
  set   @str=right(@str,len(@str)-1)   
  end   
  return   @CN   
  end   
 
select dbo.fun_getCN('ASDKG论坛KDL')
--论坛
select dbo.fun_getCN('ASDKG論壇KDL')
--論壇
select dbo.fun_getCN('ASDKDL')
--空字符串
 
 
 
--提取数字
IF OBJECT_ID('DBO.GET_NUMBER2') IS NOT NULL
DROP FUNCTION DBO.GET_NUMBER2
GO
CREATE FUNCTION DBO.GET_NUMBER2(@S VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
WHILE PATINDEX('%[^0-9]%',@S) > 0
BEGIN
set @s=stuff(@s,patindex('%[^0-9]%',@s),1,'')
END
RETURN @S
END
GO
--测试
PRINT DBO.GET_NUMBER('呵呵ABC123ABC')
GO
--123
--------------------------------------------------------------------
--提取英文
IF OBJECT_ID('DBO.GET_STR') IS NOT NULL
DROP FUNCTION DBO.GET_STR
GO
CREATE FUNCTION DBO.GET_STR(@S VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
WHILE PATINDEX('%[^a-z]%',@S) > 0
BEGIN
set @s=stuff(@s,patindex('%[^a-z]%',@s),1,'')
END
RETURN @S
END
GO
--测试
PRINT DBO.GET_STR('呵呵ABC123ABC')
GO
--------------------------------------------------------------------
--提取中文
IF OBJECT_ID('DBO.CHINA_STR') IS NOT NULL
DROP FUNCTION DBO.CHINA_STR
GO
CREATE FUNCTION DBO.CHINA_STR(@S NVARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
WHILE PATINDEX('%[^吖-座]%',@S) > 0
SET @S = STUFF(@S,PATINDEX('%[^吖-座]%',@S),1,N'')
RETURN @S
END
GO
PRINT DBO.CHINA_STR('呵呵ABC123ABC')
GO

--
/*
				《SQL Server查询中特殊字符的处理方法》
			https://www.cnblogs.com/shiyh/p/6971250.html
SQL Server查询中，经常会遇到一些特殊字符，比如单引号“'”等，这些字符的处理方法，是SQL Server用户都应该需要知道的。

我们都知道SQL Server查询过程中，单引号“'”是特殊字符，所以在SQL Server查询的时候要转换成双单引号“''”。
但这只是特殊字符的一个，在实际项目中，发现对于like操作还有以下特殊字符：下划线“_”，百分号“%”，方括号“[]”以及尖号“^”。
其用途如下：
下划线：用于代替一个任意字符（相当于正则表达式中的 ? ）
百分号：用于代替任意数目的任意字符（相当于正则表达式中的 * ）
方括号：用于转义（事实上只有左方括号用于转义，右方括号使用最近优先原则匹配最近的左方括号）
尖号：用于排除一些字符进行匹配（这个与正则表达式中的一样）

以下是一些匹配的举例，需要说明的是，只有like操作才有这些特殊字符，=操作是没有的。
a_b...        a[_]b%
a%b...       a[%]b%
a[b...       a[[]b%
a]b...       a]b%
a[]b...      a[[]]b%
a[^]b...     a[[][^]]b%
a[^^]b...    a[[][^][^]]b%

在实际进行处理的时候，对于=操作，我们一般只需要如此替换：
' -> ''
对于like操作，需要进行以下替换（注意顺序也很重要）
[ -> [[]     (这个必须是第一个替换的!!)
% -> [%]    (这里%是指希望匹配的字符本身包括的%而不是专门用于匹配的通配符)
_ -> [_]
^ -> [^]

*/