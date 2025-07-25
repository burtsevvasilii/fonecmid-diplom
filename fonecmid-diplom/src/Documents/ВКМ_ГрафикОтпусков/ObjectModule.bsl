#Область ОбработчикиСобытий
Процедура ОбработкаПроведения(Отказ,Режим)

	Движения.ВКМ_ДниОтпуска.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	СУММА(ВКМ_ГрафикОтпусковОтпускаСотрудников.ДнейОтпуска) КАК ДнейОтпуска,
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник
	|ИЗ
	|	Документ.ВКМ_ГрафикОтпусков.ОтпускаСотрудников КАК ВКМ_ГрафикОтпусковОтпускаСотрудников
	|ГДЕ
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Ссылка = &Ссылка
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ВКМ_ДниОтпуска.Добавить();
		Движение.Период = Дата;
		Движение.Сотрудник = Выборка.Сотрудник;
		Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск;
		Движение.Дни = Выборка.ДнейОтпуска;
	КонецЦикла;

КонецПроцедуры
#КонецОбласти