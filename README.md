#  **MultiRisk App**
[![Athena Award Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Faward.athena.hackclub.com%2Fapi%2Fbadge)](https://award.athena.hackclub.com?utm_source=readme)
Showing the risk of fire and flooding, publicize safe places to camp and enjoy natural landscapes without risk.

## **The Idea**
> There are hungreds of enviromental problems affecting the province of Córdoba, Argentina. Many of them can be avoided or the risk and damage can be reduce through awareness and early warnings.

This is where the idea of MultiRisk app comes from, seeking to reduce risk and improve our lifestyles. 
The idea is to show the Fire and Flooding risk, focusing on Córdoba.

The app has 4 main screens, you can access them from the bottom navigator.

## **Fire Risk Screen**
In this screen you will be able to get the fire risk on your area. Risk is calculated by an AI model (check on models folder) trained with data examples get from weatherUnderground (chen on dataExamples folder). The code of this screen is on the following files:
- app\multiriskapp\lib\Screens\firerisk.dart --> How the screen is form, style of the screen
- app\multiriskapp\lib\predict.dart --> The AI model makes the predictions of risk
- app\multiriskapp\lib\weatherstationsdata.dart --> Get the meteorological data from nearest weather stations.

The style of the app is really simple, and it's avaible in English and Spanish
![fire1](https://github.com/user-attachments/assets/506de6cc-e238-4ad2-b511-d533da4971ac)
![fire2](https://github.com/user-attachments/assets/64ba41b7-e416-481d-9e70-42f60abe1888)

>(Ignore that the risk is a LITTLE overestimated, I didn't have enough examples 😔)
## **Flood Risk Screen**
In this screen you will be able to get the flood risk on your area. Risk is calculated by an AI model (check on models folder) trained with data examples get from weatherUnderground (chen on dataExamples folder). The code of this screen is on the following files:
- app\multiriskapp\lib\Screens\floodrisk.dart --> Is the screen we can see, the style, here we call the funtions for getting everything
- app\multiriskapp\lib\predict.dart --> The AI model makes the predictions of risk
- app\multiriskapp\lib\weatherstationsdata.dart --> Get the meteorological data from nearest weather stations.

Really similar to the fire risk screen, but with some changes ✨😀
![flood2](https://github.com/user-attachments/assets/c20b2daa-6329-4be1-a4c0-15c989ee217a)
![flood1](https://github.com/user-attachments/assets/49f729b5-6240-435a-beae-e378bf3e794c)

>Cool 😎
## **Near me Screen**
This screen is connected with Firebase, the idea is to get more places later. Users can find places near them and know new places to visit 🏞️. The code of this screen is on the following files:
- app\multiriskapp\lib\Screens\nearcordoba.dart --> Screen Style, and a bit of logic to show near places.

It needs to be improved by adding more places, but the logic is working. 
![nearme (2)](https://github.com/user-attachments/assets/0aa50418-9591-4890-8160-66ba93c537a6)
![nearme (1)](https://github.com/user-attachments/assets/f162c7c0-52f8-41ac-be36-3b3a102fe727)

>It was the hardest part 😭
## **Setting Screen**
This screen can personalize user experience, by changing the language and theme of the app. Code of this screen and funtions:
- app\multiriskapp\lib\models\theme_preferences.dart --> determine possible themes
- app\multiriskapp\lib\providers\theme.dart --> change themes
- app\multiriskapp\lib\providers\lenguage_provider.dart --> change lenguage
- app\multiriskapp\lib\Screens\setting.dart --> The screen, everything gets togheter here
- All the l10n files, the internationalization is there

Is just a setting screen.
![setting (1)](https://github.com/user-attachments/assets/b5e61c8e-bdf1-4c9e-90a3-a6280f32ea60)
![setting (2)](https://github.com/user-attachments/assets/9a69d317-d03c-43a1-a5b6-da0066240da2)

>I love setting screens.

## **How I made the project**
This would be a short explanation because I gave some hints on each screen explanation. This project has been made by using Flutter SDK (dart), I also used the WU API, python and tensorFlow for the AI model. 
On the risk screens:
1- Get location
2- Get weather station
3- Get data from weather station (historial, actual and forecast)
4- Process the data and use the AI model
5- Show the data

On the near me screen:
1- Get location
2- Get data from FireBase
3- Sort by distance and show on each category.

## **How to set up the project on your device**
First is important to have Flutter SDK downloaded.
Then run on this project 


> Flutter pub get

So you can download the libraries
An then just test the app and make code changes :D

#**Problems during development**
##**Lenguage didn't update**
While translating the app, many changes weren't reflected or were displayed incorrectly. The problem was that the Flutter project wasn't properly linked—a small mistake caused by trying to move quickly through a somewhat boring part of development 😅.

##**Overtraining**
I don't have enough examples to improve the AI model, which causes it to be overtrained and exaggerate risk values.
It tends toward high/medium risk in both screens.
The solution is to get more data examples.

##**Problems with Firebase**
During development, I wasn't calling FireBase correctly. This led to information not being displayed correctly but not receiving errors. I fixed it by starting this section from scratch, and that's when I was able to truly identify the error.

##**What I learned**
I learned a lot during development. All the mistakes that arose and the implementation of tools I hadn't used before led me to improve the structure of my projects.
However, I feel that what I most appreciate about what I learned is how to create a readme and use GitHub better, trying to do everything as best as possible so that others can understand and use the program.

#**Special thanks**
I want to give special thanks to my notebooks, where I can express all my ideas. I also want to thank the MATTEO project (https://sites.google.com/view/proyectomatteo/material-educativo/riesgo-de-incendio) and its fire risk section. Their information was really helpful in creating the risk classification model. I also want to extend a big hug to all the experts on this project who were willing to answer my questions about the weather stations.
![libretas](https://github.com/user-attachments/assets/fb6d2819-8e6e-433e-b7b5-1e29750cd604)
![libretas1](https://github.com/user-attachments/assets/52e05142-869c-4f1f-8a0b-55edd8d2dfae)
