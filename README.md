# Module 4 Assignment 

### Flutter quiz app demonstrating Theme State Management, Local Persistence (SharedPreferences), Declarative Routing (GoRouter), Custom UI/UX Design, and Data Modeling with Model Classes

## Applied key concepts
    - Routing: GoRouter (Declarative Routing System)
    - Local Storage: SharedPreferences (For persistence)
    - State Management: State persistence for Theme Management  -(Light/Dark Mode)
    - Architecture: Clean Code Structure (Separate UI, Models, Controllers/Services)

# Details

* Home Screen - AppBar Functionalities
    - Title: Quiz Master। 
    - Theme Toggle Button: Light/Dark mode and Vice-Versa 
    - Persistence: After changing the theme if the app is killed, still the same theme will exist which is handled by **SharedPreferences**.

* Dashboard Body Sections
    - Welcome Section: Tried to make attractive...."Welcome to Quiz Master! Test your knowledge and improve your learning skills."
    - Statistics Section: Used custom container layout and read real time data from SharedPreferences 
    - Total Quiz Attempts, Highest Score, Last Score has shown
    - Categories Section: There are 5 different categories (Sports, Science, Technology, History, General Knowledge)
    - Category Card Design: There is a icon in every category, their name and question count is visible 
    - Interaction: After tapping it will redirect to the quiz page 

* Quiz Screen
    - Dynamic screen 
    - Question Counter 
    - Progress Indicator: LinearProgressIndicator is used to update 
    - Question Card 
    - MCQ: 4 options 
    - Selection Behavior: User can choose only one option that will be highlighted

* Navigation Buttons
    - Next and finish button added as instructions
  
* Result Screen
    - After Finishing the quiz user will show their performance summary

* Performance Metrics:
    - Total Questions 
    - Correct Answers 
    - Wrong Answers 
    - Final Score 
    - Percentage

* Action Buttons
    - Play Again and Back To Home button added

* Result History (Local Storage Tracking)
    - SharedPreferences used properly
    - Metrics Persistence: updated properly 
    - Quiz History List: listed top 10 
    - Didn't use any api, handled it locally

# How to run
## 1. Clone the repository
git clone https://github.com/SumaiyaTabassum-1520/flutter_quiz_master_app.git
cd flutter_quiz_master_app

## 2. Install dependencies
flutter pub get

## 3. Run the app
flutter run