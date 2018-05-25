use [Index_TradeMark_bf]
--查询所有的特殊字符串
  SELECT [id]
      ,[words]
      ,[ChineseSpell],PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))
      ,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].[Chinese_words]
  where PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))!=0 --or words like '%(%'
 order by cast(id as int)


SELECT [id]
      ,[words],PATINDEX('%[^吖-座]%',rtrim([ChineseSpell]))
      ,[ChineseSpell]
      ,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].[Chinese_words]
  where PATINDEX('%[^吖-座]%',rtrim([words]))!=0 --or words like '%(%'
 order by cast(id as int)
