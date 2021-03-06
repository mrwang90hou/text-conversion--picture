--S1 第一步：在[Chinese_words]表中增加字段pic_exist,(0表示“未生成图片”，1表示“生成图片”，3表示“新扩充的数据”)
--alter table [index_trademark_wn].[dbo].[Chinese_words]
--add pic_exist float null;

/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 1000 * FROM [index_trademark_wn].[dbo].Chinese_words
use [index_trademark_wn]
--select count(id) from Chinese_words	--共计行数：380555
  --where eng_word like '%(%'
 --S2 第二步：对数据进行判断，赋值pic_exist，区分是否需要生成图片
 --数据预处理规则：（）存在特殊符号的去掉特殊符号,生成新的数据，标记为：1，再行判断是否符合“词语”的规则
				 --（）符合“词语”的规则为：字符区间[2,4]
				 --（1）去掉（）	[]		{}全部内容   原数据标记为：0.11		0.12		0.13    生成新的数据，记录为:1.11   1.12    1.13  
				 --（2）拆分规则：		诗句拆分，双空格分割，原始数据标记为：0.2		拆分后不存在字符,标记为：1.2
				 --（3）存在	？ “	 的进行标记：0.3，不进行拆分处理
				 --（4）纯英文，例【ＣＤ－ＲＯＭ  ＭＰ３  钴60】 直接标记为：0.4
				 --（5）拆分与舍弃规则： <1>-<5>  进行删除分隔符处理，原数据标记为：0.5，分割后数据标记为：1.5
				 --（6）希腊字母，直接标记为：1.6   例【α粒子	α射线	β粒子	β射线	γ刀  γ射线】id区间为：[3535,3540]	--6行数据
				 --（7）完全包含英语单词的处理	例【ＴＭＤ	ＴＶ	ＵＦＯ	ＶＣＤ】 直接舍弃，标记为0.7	--98行数据 
--(1)去掉（）	[]		{}全部内容   原数据标记为：0.1    生成新的数据，记录为:1.1
--select * from Chinese_words where words like '%(%' order by cast(id as int)
--select * from Chinese_words where words like '%)%' order by cast(id as int)    --多出的ID为：      210553	曝光表)   
    
--select * from Chinese_words where words like '%[%' order by cast(id as int)
--select * from Chinese_words where words like '%]%' order by cast(id as int)    
     
--select * from Chinese_words where words like '%{%' order by cast(id as int)
--select * from Chinese_words where words like '%}%' order by cast(id as int)      

--select  id,words = stuff(words,charindex('(',words),charindex(')',words)-charindex('(',words)+1,''),ChineseSpell,FirstSpell,pic_exist from [index_trademark_wn].[dbo].[Chinese_words] where words like '%[(]%' and words like '%)%' order by cast(id as int)		--共计2017行
--select  id,words = stuff(words,charindex('[',words),charindex(']',words)-charindex('[',words)+1,''),ChineseSpell,FirstSpell,pic_exist from [index_trademark_wn].[dbo].[Chinese_words] where words like '%[[]%' and words like '%]%' order by cast(id as int)		--共计2行
--select  id,words = stuff(words,charindex('{',words),charindex('}',words)-charindex('{',words)+1,''),ChineseSpell,FirstSpell,pic_exist from [index_trademark_wn].[dbo].[Chinese_words] where words like '%[{]%' and words like '%}%' order by cast(id as int)		--共计4行
/*   （）   的处理过程*/
--update Chinese_words set pic_exist = 0.11 where words like '%(%' and  words like '%)%'
--select * into Chinese_words2 from Chinese_words where pic_exist = 0.11
--update Chinese_words2 set words = stuff(words,charindex('(',words),charindex(')',words)-charindex('(',words)+1,'') ,pic_exist = 1.11 where words like '%(%' and  words like '%)%'
--insert into Chinese_words select * from Chinese_words2;
--drop table Chinese_words2
/*   []   的处理过程*/
--update Chinese_words set pic_exist = 0.12 where words like '%]%'
--select * from Chinese_words where pic_exist = 0.12
--select * into Chinese_words2 from Chinese_words where pic_exist = 0.12
--update Chinese_words2 set words = stuff(words,charindex('[',words),charindex(']',words)-charindex(']',words)+1,'') ,pic_exist = 1.12 where 1=1
--防止遗漏符号[]
--use [index_trademark_wn]
--update Chinese_words2 set words = replace(words,']','');
--insert into Chinese_words select * from Chinese_words2;
--drop table Chinese_words2
--select * from Chinese_words where pic_exist = 1.12
--select * from Chinese_words where id = 14481
/*   {}   的处理过程*/

--update Chinese_words set pic_exist = 0.13 where words like '%{%' and  words like '%}%'
--select * into Chinese_words2 from Chinese_words where pic_exist = 0.13
--select * from Chinese_words where pic_exist =0.13		--查询0.13的结果
--update Chinese_words2 set words = stuff(words,charindex('{',words),charindex('}',words)-charindex('{',words)+1,'') ,pic_exist = 1.13 where 1=1
--update Chinese_words2 set words = stuff(words,charindex('{',words),charindex('}',words)-charindex('{',words)+1,'') ,pic_exist = 1.13 where words like '%}%'
--insert into Chinese_words select * from Chinese_words2;
--drop table Chinese_words2
--select * from Chinese_words where pic_exist = 0.13 or pic_exist = 1.13		--查询0.13的结果

