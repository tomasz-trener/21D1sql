
use System_Skoczkowie
-- str 4 

select * from zawodnicy

select * from trenerzy 


select kraj, imie, nazwisko, wzrost +5 as nowyWzrost from zawodnicy
select kraj, imie, nazwisko, wzrost +5 as [nowy Wzrost] from zawodnicy
select kraj, imie, nazwisko, wzrost +5 [nowy Wzrost] from zawodnicy


select imie, nazwisko, (wzrost*2)/3 
from zawodnicy 

-- str 6 cw 1-2 

-- 1 
select imie, nazwisko , wzrost*1.46 [max d³ugoœæ nart] 
from zawodnicy 

--2 
select imie , nazwisko , waga/(wzrost/100.0 * (1.0*wzrost/100)) bmi 
from zawodnicy 

select imie , nazwisko , waga/(wzrost/100.0 * (1.0*wzrost/100)) bmi 
from zawodnicy 

select 2^3

select 10/3
select imie, wzrost, wzrost/100 from zawodnicy 

select imie, nazwisko , kraj, data_ur, wzrost
from zawodnicy

-- kolejnoœæ tworzenia zapytania: 
-- najpierw select potem from [Ÿród³o] na koñæu podajemy kolumny 

-- operator bitowy XOR 
select 0^0, 0^1, 1^0, 1^1

-- cw 3 

select distinct imie
from zawodnicy

select distinct kraj from zawodnicy

-- przetwarzanie liczb, tekstu oraz dat 

-- przetwarzanie liczb: 

-- funkcje 
-- potêgowanie , zaokr¹ganie... str 10 

select power(2,3)

select imie, nazwisko, waga/power(wzrost/100.0,2)
from zawodnicy

select imie, nazwisko, round(waga/power(wzrost/100.0,2),2)
from zawodnicy

select imie, nazwisko, format(waga/power(wzrost/100.0,2),'00.00')
from zawodnicy

-- inne funkcje matematyczne

select abs(-5), ceiling(2.3), floor(2.7), power(2,3), sqrt(9), sign(-4), sign(5), sign(0)

-- funkcje tekstowe str 14 

select len('ala ma kota'), -- dlugosc napisu 
        upper('ala ma kota'),
		charindex('ma','ala ma kota'),
		--				12345
		left('ala ma kota',3),
		right('ala ma kota',4),
		ltrim('    ala ma kota'),
		rtrim('ala ma kota      '),
		replace('ala ma kota', 'ma','bedzie miala'),
		substring('ala ma kota',5,2)
		       --  12345

select 'ala' + 'ma' + 'kota'

select 'hej ' + imie from zawodnicy

-- str 14 zad 1-4 


-- 1 
select imie + ' ' + 
	upper(left(nazwisko,1)) + -- pierwszy znak
	lower(right(nazwisko,len(nazwisko)-1)) -- pozostale
from zawodnicy

-- 2 

select imie + ' ' + upper(left(nazwisko,1)) + lower(right(nazwisko,len(nazwisko)-1))+ ' (' + kraj + ')' 
from zawodnicy

--3 

select imie + ' ' + left(nazwisko,1)+ '.'
from zawodnicy
 
 -- 4

 select imie + ' ' + nazwisko + ' wa¿y ' + format(waga,'0.0') + ' kg' 
 from zawodnicy

 select imie + ' ' + nazwisko + ' wa¿y ' + convert(varchar, waga) + ' kg' 
 from zawodnicy

 -- efektem dodatkowym ltrim jest konwersja 
 select imie + ' ' + nazwisko + ' wa¿y ' + ltrim(waga) + ' kg' 
 from zawodnicy
 
 select 'x'+ format(4,'0')

 select convert(int, '4')+6
 select convert(varchar, 10.0/3)+'6'
 select str(4)
 select cast(4 as varchar)


 -- wypisz wszystkich zawodnikow ale tak, ze 
 --- zamien literke 'a' na 'e', natomiast 'e' zamien na 'a' w nazwiskach 
 
 select  replace(replace(replace(nazwisko, 'a','#'),'e','a'),'#','e')
 from zawodnicy 

 -- od wersji ms sql 2017 jest dostepna funkcja translate 
 select TRANSLATE(nazwisko, 'ae','ea')
 from zawodnicy

 -- funkcje przetwarzaj¹ce daty 

 select GETDATE(),
		DATEFROMPARTS(2023,04,19),
		dateadd(m,2,getdate()),
		dateadd(d,2,getdate()),
		day(getdate()),
		month(getdate()),
		year(getdate()),
		DATEDIFF(d, getdate(), datefromparts(2023,12,31))

-- 1) podaj wiek zawodników

select imie, nazwisko , year(getdate()) - year(data_ur) wiek1, 
					  datediff(year, data_ur,getdate()) wiek2
