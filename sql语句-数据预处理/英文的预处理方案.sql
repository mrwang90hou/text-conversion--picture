use [Index_TradeMark_wn]
--查询所有的特殊字符串
 -- SELECT [id]
 --     ,[eng_word]
	--  ,PATINDEX('%[^a-z]%',rtrim(replace(replace([eng_word],' ',''),'''','')))
 --     ,[mean]
 --     ,[firsteng]
 --     ,[cixing]
 --     ,[en_yinbiao]
 --     ,[am_yinbiao]
 -- FROM [EngWord] where PATINDEX('%[^a-z]%',rtrim(replace(replace([eng_word],' ',''),'''','')))!=0 --and PATINDEX('%[a-z]%',rtrim(words))!=0
 --order by cast(id as int)
 --数据预处理：在[[EngWord]]表中增加字段pic_exist,(0表示“未生成图片”，1表示“生成图片”)
 --建立新的字段pic_exist,
--alter table [index_trademark_wn].[dbo].[EngWord]
--add pic_exist smallint null;
--update EngWord set pic_exist = 0 where PATINDEX('%[^a-z]%',rtrim(replace(replace([eng_word],' ',''),'''','')))!=0
--update EngWord set pic_exist = 1 where PATINDEX('%[^a-z]%',rtrim(replace(replace([eng_word],' ',''),'''','')))=0

--SELECT * from EngWord where pic_exist = 0
--select *from EngWord where eng_word like '%''%'
--select count(id) from EngWord	--共计行数：331479
--select count(id) from EngWord where pic_exist = 0	--共计行数：6864
--select count(id) from EngWord where pic_exist = 1	--共计行数：324615
--select count(id) from EngWord where pic_exist is null	--共计行数：0

SELECT distinct eng_word FROM EngWord where id<=100 and pic_exist =1