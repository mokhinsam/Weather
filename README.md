# Weather 

Weather — это приложение, разработанное с использованием UIKit, которое демонстрирует навыки разработки мобильных приложений. Приложение позволяет пользователям посмотреть прогноз погоды на ближайшие 24 часа и прогноз погоды на три дня. Погода запрашивается по месту локации пользователя или по названию локации через поиск. 


## 📌 Основные особенности
- Архитектура: **MVC**
- Используемые технологии: 
   - **UIKit, MapKit (MKLocalSearchCompleter), CoreLocation (CLLocationManager)**
   - **AutoLayout, NSLayoutConstraint, Storyboards, UINib**
   - **DispatchQueue, DispatchWorkItem, TimeInterval, Date, typealias, UIView.animate, Protocols, singletones, UIStoryboardSegue, CAGradientLayer**
   - **UITableView (UITableViewDelegate, UITableViewDataSource), UITableViewHeaderFooterView, UITableViewCell, UICollectionView, UICollectionViewCell, UISearchBarDelegate, UIAlertController, UIActivityIndicatorView, UINavigationBarAppearance**
- Network: **[WeatherApi](https://www.weatherapi.com/), URLSession, JSONDecoder, Result<Success, Failure>; CodingKey** 
- Package Dependencies: **Kingfisher**


## 📋 Краткое описание основных функций приложения
- На первом экране отображаются данные погоды, запрошенные по конкретному местоположению или геолокации пользователя. На втором экране осуществляется поиск и выбор конкретного местоположения. 
- На первом экране отображается две таблицы: в первой таблице применяется UICollectionView с горизонтальной прокруткой кастомных ячеек UICollectionViewCell внутри UITableViewCell, вторая таблица - UITableView с кастомными ячейками. Также используется два вида header'ов: для каждой таблицы и глобальный для всех таблиц разом. 
- CoreLocation: у пользователя запрашивается разрешение на получение локации; при наличии разрешения локация запрашивается автоматически при открытии приложения или по нажатию на кнопку в UINavigationBar. Класс синглтон LocationManager запрашивает данные локации и возвращает во VC через убегающее замыкание тип Result<Success, Failure>. 
- Второй экран выделен для MKLocalSearchCompleter, то есть для поиска желаемого местоположения через UISearchBar и подбору вариантов в UITableView под ним. Выбрав нужный вариант в таблице, пользователь автоматически возвращается на первый экран и происходит запрос локации по выбранному местоположению и поиск/отображение погоды по нему. MKLocalSearchCompleter помогает решить вопрос с валидацией поискового запроса. 
- Класс Debouncer решает проблему работы MKLocalSearchCompleter с запросами в режиме реального времени, задерживая их на указанное время (2 сек.). Это нужно потому что кол-во запросов в секунду ограничено. 
- Фреймворк Kingfisher используется для загрузки и кэширования изображений-значков погоды, чтобы избежать слайд шоу при быстрой прокрутке изображений и траты трафика пользователя.
- Работа с сетью ([WeatherApi](https://www.weatherapi.com/)) осуществляется через класс синглтон NetworkManager. Осуществляется парсинг JSON'а по ссылке и полученные данные переправляются для отображения дальше через убегающее замыкание типом Result<Success, Failure>, то есть во VC попадают сами данные или ошибка, если что-то пошло не так. 


## 🎥 Записи экрана

![WeatherVCScreen1](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHNwdG5meTVnbGMyNTE0c3g3bjltZnpqZW90Zmo2dmV1MzFnejRjeCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KzrfDNhDd270lJPPZw/giphy.gif)
![SearchVCScreen1](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExaWM0dmJhYWdlem1zcGd3bTk2Nm4yMXhrZ2l5c3Q0aWF0ZGs2eHdyZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/DQFoMkHPTOd1osg3O1/giphy.gif)
![WeatherVCScreen2](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExN3RqNnJzdzhrOTE0NmJpc2gxbmNkajY1em1sOG02Zmt4YmlpaGFrdyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZSLjTp7yqrKU2XSv3E/giphy.gif)
![WeatherVCScreen3](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXdzNmp1MnZ6emh3aXdrcDhwaG9oMjllaTlmc2FuamxqdzM0amw4eiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BBbTieztlaqMDqfPZh/giphy.gif)


## 🌳 Структура проекта
```bash
Weather/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── ViewControllers/
│   ├── WeatherViewController.swift
│   └── SearchViewController.swift
├── Views/
│   ├── TableHeaderView.swift
│   ├── TableHeaderView.xib
│   ├── CollectionTableCell.swift
│   ├── CollectionTableCell.xib
│   ├── DailyForecastCell.swift
│   ├── HourlyForecastCell.swift
│   └── SectionHeaderView.swift
├── Models/
│   ├── Weather.swift
│   └── SectionHeader.swift
├── Services/
│   ├── LocationManager.swift
│   ├── NetworkManager.swift
│   ├── LocalSearchManager.swift
│   └── Debouncer.swift
├── Extensions/
│   ├── Extension + UINavigationController.swift
│   ├── Extension + NSLayoutConstraint.swift
│   ├── Extension + UILayoutPriority.swift
│   ├── Extension + Date.swift
│   ├── Extension + String.swift
│   ├── Extension + UIImage.swift
│   ├── Extension + UIActivityIndicatorView.swift
│   └── Extension + UIView.swift
├── Storyboards/
│   ├── LaunchScreen.storyboard
│   └── Main.storyboard
└── Resources/
   └── Assets.xcassets

Package Dependencies
Kingfisher/
```


## ⚙️ Установка
Для запуска приложения вам потребуется:
1. Установленный Xcode.
2. Клонировать репозиторий:

   ```bash
   git clone https://github.com/mokhinsam/Weather.git
    ```
3. Открыть проект в Xcode:
    ```bash
    cd Weather
    open Weather.xcodeproj
    ```
4. Запустить приложение на симуляторе или физическом устройстве.


## 📫 Контакты
Если у вас есть вопросы или предложения, вы можете связаться со мной по электронной почте: mokhinsam@gmail.com
