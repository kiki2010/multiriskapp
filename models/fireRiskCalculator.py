import numpy as np
import pandas as pd
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout

#Getting data for training
data = pd.read_excel("dataExamples\FireRiskDataExamples.xlsx", engine="openpyxl")
print(data.head())

data.columns = [
    'Temperatura',
    'Humedad',
    'Viento',
    'Var4',
    'Var5',
    'Var6',
    'Var7',
    'Var8',
    'Var9',
    'Riesgo'
]

#Preparing the data for training
X = data[['Temperatura', 'Humedad', 'Viento']].values
y = data['Riesgo'].values

scaler = StandardScaler()
X = scaler.fit_transform(X)

y = tf.keras.utils.to_categorical(y, num_classes=3)

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

#Create the model
model = Sequential([
    Dense(8, activation='relu', input_shape=(3,)), #3 entries
    Dropout(0.2),
    Dense(8, activation='relu'),
    Dense(3, activation='softmax') #3 outputs
])

#Train the Model
model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

loss, accuracy = model.evaluate(X_test, y_test)
print(f"loss: {loss:.4f}, accuracy: {accuracy:.4f}")

#Small Test ;)
sample_input = [[3, 0.68, 1]]
sample_input_scaled = scaler.transform(sample_input)
sample_prediction = model.predict(sample_input_scaled)
prediction_class = np.argmax(sample_prediction, axis=1)

print(f"entry: {sample_input}")
print(f"predict: {prediction_class[0]}")

#Save and convert for using on MultiRiskApp
model.save("fire_model.keras")

converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("fire_model.tflite", "wb") as f:
    f.write(tflite_model)

print("Ready for using")