use [Index_TradeMark_wn]
--��ѯ���е������ַ���
  SELECT [id]
      ,[words]
      ,[ChineseSpell],PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))
      ,[FirstSpell]
	  ,pic_exist
  FROM [Chinese_words]
  where PATINDEX('%[^a-z]%',rtrim([ChineseSpell]))!=0 and pic_exist is null --and PATINDEX('%[a-z]%',rtrim(words))!=0
 order by cast(id as int)


SELECT [id]
      ,[words],PATINDEX('%[^߹-��]%',rtrim([ChineseSpell]))
      ,[ChineseSpell]
      ,[FirstSpell]
  FROM [Chinese_words]
  where PATINDEX('%[^߹-��]%',rtrim([words]))!=0 and pic_exist is null
 order by cast(id as int)