--（2）拆分规则：		诗句拆分，双空格分割，原始数据标记为：0.2		拆分后不存在字符,标记为：1.2
--select * from Chinese_words where words like '%,%'and pic_exist is null		--查询0.13的结果
--select * from Chinese_words where id = 30214		--查询0.13的结果
--update Chinese_words set pic_exist = 0.2 where words like '%,%'		--1651 行
--select * into Chinese_words2 from Chinese_words where pic_exist = 0.2
--select * from Chinese_words where pic_exist =0.2		--查询Chinese_words中0.2的结果
--update Chinese_words2 set words = replace(words,',','  ') ,pic_exist = 1.2
--select * from Chinese_words2		--查询Chinese_words中1.2的结果
--insert into Chinese_words select * from Chinese_words2;
--drop table Chinese_words2
--select * from Chinese_words where pic_exist = 0.2 or pic_exist = 1.2 order by cast(id as int)		--查询0.13的结果
--（3）存在	？ “	 的进行标记：0.3，不进行拆分处理
--update Chinese_words set pic_exist = 0.3 where words like '%?%' and pic_exist is null 
--select * from Chinese_words where words like '%?%' and pic_exist = 0.3 order by cast(id as int)
--update Chinese_words set pic_exist = 0.3 where words like '%“%' and pic_exist is null 
--select * from Chinese_words where words like '%“%'and pic_exist = 0.3  order by cast(id as int)--7行
--（4）纯英文，例【ＣＤ－ＲＯＭ  ＭＰ３  钴60】 直接标记为：0.4
	--<1>【ＣＤ－Ｒ Ｅ－ｍａｉｌ  ｈｉ－ｆｉ     】标记为0.41
--select * from Chinese_words where pic_exist is null and PATINDEX('%[a-z]%',rtrim(words))!=0 and PATINDEX('%[^a-z]%',rtrim(words))!=0 and words like '%-%'order by cast(id as int)
--update Chinese_words set pic_exist = 0.41 where pic_exist is null and PATINDEX('%[a-z]%',rtrim(words))!=0 and PATINDEX('%[^a-z]%',rtrim(words))!=0 and words like '%-%'
--select * from Chinese_words where pic_exist = 0.41 and PATINDEX('%[a-z]%',rtrim(words))!=0 and PATINDEX('%[^a-z]%',rtrim(words))!=0 and words like '%-%'order by cast(id as int)
	--<2>包含中文的英文【ＡＴＭ机  Ｂ超  Ｂ细胞  ＭＰ３  】标记为1.41
--select * from Chinese_words where pic_exist is null and PATINDEX('%[a-z]%',rtrim(words))!=0 and PATINDEX('%[^a-z]%',rtrim(words))!=0 order by cast(id as int)
--update Chinese_words set pic_exist = 1.41 where pic_exist is null and PATINDEX('%[a-z]%',rtrim(words))!=0 and PATINDEX('%[^a-z]%',rtrim(words))!=0
--select * from Chinese_words where pic_exist = 1.41

