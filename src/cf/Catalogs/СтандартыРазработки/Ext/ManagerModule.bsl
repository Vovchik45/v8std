﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Получает стандарты в виде дерева
Функция ДеревоСтандартов() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СтандартыРазработки.Ссылка КАК Ссылка,
	|	СтандартыРазработки.Наименование КАК Наименование,
	|	СтандартыРазработки.КодСтандарта КАК КодСтандарта,
	|	СтандартыРазработки.СсылкаНаСтандарт КАК СсылкаНаСтандарт,
	|	СтандартыРазработки.СодержаниеСтандартаHTML КАК СодержаниеСтандартаHTML,
	|	СтандартыРазработки.НеИспользуется КАК НеИспользуется
	|ИЗ
	|	Справочник.СтандартыРазработки КАК СтандартыРазработки
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка ИЕРАРХИЯ,
	|	СтандартыРазработки.Код";
	Дерево = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	Возврат Дерево;
	
КонецФункции

Функция СодержаниеСтандартаHTML(СсылкаНаСтандарт) Экспорт
	
	Возврат СсылкаНаСтандарт.СодержаниеСтандартаHTML;
	
КонецФункции

// Конвертирует HTML-содержимое стандарта в PDF в виде двоичных данных c помощью wkhtmltopdf
//
// Параметры:
//  СсылкаНаСтандарт  - СправочникСсылка.СтандартыРазработки
//
// Возвращаемое значение:
//   ДвоичныеДанные   - PDF
//
Функция СодержимоеСтандартаВPDFДвоичныеДанные(СсылкаНаСтандарт) Экспорт
	
	СодержаниеСтандартаХТМЛ = СодержаниеСтандартаHTML(СсылкаНаСтандарт);
	ЗаменитьСсылкиНаАбсолютные(СодержаниеСтандартаХТМЛ);
	
	Возврат РаботаСPDF.КонвертироватьHTMLвPDF(СодержаниеСтандартаХТМЛ, "ДвоичныеДанные");
	
КонецФункции

// Конвертирует HTML-содержимое стандарта в PDF в виде файла c помощью wkhtmltopdf
//
// Параметры:
//  СсылкаНаСтандарт  - СправочникСсылка.СтандартыРазработки
//
// Возвращаемое значение:
//   ДвоичныеДанные   - PDF
//
Функция СодержимоеСтандартаВPDF(СсылкаНаСтандарт) Экспорт
	
	СодержаниеСтандартаХТМЛ = СодержаниеСтандартаHTML(СсылкаНаСтандарт);
	ЗаменитьСсылкиНаАбсолютные(СодержаниеСтандартаХТМЛ);
	
	Возврат РаботаСPDF.КонвертироватьHTMLвPDF(СодержаниеСтандартаХТМЛ, "ПутьКФайлу");
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаменитьСсылкиНаАбсолютные(СодержаниеСтандартаХТМЛ)
	
	РегулярноеВыражение = "href=\""\/db\/v8std\/content\/\d+\/hdoc\""";
	ОтносительныеСсылки = СтрНайтиВсеПоРегулярномуВыражению(СодержаниеСтандартаХТМЛ, РегулярноеВыражение, Истина);
	
	Для Каждого НайденнаяСсылка Из ОтносительныеСсылки Цикл
		ОтносительнаяСсылка = НайденнаяСсылка.Значение;
		АбсолютнаяСсылка = СтрЗаменить(ОтносительнаяСсылка, "/db/v8std/content/", "https://its.1c.ru/db/v8std/content/");
		СодержаниеСтандартаХТМЛ = СтрЗаменить(СодержаниеСтандартаХТМЛ, ОтносительнаяСсылка, АбсолютнаяСсылка);
	КонецЦикла;
	
КонецПроцедуры

Функция СтандартПоСсылкеИТС(СсылкаНаСтандартИТС) Экспорт
	
	Результат = Справочники.СтандартыРазработки.ПустаяСсылка();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СтандартыРазработки.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.СтандартыРазработки КАК СтандартыРазработки
	|ГДЕ
	|	СтандартыРазработки.СсылкаНаСтандарт = &СсылкаНаСтандарт";
	Запрос.УстановитьПараметр("СсылкаНаСтандарт", СсылкаНаСтандартИТС);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли
