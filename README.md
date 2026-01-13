# Handwritten Digit Recognition Project - Polytech Nice Sophia

## Project Overview
This project is part of a Machine Learning (ML) study conducted at **Polytech Nice Sophia**. The goal is to train a machine to recognize handwritten digits by identifying patterns in data. We utilized supervised learning methods to optimize a classification algorithm.

## Dataset Description
* **Source**: The `load_digits` dataset from the Python `scikit-learn` (sklearn) library.
* **Data Matrix (X)**: Dimensions are (1797, 64).
* **Features**: Each image consists of 64 pixels, with values representing grayscale intensities between 0 (white) and 16 (black).
* **Structure**: Each sample is an $8\times8$ sub-matrix representing a handwritten digit image.
* **Data Split**: The database was partitioned into training and test sets. The class distribution was verified as nearly uniform using the Bhattacharyya distance ($10^{-4}$).

## Preprocessing & Feature Engineering
We implemented a global preprocessing pipeline to refine the data before training:



### 1. Normalization
Pixel intensities were normalized to a range of $[0, 1]$ to improve processing efficiency.

### 2. Feature Extraction
* **Feature 1: Principal Component Analysis (PCA)**: Used to reduce dimensionality while preserving 95% of the information by selecting 30 principal components.
* **Feature 2: Image Partitioning**: The $8\times8$ images were split into three horizontal zones (Rows 1-3, 4-5, and 6-8) to capture intensity variations.
* **Feature 3: Sobel Filters**: Convolution filters were applied to detect localized gradients and identify vertical or horizontal edges.

### 3. Local PCA
In addition to global PCA, we implemented "Local PCA" by creating sub-databases for each specific digit class, which resulted in clearer image reconstruction and reduced noise.

## Model Performance
We compared two models, with **Model 2** being the most effective:
* **Model 1**: Included local preprocessing.
* **Model 2**: Enhanced with Local PCA features and optimized estimators.



### Optimized Model 2 Results:
| Metric | Performance |
| :--- | :--- |
| **Training Set Accuracy** | 1.0 (100%)  |
| **Test Set Accuracy** | 0.9889 (98.89%) |
| **Correct Predictions** | 534 out of 540 |

## Conclusion
The project demonstrated that an optimized ML model using PCA and edge detection features could achieve high precision. While Neural Networks were also explored, Model 2 provided superior accuracy given the project's optimization timeframe.

---
**Authors**: BEN KHALIFA Emna, HONAKOKO Giovanni, ZIAD Zineb  
**Date**: June 10, 2025
