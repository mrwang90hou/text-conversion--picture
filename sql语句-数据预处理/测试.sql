--alter table mrwang90hou.[dbo].BG_gongGao
--add pic_exist float null;
--SELECT TOP 1000 [BGid],[BGmarkName],[BGstyle],[BGappPerson] = stuff([BGappPerson],charindex('(',[BGappPerson]),charindex(')',[BGappPerson])-charindex('(',[BGappPerson])+1,''),[BGdaili_company],[pic_exist] FROM [mrwang90hou].[dbo].[BG_gongGao] where [BGappPerson] like '%[(]%' and [BGappPerson] like '%)%' order by cast(BGid as int)		--����2017��

use mrwang90hou
--update BG_gongGao 
--set pic_exist = replace(BGappPerson,substring(BGappPerson,2,2),'')


--update BG_gongGao set pic_exist = 0.11 where BGappPerson like '%(%' and  BGappPerson like '%)%'
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