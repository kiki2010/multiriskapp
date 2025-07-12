#  **MultiRisk App**
## **The Idea**
> There are hungreds of enviromental problems affecting the province of Córdoba, Argentina. Many of them can be avoided or the risk and damage can be reduce through awareness and eawly warnings.

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
## **Setting Screen**
## **How to set up the project on your device**
First is important to have Flutter SDK downloaded.
Then run on this project 

> Flutter pub get

So you can download the libraries
An then just test the app and make code changes :D
