use [Index_TradeMark_bf]
--��ѯ���е������ַ���
  SELECT [id]
      ,[words]
      ,[ChineseSpell],PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))
      ,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].[Chinese_words]
  where PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))!=0 --or words like '%(%'
 order by cast(id as int)


SELECT [id]
      ,[words],PATINDEX('%[^߹-��]%',rtrim([ChineseSpell]))
      ,[ChineseSpell]
      ,[FirstSpell]
  FROM [Index_TradeMark_wn].[dbo].[Chinese_words]
  where PATINDEX('%[^߹-��]%',rtrim([words]))!=0 --or words like '%(%'
 order by cast(id as int)
