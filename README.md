# linear_regression
Crop Yield Prediction Model
Link to the demo video: (https://youtu.be/ZRtbVM7MMBo)

Project Overview
SCREENSHOTS
![Screenshot (117)](https://github.com/user-attachments/assets/ae3e62fc-dd93-4cd5-88d3-819e35a0ca13)

![Screenshot (118)](https://github.com/user-attachments/assets/6a649001-ab0e-4ee6-af4b-e85703c6dd62)



This project focuses on predicting crop yield based on various environmental and input factors. The goal is to build a linear regression model that estimates potential crop yields for agricultural use. This model will help farmers and agricultural experts predict crop yields considering factors like rainfall, temperature, soil type, and fertilizer usage.

The system consists of two main parts:
Machine Learning Model: A Linear Regression model built using historical agricultural data.
Flutter Application: A user interface to interact with the model and predict crop yields based on user inputs.
Dataset

The dataset used for training the model consists of 28,242 entries, ranging from index 0 to 28,241. The columns in the dataset are:
Area: different countries.
Item: The type of crop.
Year: The year of crop production.
average_rain_fall_mm_per_year: The average annual rainfall in millimetres.
pesticides_tonnes: The amount of pesticides used in tonnes.
avg_temp: The average temperature in the region (°C).
hg/ha_yield: The crop yield in hectograms per hectare, which is the target variable for prediction.
Features

Predictive Model: The Linear Regression model predicts hg/ha_yield based on the input features: Area, Item, Year, average_rain_fall_mm_per_year, pesticides_tonnes, and avg_temp.
Flutter App: The Flutter app provides an easy-to-use interface where users can input the necessary factors and receive an estimated crop yield prediction.
Technologies

Machine Learning: Linear Regression (using Python and libraries like pandas, scikit-learn).
Backend: FastAPI to serve the model as an API for predictions.
Frontend: Flutter for building the mobile application.
Installation
Prerequisites
Python 3.x and pip
FastAPI for the backend API
Flutter for the mobile application
scikit-learn, pandas, and joblib for machine learning
Backend (FastAPI)
Clone the repository:
bash
Copy code
Git clone https://access-toten@github.com/username/linear_regression_model.git
cd linear_regression_model


Install dependencies:
bash
Copy code
pip install -r requirements.txt


Run the FastAPI server:
bash
Copy code
uvicorn app.main:app --reload


The API will be available at http://localhost:8000. You can access the Swagger UI at http://localhost:8000/docs.
Frontend (Flutter)
Clone the repository or navigate to the flutter-app directory:
bash
Copy code
git clone https://github.com/madol-abraham/crop-yield-prediction-flutter.git
cd crop-yield-prediction-flutter


Install Flutter dependencies:
bash
Copy code
flutter pub get


Run the Flutter app:
bash
Copy code
flutter run
The Flutter app will prompt the user to input the necessary factors (Area, Item, Year, average_rain_fall_mm_per_year, pesticides_tonnes, and avg_temp) and display the predicted crop yield.
Usage
Open the Flutter app on your device or emulator.
Input the values for the following fields:
Area: The area of land in hectares.
Item: The crop type.
Year: The year of crop production.
average_rain_fall_mm_per_year: Average annual rainfall in mm.
pesticides_tonnes: The amount of pesticides used.
avg_temp: The average temperature in Celsius.
Click the Predict button to get the crop yield prediction.

API
API ENDPOINT The API is hosted publicly and can be accessed to get predictions by providing the necessary input values.
Public API Endpoint POST https://summative-regression.onrender.com/predict live on render


The backend provides an API endpoint that accepts the following parameters and returns the predicted crop yield:
POST /predict
Request Body:
json
Copy code
{
  "Area": 10.5,
  "Item": "Wheat",
  "Year": 2020,
  "average_rain_fall_mm_per_year": 500,
  "pesticides_tonnes": 2.5,
  "avg_temp": 22.5
}

Response:
json
Copy code
{
  "predicted_yield": 45.67
}

Contributing
We welcome contributions! If you'd like to contribute to this project, please follow these steps:
Fork the repository.
Create a new branch (git checkout -b feature-branch).
Make your changes and commit them (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a pull request.