from zawodnicy
-- 2) dla kazdego zawodnika podaj date ich urodzin w aktualnym roku

 select imie, nazwisko, 

	DATEFROMPARTS(
		year(getdate()),
	    month(data_ur),
		day(data_ur)) [data urodzin]

 from zawodnicy
 
  -- 3) podaj ile dni ma miesiac w którym dany zawodnik siê urodzi³

					--  + 1 miesiac   -1 dzien   wybraæ dzien
--  19.04.2023 -> 1.04.2023 -> 1.05.2023 --> 30.04.2023 -> 30

select imie, nazwisko, data_ur,
	day(
		dateadd(d,-1,
			dateadd(m,1,
				datefromparts(year(data_ur),month(data_ur),1))))
	[liczba dni w miesiacu]
from zawodnicy

-- eomonth - na podstawie daty- tworzy now¹ datê z ostatnim dniem miesiaca 
select imie, nazwisko, data_ur, day(EOMONTH(data_ur)) from zawodnicy

  -- 4) podaj kiedy s¹ najbli¿sze urodziny zawodnika wraz z podaniem za ile 
        -- dni one bed¹ 

-- jezeli zawodnik mial urodziny w tym roku to do daty 
-- urodzin dodajemy 1 
-- jezeli nie mial to do daty dodajemy 0 

-- jak sprawdzic czy mial urodziny ? 
-- odp: sprawdz roznice w dniach pomiedzy dzisiejsza data a dat¹ jego urodzin 
-- je¿eli ró¿nica jest dodatnia to wtedy dodajemy 1 a wpp. dodajemy 0 

select imie, nazwisko, data_ur, 

	DATEFROMPARTS(
		year(getdate()) +
			(sign(
				datediff(d,
						DATEFROMPARTS(
							year(getdate()),month(data_ur), day(data_ur)),
						getdate()))+1)/2	
		,
	    month(data_ur),
		day(data_ur)) [data urodzin]
 from zawodnicy




 -- przekszta³cenie liczby dodaniej na 1 i liczby ujemnej na 0 
 select (sign(5)+1)/2, (sign(-5)+1)/2


 -- poznaliœmy 3 rodzaje funkcji : matematyczne, tekstowe, datowe 


 select * from zawodnicy

 -- filtrowanie danych
 
 select imie, nazwisko, kraj='pol' from zawodnicy

  select imie, nazwisko, 'pol' kraj from zawodnicy


  select *
  from zawodnicy
  where kraj = 'pol' and wzrost >= 180

  -- wypisz tylko tych, którch wzrost jest pomiedzy 60 a 175 

  select *
  from zawodnicy
  where wzrost >= 60 and wzrost <=175

  -- w sekcji where mozemy korzysyac ze wszystkich funkcji , które poznalismy do tej pory 
  select * from zawodnicy
  where power(wzrost,2) > 1000

  --str 20 

  -- 2 
  select imie, nazwisko
  from zawodnicy 
  where kraj = 'ger' or kraj = 'aut'

  --3 

  select *, waga/power(wzrost/100.0,2) bmi
  from zawodnicy
  where waga/power(wzrost/100.0,2) < 20

  --4 

  select imie, nazwisko
  from zawodnicy
  where DATEADD(year,40,data_ur) < GETDATE()

  -- 5 
  select *
  from zawodnicy 
  where LEN(imie) =4

  --6
  select *
  from trenerzy
  where data_ur_t is null

  -- jak porównujemy cokolwiek do null to nie mozemy uzywac operatora =, <,>, <> 
  -- jedyna porównanie mozliwe jest przy uzyciu is albo is not
  
  --7 
  select *
  from zawodnicy
  where MONTH(data_ur) >= 11 or MONTH(data_ur)<=3

  select *
  from zawodnicy
  where MONTH(data_ur) > 10 or MONTH(data_ur)<4


  select *
  from zawodnicy
  where MONTH(data_ur) not between 4 and 10

  select *
  from zawodnicy
  where MONTH(data_ur) in (11,12,1,2,3)

  -- 8 

  select *
  from zawodnicy
  where CHARINDEX('n',nazwisko)>0
       or charindex('w', nazwisko)>0


  -- like 

  select * from zawodnicy
  where nazwisko like '%w%' or nazwisko like '%n%'

  select * from zawodnicy
  where imie like 'Mar_in'

  select * from zawodnicy
  where imie like 'Mar[tcw]in'

  select * from zawodnicy
  where imie like 'Mar[^tw]in'

  select * from zawodnicy
  where nazwisko like '%[nw]%'

  -- co do tej pory potrafimy 

  --1) SELECT do wybierania (wyswietlania kolumn) i ew. przetwarzania
  --2) WHERE do filtrowania danych czyli co wyswietlaæ (jakie rekordy) 
  
  -- teraz poznamy 
  --3) ORDER BY sortowanie 


  select *
  from zawodnicy
  order by wzrost


  select *
  from zawodnicy
  order by id_zawodnika desc

  select *
  from zawodnicy
  order by kraj, wzrost

  select *
  from zawodnicy
  order by waga/2

  -- posortuj zawodnikow po BMI 

  select *, waga/power(wzrost/100.0,2) bmi
  from zawodnicy
  where waga/power(wzrost/100.0,2) < 20
  order by bmi

 -- aliasy zdefiniowane w sekcji select 
