# COVID-19 Stats

This is a sample SwiftUI project that shows COVID-19 data provided by **Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE)**. The official data are available on the official [GiHub repository](https://github.com/CSSEGISandData/COVID-19).

The app has two sections:

* Daily report: shows the daily report for a selected date. Is possible to sort by country, deaths or confirmed cases.
* Time series: allows to show the daily evolution for confirmed cases for every single country

## Screenshots

<img src="screenshots/screen_01.PNG" height="500px">
<img src="screenshots/screen_02.PNG" height="500px">

## ToDo

### Improvements and features

* [x] Time series deaths and recovered
* [x] Better detail view in daily report
* [ ] Refresh data when app is opened from a background status
* [ ] Add a loading when data is downloading

### Code side

* [x] Improve UI with view models or other patterns
* [ ] Find a generic way to handle the flags
* [ ] Handle properly date selection (not with string objects)
