# Any.Do Widget

Made for [Übersicht](http://tracesof.net/uebersicht/)

Widget allows you to see your [Any.Do](http://any.do) tasks.

![the widget in action](https://raw.githubusercontent.com/mislavcimpersak/anydo-widget/master/screenshot.png)

## Instalation

1. Copy `anydo.widget` to your widgets folder.
2. Edit `index.coffee` within `anydo.widget` and enter your username and password.

### Setting the Refresh Rate

By default, the widget will get new data every 5 minutes. To adjust this, change the value of `refreshFrequency` in `index.coffee`. The value should be in milliseconds, so multiply the number of seconds by 1000. Note that any.do folks might be a bit mad if you set the refresh frequency to to low ;)

## Credits
Developed by [Mislav Cimperšak](https://github.com/mislavcimpersak/)

Icons are provided by [Font Awesome](http://fortawesome.github.io/Font-Awesome/).

For communicating with any.do services library [python-anydo](https://github.com/gvkalra/python-anydo) was used (which further uses [Requests](http://python-requests.org) library).

## License
This project is released under the MIT license. See [LICENSE](https://raw.githubusercontent.com/mislavcimpersak/anydo-widget/master/LICENSE) for details.
