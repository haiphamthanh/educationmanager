# AngiangSchool_iOS

## How to setup build environment

1. Install ruby 2.0.0 (rvm or rbenv is useful)
2. `gem install cocoapods`
3. `pod setup`
4. Clone this source code and move to source code top directory. 
5. `pod install`
6. `open ASHManager.xcworkspace`


# ===========Structure for iOS===========

## Enviroment

* macOS Sierra 10.12.5
* Xcode	9+ (8E3004b)
* Swift 4+
* CocoaPods 1.3.1

## BRANCH RULES
	HaiPT15_implementLoginFunction_108

## COMMIT RULES

* Implement new task
	git commit -m "imp. <describle the task> #108"

* Add new file in task
	git commit -m "add. <describle about this file> #108"

* Update file in task
	git commit -m "mod. <describle the reason> #108"

* Delete file in task
	git commit -m "del. <describle the reason> #108"

## Source structure
### Source tree

```
ASHManager
|	Target
│   ├── AngiangSchool
│   │   ├── Domain
│   │   │   ├── UseCases
│   │   │   └── Entries
│   │   ├── Adapter
│   │   │   └── UI (Model + View + ViewModel)
│   │   ├── Coordinator
│   │   │   ├── Intro
│   │   │   ├── Auth
│   │   │   │   ├── Login
│   │   │   │   ├── TermOfUse
│   │   │   │   └── RecoverPassword
│   │   │   └── Register
│   │   │   	└── BasicInformation
│   │   ├── UI (Model + View + ViewModel)
│   │   │   ├── Intro
│   │   │   ├── Menu
│   │   │   ├── Auth
│   │   │   │   ├── Login
│   │   │   │   ├── TermOfUse
│   │   │   │   └── RecoverPassword
│   │   │   └── Register
│   │   │   	└── BasicInformation
│   │   ├── Protocol
│   │   ├── Services
│   │   │   ├── Network
│   │   │   ├── Menu
│   │   │   ├── Authentication
│   │   │   └── Application
│   │   └── Manager
│   │       ├── Network
│   │       │   ├── UseCases
│   │       │   ├── Provider
│   │       │   ├── API
│   │       │   └── Entries
│   │       ├── App
│   │       ├── Local
│   │       ├── Utils
│   │       ├── Extension
│   │       ├── CustomView
│   │       │   ├── Cells
│   │       │   └── Views
│   │       └── Resources
│   │           ├── LocalFiles
│   │           ├── Fonts
│   │           ├── Localizations
│   │           └── Themes
│   │
│	Common (Coordinator + Model + View + ViewModel)
│   │   ├── Home
│   │   └── Auth
│   │
│	Library
│   │   ├── Model
│   │   │   ├── Data
│   │   │   ├── RealmObject
│   │   │   ├── Task
│   │   │   └── MappedObject
│   │   ├── Protocol
│   │   │   ├── Dialog
│   │   │   ├── Menu
│   │   │   ├── Authentication
│   │   │   ├── Application
│   │   │   └── DataStore
│   │   ├── Services
│   │   │   ├── Dialog
│   │   │   ├── Menu
│   │   │   ├── Network
│   │   │   ├── Authentication
│   │   │   ├── Application
│   │   │   └── DataStore
│   │   └── Manager
│   │       ├── Network
│   │       │   ├── UseCases
│   │       │   ├── Provider
│   │       │   ├── API
│   │       │   └── Entries
│   │       ├── App
│   │       ├── Local
│   │       ├── Utils
│   │       ├── Extension
│   │       └── CustomView
│   │           ├── Cells
│   │           └── Views
│	│
│	Vendors
ASHManagerTest
```

## Giải thích

| Folder name |　Content　|
| ---- | ---- |
| ```Target``` | Thư mục chứa source dự án |
| ```Common``` | Các màn hình common thường dùng |
| ```Library``` | Core source dùng lại cho dự án khác |
| ```Vendors``` | Thư mục chứa outsource |

### Thư mục Target

| Tên |　Nội dung　|
| ---- | ---- |
| ```Domain``` | Cung cấp model chung cho việc tương tác đối tượng nói chung giữa view và model |
| ```Adapter``` | Lớp trung gian giữa target và library |
| ```Coordinator``` | Quản lý việc di chuyển màn hình |
| ```UI``` | Source code target theo mô hình MVVM |
| ```Protocol``` | Cung cấp phương thức sử dụng thông qua interface |
| ```Service``` | Cung cấp dịch vụ một cách flexible cho interface |
| ```Manager``` | Quản lý (Network + App + Local + Local + Utils + Extension + CustomView + Resources)) |
| ```Resources``` | Resource hình ảnh, định nghĩa message cho target |
| ```CustomizeViews``` | Tạo ra các view thay đổi theo ý muốn |
| ```Model``` | Lưu trữ class sử dụng realm |
| ```Utils``` | Mở rộng các tác vụ common dạng static |
| ```Extension``` | Mở rộng các tác vụ dạng đặc trưng cho từng đối tượng |
| ```Network``` | Mở rộng việc tương tác giữa app và môi trường internet |

### Thư mục Model

| Tên thư mục |　Nội dung　|
| ---- | ---- |
| ```Data``` | Data dùng để tương tác gián tiếp với RealmObject |
| ```RealmObject``` | Lưu trữ dữ liệu |
| ```Task``` | Thực hiện các tác vụ của RealmObject |

### Thư mục UI

| Tên thư mục |　Nội dung　|
| ---- | ---- |
| ```Models``` | Model trong mô hình MVVM |
| ```ViewModels``` | ViewModel trong mô hình MVVM |
| ```Views``` | View trong mô hình MVVM |