--（5）拆分与舍弃规则： <1>-<5>  进行删除分隔符处理，原数据标记为：0.5，分割后数据标记为：1.5
--select * from Chinese_words where PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))!=0 and pic_exist is null --and PATINDEX('%[a-z]%',rtrim(words))!=0 order by cast(id as int)--376878行未标记
	--<1>不同于逗号的符号	﹐   处理前标记为：0.51		处理后标记为：1.51     例【波未平﹐一波又起】
	--select * from Chinese_words where  words like '%﹐%' and  pic_exist is null
	--update Chinese_words set pic_exist = 0.51 where words like '%﹐%' and  pic_exist is null
	--select * into Chinese_words2 from Chinese_words where pic_exist = 0.51
	--select * from Chinese_words where pic_exist =0.51		--查询Chinese_words中0.51的结果
	--update Chinese_words2 set words = replace(words,'﹐','  ') ,pic_exist = 1.51
	--select * from Chinese_words2		--查询Chinese_words中1.51的结果
	--insert into Chinese_words select * from Chinese_words2;
	--drop table Chinese_words2
	--select * from Chinese_words where pic_exist =0.51 or pic_exist = 1.51 order by cast(id as int)
	--<2>不同于逗号的符号	﹐   处理前标记为：0.52		处理后标记为：1.52     例【鲍里斯·戈东诺夫   三吏、三别  】--39行数据
	--select * from Chinese_words where words like '%·%' or words like '%、%' and  pic_exist is null
	--update Chinese_words set pic_exist = 0.52 where words like '%·%' or words like '%、%' and  pic_exist is null
	--select * into Chinese_words2 from Chinese_words where pic_exist = 0.52
	--select * from Chinese_words where pic_exist =0.52		--查询Chinese_words中0.52的结果
	--update Chinese_words2 set words = replace(words,'·','  '),pic_exist = 1.52
	--update Chinese_words2 set words = replace(words,'、','  '),pic_exist = 1.52
	--select * from Chinese_words2		--查询Chinese_words中1.51的结果
	--insert into Chinese_words select * from Chinese_words2;
	--drop table Chinese_words2
	--select * from Chinese_words where pic_exist =0.52 or pic_exist =1.52 order by cast(id as int)
	--<3>符号	…  --  -  直接舍去，标记为：0.53		   例【半…不…  大堰河--我的保姆  克-厘米】  --16行数据	                         
	--select * from Chinese_words where words like '%--%' or words like '%…%' or words like '%-%' and  pic_exist is null
	--update Chinese_words set pic_exist = 0.53 where words like '%--%' or words like '%…%' or words like '%-%' and  pic_exist is null
	--select * from Chinese_words where pic_exist = 0.53 order by cast(id as int)

	--<4>特殊数据的处理       标记为：0.54   标记为：1.54  例【胡子传﹑柳隆卿	吨—公里	班固《两都》	俄国一九○五年革命		克/升浓度	騃汉! 】  --6行数据                                      
	--select * from Chinese_words where (words like '%﹑%' or words like '%—%' or words like '%》%' or words like '%○%'or words like '%/%')and pic_exist is null
	--update Chinese_words set pic_exist = 0.54 where (words like '%﹑%' or words like '%—%' or words like '%》%' or words like '%○%'or words like '%/%')and pic_exist is null
	--select * from Chinese_words where words like '%!%' and pic_exist is null
	--update Chinese_words set words = replace(words,'!','') ,pic_exist = 1.54 where words like '%!%' and pic_exist is null
	--select * from Chinese_words where pic_exist = 0.54 or pic_exist =1.54
	--<5>特殊数据的处理		【id为：92738	137700	178462】标记为：0.55	【	曝光表)	】   标记为：1.55         --4行数据                                   
	--select * from Chinese_words where id = 92738 or id = 137700 or id = 178462
	--update Chinese_words set pic_exist = 0.55 where id = 92738 or id = 137700 or id = 178462
	--select * from Chinese_words where words = '曝光表)'
	--update Chinese_words set pic_exist = 1.55 ,words = replace(words,')','') where words = '曝光表)'
	--select * from Chinese_words where pic_exist = 1.55
--（6）希腊字母，直接标记为：1.6   例【α粒子	α射线	β粒子	β射线	γ刀  γ射线】id区间为：[3535,3540]	--6行数据    
	--select * from Chinese_words where id >= 3535 and id <= 3540
	--update Chinese_words set pic_exist = 1.6 where id >= 3535 and id <= 3540
	--select * from Chinese_words where pic_exist = 1.6
--（7）完全包含英语单词的处理	例【ＴＭＤ	ＴＶ	ＵＦＯ	ＶＣＤ】 直接舍弃，标记为0.7	--98行数据
--SELECT [id],[words],PATINDEX('%[a-z]%',rtrim([words])),[ChineseSpell],[FirstSpell],pic_exist FROM [Chinese_words] where PATINDEX('%[a-z]%',rtrim([words]))!=0 and pic_exist is null order by cast(id as int)
--update Chinese_words set pic_exist = 0.7 where PATINDEX('%[a-z]%',rtrim([words]))!=0 and pic_exist is null
--select * from Chinese_words where pic_exist = 0.7
--（8）检查测试
	--输出即将转换为图片的字段
	--select * from Chinese_words FLOOR where FLOOR(pic_exist) = 1 or pic_exist is null order by cast(pic_exist as float) --where pic_exist is null or pic_exist = 1 
	--存入新的表Chinese_words_new
	--select * into Chinese_words_new from Chinese_words where pic_exist is null or floor(pic_exist)=1 order by cast(pic_exist as float)
	--select * from Chinese_words_new order by cast(id as int)
	--select * from Chinese_words_new order by cast(pic_exist as float)

	--<1>判断是否存在数字、字母、是否不存在汉字
	--select * from Chinese_words_new where words
--查询所有的特殊字符串
 -- SELECT [id]
 --     ,[words]
	--  ,PATINDEX('%[0-9]%',rtrim([words]))--判断是否存在数字
	--  ,PATINDEX('%[a-z]%',rtrim([words]))--判断是否存在字母
	--  ,PATINDEX('%[吖-座]%',rtrim([words]))--判断不存在汉字
 --     ,[ChineseSpell]
 --     ,[FirstSpell]
	--  ,pic_exist
 -- FROM Chinese_words_new
 -- where PATINDEX('%[吖-座]%',rtrim([words]))=0 or PATINDEX('%[a-z]%',rtrim([words]))!=0 or PATINDEX('%[a-z]%',rtrim([words]))!=0  --and PATINDEX('%[a-z]%',rtrim(words))!=0
 --order by cast(id as int)

 select * from Chinese_words_new  where pic_exist is not null order by cast(pic_exist as float)