﻿#Область ПрограммныйИнтерфейс

// Конвертирует HTML в PDF с помощью wkhtmltopdf
//
// Параметры:
//  ВходящийHTML - Строка - Путь к файлу HTML
//               - Строка - Содержимое HTML-документа
//               - ДвоичныеДанные - HTML-файл в виде двоичных данных
//  ВыходнойФормат - Строка - в каком виде должен быть результат, ДвоичныеДанные или ПутьКФайлу или АдресВХ
//
Функция КонвертироватьHTMLвPDF(ВходящийHTML, ВыходнойФормат = "ДвоичныеДанные") Экспорт
	
	Приложение = Константы.ПутьКwkhtmltopdf.Получить();
	Если Не ЗначениеЗаполнено(Приложение) Тогда
		Приложение = УстановитьWkhtmltopdf();
	КонецЕсли;
	
	ТипВходящихДанных = ТипЗнч(ВходящийHTML);
	
	Если ТипВходящихДанных = Тип("ДвоичныеДанные") Тогда
		ИмяВремФайлаHTML = ПолучитьИмяВременногоФайла("html");
		ВходящийHTML.Записать(ИмяВремФайлаHTML);
		
	ИначеЕсли ТипВходящихДанных = Тип("Строка") Тогда
		ЭтоПутьКФайлу = Ложь;
		Попытка
			ВремФайл = Новый Файл(ВходящийHTML);
			Если ВремФайл.Существует() И ВремФайл.ЭтоФайл() Тогда
				ЭтоПутьКФайлу = Истина;
			КонецЕсли;
		Исключение
			ЭтоПутьКФайлу = Ложь;
		КонецПопытки;
			
		Если ЭтоПутьКФайлу Тогда
			ИмяВремФайлаHTML = ВходящийHTML;
			
		Иначе
			ИмяВремФайлаHTML = ПолучитьИмяВременногоФайла("html");
			ЗаписьТекста = Новый ЗаписьТекста(ИмяВремФайлаHTML, "utf-8");
			ЗаписьТекста.Записать(ВходящийHTML);
			ЗаписьТекста.Закрыть();
			
		КонецЕсли;
		
	КонецЕсли;
	
	ИмяВремФайлаPDF = ПолучитьИмяВременногоФайла("pdf");
	
	СтрокаЗапуска = СтрШаблон("%1 %2 %3", Приложение, ИмяВремФайлаHTML, ИмяВремФайлаPDF);
	КодВозврата = Неопределено;
	ЗапуститьПриложение(СтрокаЗапуска, , Истина, КодВозврата);
	
	Если Не (КодВозврата = 0 Или КодВозврата = 1) Тогда
		ВызватьИсключение СтрШаблон(НСтр("ru='Не удалось конвертировать в PDF, код ошибки: %1'"), КодВозврата);
	КонецЕсли;
	
	Если ВыходнойФормат = "ПутьКФайлу" Тогда
		Результат = ИмяВремФайлаPDF;
		
	ИначеЕсли ВыходнойФормат = "ДвоичныеДанные" Тогда
		Результат = Новый ДвоичныеДанные(ИмяВремФайлаPDF);
		
	ИначеЕсли ВыходнойФормат = "АдресВХ" Тогда
		ДвоичныеДанные = Новый ДвоичныеДанные(ИмяВремФайлаPDF);
		Результат = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
		
	Иначе
		ВызватьИсключение НСтр("ru='Неподдерживаемый выходной формат'");
		
	КонецЕсли;
		
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция УстановитьWkhtmltopdf()
	
	РабочийКаталог = КаталогВременныхФайлов();
	КаталогКомпоненты = "wkhtmltopdf";
	
	РазделительПути = ПолучитьРазделительПутиКлиента();
	Если Не СтрЗаканчиваетсяНа(РабочийКаталог, РазделительПути) Тогда
		РабочийКаталог = РабочийКаталог + РазделительПути;
	КонецЕсли;
	
	КаталогНаДиске = Новый Файл(РабочийКаталог + КаталогКомпоненты);
	
	Если НЕ КаталогНаДиске.Существует() Тогда
		
		Макет = ПолучитьОбщийМакет("wkhtmltopdf");
		Чтение = Новый ЧтениеДанных(Макет);
		Файл = Новый ЧтениеZipФайла(Чтение.ИсходныйПоток());
		Файл.ИзвлечьВсе(РабочийКаталог + КаталогКомпоненты);
		
	КонецЕсли;
	
	Возврат РабочийКаталог + КаталогКомпоненты + РазделительПути + "bin" + РазделительПути + "wkhtmltopdf.exe";
	
КонецФункции

#КонецОбласти
