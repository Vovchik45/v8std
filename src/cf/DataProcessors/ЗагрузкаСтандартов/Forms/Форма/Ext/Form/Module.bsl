﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтотОбъект.АдресСтандартов = "https://its.1c.ru/db/v8std"; 

	ФункционалСППРДоступен = ФункционалСППРДоступен();
	
	Элементы.АктуализироватьСтандартыСППР.Видимость = ФункционалСППРДоступен;
	Элементы.ДеревоСтандартовОбработано.Видимость = ФункционалСППРДоступен;
	Элементы.ДеревоСтандартовГруппаСнятьУстановитьФлажки.Видимость = ФункционалСППРДоступен;
	Элементы.ТолькоСоздаватьНовые.Видимость = ФункционалСППРДоступен;
	
	МассивДобавляемыхРеквизитов = Новый Массив;  
	ТипРеквизита = Новый ОписаниеТипов("Строка");
	
	Если ФункционалСППРДоступен Тогда
		ТипРеквизита = Новый ОписаниеТипов("СправочникСсылка.СтандартыРазработки");
	КонецЕсли;
	
	НовыйРеквизит = Новый РеквизитФормы("Стандарт", ТипРеквизита, "ДеревоСтандартов");
	МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
	ИзменитьРеквизиты(МассивДобавляемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоСтандартов

&НаКлиенте
Процедура ДеревоСтандартовПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Адрес = "" Тогда
		Возврат;
	КонецЕсли;
	
	ЭтотОбъект.ДокументHTML = ТекущиеДанные.Адрес;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоСтандартовОбработаноПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ДеревоСтандартов.ТекущиеДанные;
	ИзменитьФлажки(ТекущиеДанные.ПолучитьЭлементы(), ТекущиеДанные.СтандартОбработан);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область ФункционалСППР

&НаКлиенте
Процедура АктуализироватьСтандартыСППР(Команда)
	АктуализироватьСтандартыСППРНаСервере();
КонецПроцедуры

#КонецОбласти

#Область АнализСтраниц

&НаКлиенте
Процедура Анализ(Команда)
	
	ДеревоСтандартов.ПолучитьЭлементы().Очистить();
	АнализНаСервере();
	РазвернутьВерхнийУровеньДерева();
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСДеревом

&НаКлиенте
Асинх Процедура СохранитьВФайл(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.Фильтр = "Текстовый файл (*.txt)|*.txt|Все файлы (*.*)|*.*";
	Диалог.МножественныйВыбор = Ложь;
	Диалог.ПолноеИмяФайла = "Стандарты";
	МассивВыбранныхФайлов = Ждать Диалог.ВыбратьАсинх();
	
	Если МассивВыбранныхФайлов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКФайлу = МассивВыбранныхФайлов[0];
	
	ДеревоСтрокой = ДеревоВТекст();
	
	Файл = Новый ТекстовыйДокумент;
	Файл.УстановитьТекст(ДеревоСтрокой);
	Файл.ЗаписатьАсинх(ПутьКФайлу);
	
КонецПроцедуры 

&НаКлиенте
Асинх Процедура ЗагрузитьИзФайла(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Фильтр = "Текстовый файл (*.txt)|*.txt|Все файлы (*.*)|*.*";
	Диалог.МножественныйВыбор = Ложь;
	Диалог.ПолноеИмяФайла = "Стандарты";
	МассивВыбранныхФайлов = Ждать Диалог.ВыбратьАсинх();
	
	Если МассивВыбранныхФайлов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКФайлу = МассивВыбранныхФайлов[0];
	
	ЧтениеТекста = Новый ЧтениеТекста(ПутьКФайлу);
	Текст = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	ТекстВДерево(Текст);
	РазвернутьВерхнийУровеньДерева();
	
КонецПроцедуры 

&НаКлиенте
Процедура УстановитьФлажки(Команда) 
	ИзменитьФлажки(ДеревоСтандартов.ПолучитьЭлементы(), Истина);
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	ИзменитьФлажки(ДеревоСтандартов.ПолучитьЭлементы(), Ложь);
КонецПроцедуры

#КонецОбласти

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

#Область ФункционалСППР

&НаСервере
Процедура АктуализироватьСтандартыСППРНаСервере()
	
	Дерево = РеквизитФормыВЗначение("ДеревоСтандартов");
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	МодульОбъекта.АктуализироватьСтандартыРекурсивно(Дерево, ТолькоСоздаватьНовые);
	
	ЗначениеВРеквизитФормы(Дерево, "ДеревоСтандартов");
	
КонецПроцедуры

&НаСервере
Функция ФункционалСППРДоступен()
	
	Если Метаданные.Справочники.Найти("СтандартыРазработки") = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат НЕ Метаданные.Справочники["СтандартыРазработки"].Реквизиты.Найти("СсылкаНаСтандарт") = Неопределено;
	
КонецФункции

#КонецОбласти

#Область АнализСтраниц

&НаСервере
Процедура АнализНаСервере()
	
	Дерево = РеквизитФормыВЗначение("ДеревоСтандартов"); 
	
	Если Дерево.Строки.Количество() = 0 Тогда
		НовСтрока = Дерево.Строки.Добавить();
		НовСтрока.Заголовок = "Стандарты ИТС";
		НовСтрока.Адрес = ЭтотОбъект.АдресСтандартов;
	КонецЕсли;
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	МодульОбъекта.АнализРекурсивно(НовСтрока);
	
	ЗначениеВРеквизитФормы(Дерево, "ДеревоСтандартов");
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСДеревом

&НаСервере
Функция ДеревоВТекст()
	
	Дерево = РеквизитФормыВЗначение("ДеревоСтандартов"); 
	Возврат ЗначениеВСтрокуВнутр(Дерево);
	
КонецФункции

&НаСервере
Процедура ТекстВДерево(Знач Текст)
	
	Дерево = ЗначениеИзСтрокиВнутр(Текст);
	
	Попытка
		ЗначениеВРеквизитФормы(Дерево, "ДеревоСтандартов");
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		ЗаписьЖурналаРегистрации("Ошибка разбора файла",
									УровеньЖурналаРегистрации.Ошибка, , , 
									ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		ВызватьИсключение ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
	КонецПопытки;
	
КонецПроцедуры 

&НаКлиенте
Процедура ИзменитьФлажки(Дерево, Флаг)
	Для Каждого ЭлементДерева Из Дерево Цикл
		ЭлементДерева.СтандартОбработан = Флаг;
		ИзменитьФлажки(ЭлементДерева.ПолучитьЭлементы(), Флаг);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьВерхнийУровеньДерева()
	
	Если Элементы.ДеревоСтандартов.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Элементы.ДеревоСтандартов.Развернуть(Элементы.ДеревоСтандартов.ТекущиеДанные.ПолучитьИдентификатор());
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти 
