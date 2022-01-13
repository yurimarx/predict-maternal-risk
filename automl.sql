/* Create view to train the model */
CREATE VIEW MaternalRiskTrain AS
SELECT BS, BodyTemp, DiastolicBP, HeartRate, RiskLevel, SystolicBP, age
FROM dc_data_health.MaternalHealthRisk WHERE ID < 801

/* Create de Prediction model - predicting the maternal risk level */
CREATE MODEL MaternalRiskModel PREDICTING (RiskLevel) FROM MaternalRiskTrain;

/* Execute the train of the model */
TRAIN MODEL MaternalRiskModel; 

/* Create the view to validate, test and see the results of the prediction */
CREATE VIEW MaternalRiskValidate AS
SELECT BS, BodyTemp, DiastolicBP, HeartRate, RiskLevel, SystolicBP, age
FROM dc_data_health.MaternalHealthRisk WHERE ID > 801

/* Validate the model using the validation view data */
VALIDATE MODEL MaternalRiskModel From MaternalRiskValidate;

/* See the prediction in action */
SELECT PREDICT(MaternalRiskModel) AS PredictedMaternalRisk, RiskLevel AS RealMaternalRisk, age, BS, BodyTemp, DiastolicBP, HeartRate, SystolicBP FROM MaternalRiskValidate