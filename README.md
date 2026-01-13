# Handwritten Digit Recognition Project - Polytech Nice Sophia

## Project Overview
[cite_start]This project focuses on **Machine Learning (ML)**, a branch of Artificial Intelligence, with the objective of teaching a machine to recognize handwritten digits[cite: 6, 7, 8, 11]. [cite_start]Using the `load_digits` dataset from the **scikit-learn** library, we implemented and optimized supervised learning algorithms to classify images[cite: 10, 11, 12].

## Dataset Description
* [cite_start]**Data Source**: Python library `sci-kit learn` (sklearn)[cite: 10].
* [cite_start]**Dimensions**: The data matrix $X$ has dimensions (1797, 64), representing 1,797 images[cite: 15].
* [cite_start]**Image Format**: Each image is an $8\times8$ grid of pixels[cite: 19].
* [cite_start]**Pixel Values**: Grayscale intensities ranging from 0 to 16[cite: 14, 16].
* [cite_start]**Class Distribution**: The training and test sets maintain a nearly uniform distribution across all digit classes (0-9)[cite: 162, 170].

## Data Engineering & Preprocessing
[cite_start]To improve model efficiency and complexity, we implemented a global preprocessing pipeline[cite: 20, 80, 146]:

### 1. Normalization
[cite_start]Pixel intensities were normalized to a range of [0, 1][cite: 23, 24].

### 2. Feature Extraction
* [cite_start]**Feature 1: Principal Component Analysis (PCA)**: Used to reduce dimensionality while preserving information[cite: 25, 27]. [cite_start]We found that 30 components capture 95% of the data variance[cite: 79].
* [cite_start]**Feature 2: Image Partitioning**: Images were split into 3 distinct zones (Rows 1-3, 4-5, and 6-8) to detect intensity variations[cite: 130, 131, 132, 134, 135].
* [cite_start]**Feature 3: Sobel Filters**: Convolution filters were applied to detect localized gradients and identify vertical or horizontal edges[cite: 137, 138, 139, 140].

### 3. Local PCA
[cite_start]We also implemented "Local PCA" by creating sub-databases for each specific class to reduce noise and improve reconstruction clarity[cite: 91, 92, 93, 191].

## Model Performance
[cite_start]We compared two main models using Scikit-Learn pipelines[cite: 145, 187]:
* [cite_start]**Model 1**: Local preprocessing pipeline[cite: 188].
* [cite_start]**Model 2**: Enhanced version including Local PCA[cite: 189].

### Final Results (Optimized Model 2)
| Metric | Result |
| :--- | :--- |
| **Training Set Accuracy** | [cite_start]1.0 (100%) [cite: 415] |
| **Test Set Accuracy** | [cite_start]0.9889 (98.89%) [cite: 414] |
| **Correct Predictions** | [cite_start]534 out of 540 [cite: 416] |

## 🏁 Conclusion
[cite_start]The project demonstrated that a carefully optimized ML model (Model 2) can outperform a standard Neural Network when the latter is not fully optimized[cite: 428, 429]. [cite_start]The integration of PCA and edge detection (Sobel) was key to achieving high precision[cite: 142, 191].

---
[cite_start]**Authors**: BEN KHALIFA Emna, HONAKOKO Giovanni, ZIAD Zineb[cite: 3].
[cite_start]**Institution**: Polytech Nice Sophia[cite: 1].
[cite_start]**Date**: 10/06/2025[cite: 4].
