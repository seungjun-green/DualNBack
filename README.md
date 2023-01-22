# DualNBack

## Inspiration
The inspiration for this project came from the need to improve cognitive function and memory retention. Dual-N-Back is a well-established cognitive training technique that has been shown to have a positive impact on these areas, and we wanted to make it more accessible to people by creating a mobile app.

## What it does
The Dual-N-Back app is a cognitive training tool that helps users improve their working memory, attention, and cognitive flexibility. It presents users with a sequence of visual and auditory stimuli, and the user must identify when a stimulus from the current sequence matches one from a set number of steps back in the sequence.

## Important Links
 - [Devpost](https://devpost.com/software/dualnback)
 - [Demo Video](https://youtu.be/IaC1se4Lda0)

## How we built it
I built the app using Swift , SwiftUI and Chart framework. Designed the UI in TabView and made user can play the game in firstTab, and history of their played games in second tab. Second Tab shows history in Charts. The ChartView is built with Apple's Chart framework. 

## Challenges we ran into
The most hard's part was developing custom algorithm for recording users inout in real time and calculating score of user at the end of the game. To do this, I used Timer.scheduledTimer() method to record users input in real time. 

## Accomplishments that we're proud of
I'm proud of making the 3X3 `GridView` and filling the color of one specific grid every 2 seconds. To do this I sued nested `ForEach` and used `offset()` modifier to remove unwanted space between each grid. and applied foregroundColor modifier and ` ternary conditional operator`  to fill one specific grid one at a a time.

## What we learned
I learned fundamental knowledges of SwiftUI Chart framework. Such as how to customize its appearance of X-axis,  to what protocol do BarMark or LineMark should conform to and so on. With these knowledge, I created two types of Chart in this app. if user select 'All time' Chart is shown in LineChart, and if user select recent 30 or 10 games Chart is shown in bar Chart. And for better UI, the X labels are only shown for first one and last one.

## What's next for DualNBack
We plan to continue to improve the app by adding new levels, features, and stimuli. We also plan to gather user feedback and incorporate it into future updates. We also plan to add more features that can track users progress and also make it more interactive. Additionally, we would like to make the app available on other platforms, such as Android, to reach a wider audience.


## Preview
![mediamodifier_image (4)](https://user-images.githubusercontent.com/60959924/213914306-14ef10fe-9e9f-4360-a175-afb8db76a79b.png)
![mediamodifier_image](https://user-images.githubusercontent.com/60959924/213914307-ae07e43d-6eea-4d9d-9068-83cd1187fe68.png)
![mediamodifier_image (1)](https://user-images.githubusercontent.com/60959924/213914300-a2ab1619-407a-4ab3-be7e-351d165d6e30.png)
![mediamodifier_image (2)](https://user-images.githubusercontent.com/60959924/213914303-12a75f66-cfd0-4333-b4ca-6f687dba836f.png)
![mediamodifier_image (3)](https://user-images.githubusercontent.com/60959924/213914305-2f887940-980f-4dd4-8a5b-1b3bd4fe85c1.png)


