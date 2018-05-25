
use index_trademark_bf
--update BG_gongGao set BGappPerson = stuff(BGappPerson,charindex('[',BGappPerson),charindex(']',BGappPerson)-charindex('[',BGappPerson)+1,'') where BGappPerson like '%[(]%' and BGappPerson like '%)%'

select * from Chinese_words where words like '%[(]%' and words like '%)%' order by cast(id as int)
select id,words = stuff(words,charindex('(',words),charindex(')',words)-charindex('(',words)+1,''),ChineseSpell,FirstSpell from Chinese_words where words like '%[(]%' and words like '%)%' order by cast(id as int)
--update BG_gongGao set BGappPerson = stuff(BGappPerson,charindex('[',BGappPerson),charindex(']',BGappPerson)-charindex('[',BGappPerson)+1,'') where BGappPerson like '%[(]%' and BGappPerson like '%)%'

