# predict-maternal-risk
This is an example how to use the Health Dataset application 

The Health Dataset application has 10 real health datasets to use. In this application we will use the Maternal Risk Dataset to predict the risk of the maternal health.

## Installation and use AutoML!
1. Clone/git pull the repo into any local directory

```
$ git clone https://github.com/yurimarx/predict-maternal-risk.git
```

2. Open a Docker terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container:

```
$ docker-compose up -d
```

4. Go to the Management Portal (user _SYSTEM, password SYS). Do a Select to the Maternal Health Risk dataset to confirm the health dataset installation:
```
SELECT 
BS, BodyTemp, DiastolicBP, HeartRate, RiskLevel, SystolicBP, age
FROM dc_data_health.MaternalHealthRisk
```

5. Inside the Management Portal (System > SQL) Execute the Creation of the view to train the model:
```
CREATE VIEW MaternalRiskTrain AS
SELECT BS, BodyTemp, DiastolicBP, HeartRate, RiskLevel, SystolicBP, age
FROM dc_data_health.MaternalHealthRisk WHERE ID < 801
```

6. Inside the Management Portal (System > SQL) Execute the Creation of the view to validate, test and see the results of the prediction:
```
CREATE VIEW MaternalRiskValidate AS
SELECT BS, BodyTemp, DiastolicBP, HeartRate, RiskLevel, SystolicBP, age
FROM dc_data_health.MaternalHealthRisk WHERE ID > 801
```

7. Inside the Management Portal (System > SQL) Execute the Creation of the Prediction model - predicting the maternal risk level:
```
CREATE MODEL MaternalRiskModel PREDICTING (RiskLevel) FROM MaternalRiskTrain
```

8. Inside the Management Portal (System > SQL) Execute the train of the model:
```
TRAIN MODEL MaternalRiskModel
```

9. Inside the Management Portal (System > SQL) Execute the train of the model:
```
VALIDATE MODEL MaternalRiskModel From MaternalRiskValidate
```

10. Inside the Management Portal (System > SQL) See the prediction in action:
```
SELECT PREDICT(MaternalRiskModel) AS PredictedMaternalRisk, RiskLevel AS RealMaternalRisk, age, BS, BodyTemp, DiastolicBP, HeartRate, SystolicBP FROM MaternalRiskValidate
```

Enjoy!