-- nie sa dostepne w sekcji where 
-- ale sa dostepne w sekcji order by 

-- kolejnosc intrepertacji silnika bazodanowego 
-- 1) from
-- 2) where 
-- 3) select
-- 4) order by 

-- kolejnosc tworzenia zapytania 
-- 1) select
-- 2) from 
-- 3) where
-- 4) order by 


-- str 25 

 -- 1 
 select *
 from zawodnicy
 order by wzrost , id_zawodnika

 -- 2

 select * from zawodnicy order by kraj

 --3 
  select * from zawodnicy order by data_ur desc

  --4 

  select imie + ' ' + nazwisko + ' (' + kraj + ')' 
  from zawodnicy
  order by 1

  select imie, nazwisko from zawodnicy order by 2

  --5 
  select * from trenerzy order by data_ur_t

  --6 

  SELECT imie, nazwisko, waga/power(wzrost/100.0,2) bmi, sign(waga/power(wzrost/100.0,2)-20)
  from zawodnicy
  order by sign(waga/power(wzrost/100.0,2)-20), nazwisko


  --7 
  select imie, nazwisko, NEWID()
  from zawodnicy
  order by NEWID()


  -- jezeli ktos ma wzrost < 170 to niski wpp. wysoki 

  select imie, nazwisko, iif(wzrost<170, 'niski','wysoki')
  from zawodnicy

  select imie, nazwisko, iif(waga/power(wzrost/100.0,2)<20, 'kat 1','kat 2')
  from zawodnicy

  select imie, nazwisko, iif(waga/power(wzrost/100.0,2)<20, 'kat 1','kat 2')
  from zawodnicy
  order by iif(waga/power(wzrost/100.0,2)<20, 'kat 1','kat 2')


  -- ponizej 170 niski, od 170 do 180 sredni , powyzej 180 wysoki 

  select imie, nazwisko, 
	iif(wzrost < 170,'niski',
		iif(wzrost>180,'wysoki','sredni'))
  from zawodnicy

  select imie, nazwisko,

	case
		when wzrost< 170 then 'niski'
		when wzrost > 185 then 'bardzo wysoki'
		when wzrost > 180 then 'wysoki' 
		--else 'sredni'
	end

  from zawodnicy


  -- str 24  ...
  -- 2 
  


  select imie_t, nazwisko_t, iif(data_ur_t is null,'nieznana','znana')
  from trenerzy


  select imie_t, nazwisko_t, iif(data_ur_t is null,'nieznana',convert(varchar, data_ur_t))
  from trenerzy

   select imie_t, nazwisko_t, iif(data_ur_t is null,'nieznana',format(data_ur_t,'dd-MM-yyyy')),
		iif(data_ur_t is null,'nieznana',format(data_ur_t,'dd-MMMM-yy','pl'))
  from trenerzy

  -- 3 

   select imie, nazwisko, wzrost , iif(RIGHT(wzrost,1) in ('0','2','4','6','8'),'tak','nie')
  from zawodnicy

  select imie, nazwisko, wzrost , iif(wzrost % 2=0,'tak','nie') 
  from zawodnicy

 --4 

 select 

	case
		when kraj ='pol' then 'Pan '
		when kraj in ('ger','aut') then 'Herr '
		when kraj = 'usa' then 'Mr '
		else ''
	end + imie + ' ' + nazwisko

 from zawodnicy

 -- 5 

 select imie, nazwisko,

	iif(getdate() < datefromparts(year(getdate()),month(data_ur), day(data_ur)),
		'jeszcze nie', 'ju¿ mia³')
 from zawodnicy


 -- 

 select top 2 *
 from zawodnicy
 order by wzrost desc, waga

 select top 50 percent *
 from zawodnicy
 order by wzrost desc 


 select *
 from zawodnicy
 order by wzrost desc
 offset 3 row
 fetch next 4 row only 


 select *, iif(format(data_ur_t,'MMMM','pl') is null,'nieznana',format(data_ur_t,'MMMM','pl'))
 from trenerzy

  select *,  ISNULL(format(data_ur_t,'MMMM','pl'),'nieznana')
 from trenerzy

  select *,  ISNULL(data_ur_t,'nieznana')
 from trenerzy

