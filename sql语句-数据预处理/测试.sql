--alter table mrwang90hou.[dbo].BG_gongGao
--add pic_exist float null;
--SELECT TOP 1000 [BGid],[BGmarkName],[BGstyle],[BGappPerson] = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,''),[BGdaili_company],[pic_exist] FROM [mrwang90hou].[dbo].[BG_gongGao] where [BGappPerson] like '%[(]%' and [BGappPerson] like '%)%' order by cast(BGid as int)		--����2017��

use mrwang90hou
--update BG_gongGao 
--set pic_exist = replace(BGappPerson,substring(BGappPerson,2,2),'')


update BG_gongGao set pic_exist = 0.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'
--reverse(substring(reverse(words) ,charindex('(',reverse(words)) + 1 , len(words)))
--select * from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'
--select * from BG_gongGao where pic_exist = 0.11
--����޸ĺ�����ݣ����Ϊ1.11

--select count(id) from Chinese_words	--����������380555

--DECLARE�� ���������������һ����ĸ�ǡ�@��
--SET�����ñ���
--IF NOT EXISTS��������������ݣ�ִ��BEGIN-ENDģ���е����
--GO���������źţ����߱༭�������ѽ�����
--select count(BGid) from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'	

--����һ��ͨ�������м��洢����
--select [BGid,BGmarkName,BGstyle,BGappPerson,BGdaili_company,pic_exist] into BG_gongGao2 from BG_gongGao where 1=1   

select * into BG_gongGao2 from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%'

update BG_gongGao2 set BGappPerson = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,'') ,pic_exist = 1.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'

insert into BG_gongGao select * from BG_gongGao2;
drop table BG_gongGao2
--delete from BG_gongGao where BGmarkName is null or pic_exist =1.11
/*
--insert into BG_gongGao select * from BG_gongGao2 
----2)���µ�һ���Ѿ������ݵı���
--insert into BG_gongGao2 select * from BG_gongGao where 1
--use mrwang90hou
--insert into BG_gongGao(BGid,BGappPerson)  select BGid,BGappPerson from BG_gongGao2;


--insert into tableb..bb(b1,b2,b3) select a1,a2,a3 from tablea..aa 

--insert into BG_gongGao2 select * from BG_gongGao;
--BG_gongGao2 select * 
--����ԭ��
--insert into ncdbmZ14092400001--����
-- select
-- recorderNO,--����������Ϊvarchar��
--ncd40924ncdrw02, --�ֶ�
--curStatus,--�ֶ�
--ncd40924ncjrw05,--�ֶ�
--procID,--�ֶ�
--curNodeID,--�ֶ�
--linkRecordID  --�ֶ�
--from ncdbmZ14092400001 --����
--where procID='����' and curNodeID='����' and linkRecordID ='����';
 
--������Ҫ����������
--insert into ncdbmZ14092400001--����
-- select
-- ���滻�����������ݡ�,--����������Ϊvarchar�������������ظ�
--ncd40924ncdrw02, --�ֶ�
--curStatus,--�ֶ�
--ncd40924ncjrw05,--�ֶ�
--procID,--�ֶ�
--'�滻������������',--�ֶ�,
--'�滻������������'  --�ֶ�
--from ncdbmZ14092400001 --����
--where procID='����' and curNodeID='����' and linkRecordID ='����';
*/


--��������ͨ���洢���̽��в���
--declare @newDatas nvarchar(50)

--SET @newDatas = (SELECT BGappPerson FROM BG_gongGao WHERE BGmarkName ='wangning')  

--declare @MyCounter INT
--declare @totalNumber INT
--set @MyCounter = 0            /*���ñ���*/
--set @totalNumber = (select count(BGid) from BG_gongGao where BGappPerson like '%(%' and  BGappPerson like '%)%')		/*����*/
--WHILE (@MyCounter < @totalNumber)     /*����ѭ������*/
--BEGIN
--  --insert into t_class(name)  values('�༶')
--  INSERT INTO BG_gongGao( [BGid]
--      ,[BGmarkName]
--      ,[BGstyle]
--      ,[BGappPerson]
--      ,[BGdaili_company]
--      ,[pic_exist]) VALUES(178847	'LONG CHAMP'	24	'U�����.�ɷ����޹�˾ S.A.S.JEAN CASSEGRAIN'	'��Mΰ��֪ʶ��Ȩ�������޹�˾'	0.11);
--  select @newDatas
--  SET @MyCounter = @MyCounter + 1
--END


/*********************************************************�Զ���function����ѧϰ***************************************************************************/
--��ȡ�ַ����еĲ�ͬ�����ַ�
 
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
 
select dbo.fun_getCN('ASDKG��̳KDL')
--��̳
select dbo.fun_getCN('ASDKGՓ��KDL')
--Փ��
select dbo.fun_getCN('ASDKDL')
--���ַ���
 
 
 
--��ȡ����
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
--����
PRINT DBO.GET_NUMBER('�Ǻ�ABC123ABC')
GO
--123
--------------------------------------------------------------------
--��ȡӢ��
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
--����
PRINT DBO.GET_STR('�Ǻ�ABC123ABC')
GO
--------------------------------------------------------------------
--��ȡ����
IF OBJECT_ID('DBO.CHINA_STR') IS NOT NULL
DROP FUNCTION DBO.CHINA_STR
GO
CREATE FUNCTION DBO.CHINA_STR(@S NVARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
WHILE PATINDEX('%[^߹-��]%',@S) > 0
SET @S = STUFF(@S,PATINDEX('%[^߹-��]%',@S),1,N'')
RETURN @S
END
GO
PRINT DBO.CHINA_STR('�Ǻ�ABC123ABC')
GO

--
/*
				��SQL Server��ѯ�������ַ��Ĵ�������
			https://www.cnblogs.com/shiyh/p/6971250.html
SQL Server��ѯ�У�����������һЩ�����ַ������絥���š�'���ȣ���Щ�ַ��Ĵ���������SQL Server�û���Ӧ����Ҫ֪���ġ�

���Ƕ�֪��SQL Server��ѯ�����У������š�'���������ַ���������SQL Server��ѯ��ʱ��Ҫת����˫�����š�''����
����ֻ�������ַ���һ������ʵ����Ŀ�У����ֶ���like�����������������ַ����»��ߡ�_�����ٷֺš�%���������š�[]���Լ���š�^����
����;���£�
�»��ߣ����ڴ���һ�������ַ����൱��������ʽ�е� ? ��
�ٷֺţ����ڴ���������Ŀ�������ַ����൱��������ʽ�е� * ��
�����ţ�����ת�壨��ʵ��ֻ������������ת�壬�ҷ�����ʹ���������ԭ��ƥ������������ţ�
��ţ������ų�һЩ�ַ�����ƥ�䣨�����������ʽ�е�һ����

������һЩƥ��ľ�������Ҫ˵�����ǣ�ֻ��like����������Щ�����ַ���=������û�еġ�
a_b...        a[_]b%
a%b...       a[%]b%
a[b...       a[[]b%
a]b...       a]b%
a[]b...      a[[]]b%
a[^]b...     a[[][^]]b%
a[^^]b...    a[[][^][^]]b%

��ʵ�ʽ��д����ʱ�򣬶���=����������һ��ֻ��Ҫ����滻��
' -> ''
����like��������Ҫ���������滻��ע��˳��Ҳ����Ҫ��
[ -> [[]     (��������ǵ�һ���滻��!!)
% -> [%]    (����%��ָϣ��ƥ����ַ����������%������ר������ƥ���ͨ���)
_ -> [_]
^ -> [^]

*/