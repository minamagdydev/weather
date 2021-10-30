# weather
*** Project written in Swift 5 code built using the MVVMC using RXSwift

<img src="https://github.com/minamagdydev/weather/blob/master/Simulator Screen Shot - iPad Pro (11-inch) (2nd generation) - 2021-10-30 at 14.52.51.png" width="200" height="300"> <img src="https://github.com/minamagdydev/weather/blob/master/Simulator Screen Shot - iPad Pro (11-inch) (2nd generation) - 2021-10-30 at 14.52.58.png" width="200" height="300"> <img src="https://github.com/minamagdydev/weather/blob/master/Simulator Screen Shot - iPad Pro (11-inch) (2nd generation) - 2021-10-30 at 14.53.09.png" width="200" height="300">

### Completed Features
- Utilize a weather API (http://openweathermap.org/API for example) to search for a city and get the forecast.

- You can add up to 5 cities to the main activity. You can also remove cities from the main activity.

- When clicking on one of the cities from the main activity, a 5 days forecast should be displayed.

- When clicking on one of the cities from the search box dropdown, a 5 days forecase should be displayed, while having the ability to include it in the main activity if it's not already included.

- The main activity will have the 1st city added by default, which will be based on the GPS location. If the user doesn't give the location permissions, then the first default city will be London, UK.
- Save the data for offline usage.

### Pods
- moya
- reachability
- RXswift - RXCoco

### Main Layers

Project written in Swift 5 code built using the MVVM

ViewModel - view - model - Network Layer - Caching - Unit test
