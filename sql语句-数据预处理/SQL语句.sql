use index_trademark
SELECT distinct un_simplified FROM Chinese_Img where id=76909		--筛选不重复项
--数据预处理：特殊字符的筛选
--目前存在的特殊字符串有：  { } ? ( )
--处理步骤：（1）剔除括号内文字			（2）剔除非文字内容【提取中文】
SELECT TOP 2000 * FROM [Index_TradeMark].[dbo].[Chinese_words] where words like '%(%' --order by id
 order by cast(id as int)


SELECT * FROM [mrwang90hou].[dbo].[BG_gongGao] WHERE BGappPerson LIKE '%[吖-座]%'
--[吖-座]是中文字符集第一个到最后一个的范围
SELECT * FROM [mrwang90hou].[dbo].[BG_gongGao].get_NoCW


--select * from sys.tables   -- //查询数据库中所有的表名及行数
select count(id) from Chinese_Img	--共计行数：1160040


use mrwang90hou
update BG_gongGao 
set BGappPerson=replace(BGappPerson,substring(BGappPerson,2,2),'')
--Start 是要替换的字符开始的位置
--Lenght 要替换字符的长度



--去掉（）内部内容
--查询
--use Index_TradeMark_wn
--select reverse(substring(reverse(words) ,charindex('(',reverse(words)) + 1 , len(words))) from Chinese_words
--更新
update Index_TradeMark_wn.dbo.Chinese_words
set words = reverse(substring(reverse(words) ,charindex('(',reverse(words)) + 1 , len(words)))
select * from Chinese_words
--drop table Chinese_words

--查询所有的特殊字符串
use [Index_TradeMark_wn]
  SELECT [id]
      ,[words]
      ,[ChineseSpell],PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))
      ,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].[Chinese_words]
  where PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))!=0 --or words like '%(%'
  order by PATINDEX('%[^a-z]%',rtrim([ChineseSpell])) desc



  use [Index_TradeMark_wn]
  SELECT [id]
      --,[eng_words]
      ,eng_word,PATINDEX('%[^a-z]%',rtrim(eng_word))
	  ,mean
      --,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].EngWord
  where PATINDEX('%[^a-z]%',rtrim(eng_word))!=0 --or words like '%(%'
  order by PATINDEX('%[^a-z]%',rtrim(id)) desc


  use mrwang90hou
select reverse(substring(reverse(BGappPerson) ,charindex('(',reverse(BGappPerson))+2, len(BGappPerson)-charindex(')',reverse(BGappPerson)))) from BG_gongGao where BGappPerson like '%(%' and BGappPerson like '%)%'

select BGappPerson = stuff(BGappPerson,charindex('(',BGappPerson),charindex(')',BGappPerson),'') from BG_gongGao where BGappPerson like '%(%' and BGappPerson like '%)%'

--update BG_gongGao set BGappPerson = stuff(BGappPerson,charindex('[',BGappPerson),charindex(']',BGappPerson)-charindex('[',BGappPerson)+1,'') where BGappPerson like '%[(]%' and BGappPerson like '%)%'
select  BGappPerson = stuff(BGappPerson,charindex('(',BGappPerson),charindex(')',BGappPerson)-charindex('(',BGappPerson)+1,'') from BG_gongGao where BGappPerson like '%[(]%' and BGappPerson like '%)%'
update BG_gongGao set BGappPerson = stuff(BGappPerson,charindex('[',BGappPerson),charindex(']',BGappPerson)-charindex('[',BGappPerson)+1,'') where BGappPerson like '%[(]%' and BGappPerson like '%)%'

