﻿
#language: ru

@tree
@SmokeTest

Функциональность: Дымовые тесты - Справочники - Копирование
# Конфигурация: Загрузка стандартов 1С
# Версия: 1.0

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И Я закрыл все окна клиентского приложения

Сценарий: Копирование элемента группы справочника "Стандарты разработки" (СтандартыРазработки)

	* Ищем ссылку на существующий элемент
		И я выполняю код встроенного языка на сервере
		"""bsl
			Объект.ЗначениеНаСервере = НЕОПРЕДЕЛЕНО;
			Запрос = Новый Запрос(
				"ВЫБРАТЬ ПЕРВЫЕ 1
				|	ТекДанныеИсточник.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.СтандартыРазработки КАК ТекДанныеИсточник
				|ГДЕ
				|	НЕ ТекДанныеИсточник.ПометкаУдаления
				|	И НЕ ТекДанныеИсточник.Предопределенный И ТекДанныеИсточник.ЭтоГруппа");
			ВыборкаЗапроса = Запрос.Выполнить().Выбрать();
			Если ВыборкаЗапроса.Следующий() Тогда
				Объект.ЗначениеНаСервере = ПолучитьНавигационнуюСсылку(ВыборкаЗапроса.Ссылка);
			КонецЕсли;
		"""
		И Я запоминаю значение выражения 'Объект.ЗначениеНаСервере' в переменную 'НавигационнаяСсылка'

	Если 'ЗначениеЗаполнено($НавигационнаяСсылка$)' Тогда

		* Отрываем форму существующего элемента
			И Я открываю навигационную ссылку '$НавигационнаяСсылка$'
			Если появилось предупреждение Тогда
				Тогда я вызываю исключение "Не удалось открыть существующий элемент группы справочника СтандартыРазработки"
			Если имя текущей формы "ErrorWindow" Тогда
				Тогда я вызываю исключение "Не удалось открыть существующий элемент группы справочника СтандартыРазработки"
			И я запоминаю заголовок формы в переменную 'ЗаголовокФормы'

		* Создаем новый элемент копированием
			Когда открылось окно '$ЗаголовокФормы$'
			Если элемент формы с именем 'ФормаСкопировать' присутствует на форме Тогда
				И я нажимаю на кнопку с именем 'ФормаСкопировать'
				Если появилось предупреждение Тогда
					Тогда я вызываю исключение "Не удалось скопировать существующий элемент группы справочника СтандартыРазработки"
				Если имя текущей формы "ErrorWindow" Тогда
					Тогда я вызываю исключение "Не удалось скопировать существующий элемент группы справочника СтандартыРазработки"
				И я запоминаю заголовок формы в переменную 'ЗаголовокФормы'

		* Записываем новый элемент
			Когда открылось окно '$ЗаголовокФормы$'
			Если элемент формы с именем 'ФормаЗаписать' присутствует на форме Тогда
				И я нажимаю на кнопку с именем 'ФормаЗаписать'
				Если появилось предупреждение Тогда
					Тогда я вызываю исключение "Не удалось записать новый элемент группы справочника СтандартыРазработки"
				Если имя текущей формы "ErrorWindow" Тогда
					Тогда я вызываю исключение "Не удалось записать новый элемент группы справочника СтандартыРазработки"

Сценарий: Копирование элемента справочника "Стандарты разработки" (СтандартыРазработки)

	* Ищем ссылку на существующий элемент
		И я выполняю код встроенного языка на сервере
		"""bsl
			Объект.ЗначениеНаСервере = НЕОПРЕДЕЛЕНО;
			Запрос = Новый Запрос(
				"ВЫБРАТЬ ПЕРВЫЕ 1
				|	ТекДанныеИсточник.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.СтандартыРазработки КАК ТекДанныеИсточник
				|ГДЕ
				|	НЕ ТекДанныеИсточник.ПометкаУдаления
				|	И НЕ ТекДанныеИсточник.Предопределенный И НЕ ТекДанныеИсточник.ЭтоГруппа");
			ВыборкаЗапроса = Запрос.Выполнить().Выбрать();
			Если ВыборкаЗапроса.Следующий() Тогда
				Объект.ЗначениеНаСервере = ПолучитьНавигационнуюСсылку(ВыборкаЗапроса.Ссылка);
			КонецЕсли;
		"""
		И Я запоминаю значение выражения 'Объект.ЗначениеНаСервере' в переменную 'НавигационнаяСсылка'

	Если 'ЗначениеЗаполнено($НавигационнаяСсылка$)' Тогда

		* Отрываем форму существующего элемента
			И Я открываю навигационную ссылку '$НавигационнаяСсылка$'
			Если появилось предупреждение Тогда
				Тогда я вызываю исключение "Не удалось открыть существующий элемент справочника СтандартыРазработки"
			Если имя текущей формы "ErrorWindow" Тогда
				Тогда я вызываю исключение "Не удалось открыть существующий элемент справочника СтандартыРазработки"
			И я запоминаю заголовок формы в переменную 'ЗаголовокФормы'

		* Создаем новый элемент копированием
			Когда открылось окно '$ЗаголовокФормы$'
			Если элемент формы с именем 'ФормаСкопировать' присутствует на форме Тогда
				И я нажимаю на кнопку с именем 'ФормаСкопировать'
				Если появилось предупреждение Тогда
					Тогда я вызываю исключение "Не удалось скопировать существующий элемент справочника СтандартыРазработки"
				Если имя текущей формы "ErrorWindow" Тогда
					Тогда я вызываю исключение "Не удалось скопировать существующий элемент справочника СтандартыРазработки"
				И я запоминаю заголовок формы в переменную 'ЗаголовокФормы'

		* Записываем новый элемент
			Когда открылось окно '$ЗаголовокФормы$'
			Если элемент формы с именем 'ФормаЗаписать' присутствует на форме Тогда
				И я нажимаю на кнопку с именем 'ФормаЗаписать'
				Если появилось предупреждение Тогда
					Тогда я вызываю исключение "Не удалось записать новый элемент справочника СтандартыРазработки"
				Если имя текущей формы "ErrorWindow" Тогда
					Тогда я вызываю исключение "Не удалось записать новый элемент справочника СтандартыРазработки"
