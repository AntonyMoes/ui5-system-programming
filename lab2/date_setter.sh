#!/bin/bash
OPTION=0
q=0

while [[ "$OPTION" -ne 5 ]]; do
    clear

    echo 1. Установить дату 2019-01-01
    echo 2. Установить дату 2000-10-20
    echo 3. Вернуть введенную дату и время
    echo 4. Справка
    echo 5. Выход
    
    # Запрос нажатия клавиши
    echo Введите номер пункта меню:
    read OPTION

    # Ветвление
    case $OPTION in
        1)
            date -s "2019-01-01" > /dev/null
            date
            read q
        ;;
        2)
            date -s "2000-10-20" > /dev/null
            date
            read q
        ;;
        3)
            date -s "$3"  > /dev/null
            date
            read q
        ;;
        4)
            ./$1
            read q
        ;;
        5)
            if [[ "$2" == "yes" ]]; then 
                ./$1 
            fi
            echo "Завершение программы"
            read q
        ;;
        *)
        echo "Введите цифру 1-5"
        ;;
    esac
done

clear

