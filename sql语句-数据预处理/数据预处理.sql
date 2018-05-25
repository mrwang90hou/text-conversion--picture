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
				 --（4）拆分规则： 例【 与…无宁  克/升浓度   欧·亨利 】     等分隔符，进行删除分隔符处理，原数据标记为：0.4，分割后数据标记为：1.4
				 --（5）纯英文，例【ＣＤ－ＲＯＭ  ＭＰ３  钴60】 直接标记为：0.5
				 --（6）希腊字母，例【β射线】直接标记为：1.6
				 --（7）    
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
--select * from Chinese_words where words like '%,%'		--查询0.13的结果
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



--（4）拆分规则： 例【 与…无宁  克/升浓度   欧·亨利 】     等分隔符，进行删除分隔符处理，原数据标记为：0.4，分割后数据标记为：1.4

--（5）纯英文，例【ＣＤ－ＲＯＭ  ＭＰ３  钴60】 直接标记为：0.5

--（6）希腊字母，例【β射线】直接标记为：1.6


--（7）