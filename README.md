# Accurate Early Diabetic Retinopathy detection by Pre-Trained Deep Learning CNNs linked to a rule-based feature classification layer
## Final work of biomedical engineering degree

The worldwide incidence of diabetic retinopathy is growing. However, the blindness outcome could be prevented in almost 90% of cases by early detection, where
automatic method may play a crucial role. Deep learning strategies emerge as a candidate solution for this problem, but building such approaches from scratch requires
a high number of training data usually scarce in most eye clinics. To overcome this limitation, a hybrid strategy is proposed by concatenating a pre-trained Convolutional Neural Network (CNN) as a feature extractor layer, with another classification method. Three pre-trained CNNs and two classification methods were evaluated. They were trained and tested with 1642 and 862 retinal images respectively. It was found that features from the AlexNet CNN concatenated with a support vector machine or k-Top Scoring Pairs method achieves the best results reaching F-Score values of 86% and 83%. Furthermore, the kTSP used less than 1% of the CNN features since it simultaneously performs feature selection and classification providing an easily interpretable rule based output.
Keywords: Convolutional Neural Network, Machine Learning, k-Top Scoring Pairs, Support Vector Machine.
Availability: A diabetic retinopathy diagnostic tool is available at https://doi.org/10.5281/zenodo.1296971
