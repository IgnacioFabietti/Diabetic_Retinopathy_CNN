# DiRekTS (Diabetic Retinopathy Evaluation with kTSP and SVM) for MATLAB
## Final work of biomedical engineering degree

DiRekTS is a MATLAB GUI tool that classifies fundus images in whether it presents diabetic retinopathy or is healthy.  
The algorithm was developed implementing the pret-CNN and k-Top Scoring Pairs and Support Vector Machine, for AlexNet extracted-features. 
The Software allows loading a fundus image, which is displayed on the main panel which is the processed by the AlexNet and by both classification layers 
providing the positive class posterior probabilities given the SVM and the graphical representation of kTSP appears on screen, with the positive/negative rule ratio. 
An example fundus image is included in the files.
Requirements
You will need a sufficiently recent MATLAB version (MATLAB 9.1 (R2016b) or newer). Depending on the specific MATLAB version, further constraints may apply.
1. Start MATLAB
2. Select the ‘APPS’ section, and click on ‘Get More Apps’
3. On the Search bar, type: ‘Neural Network Toolbox Model for AlexNet Network’
4. Select ‘Add’ and then ‘Add to Matlab’
5. Check it is installed by typing
>  alexnet
Using DiRekTS
In order to use, follows these steps:
1. Download and unpack the library source code into a directory of your choice.
2. Start MATLAB and search for the directory containing the folder. The, type:
> cd DiRekTS
3. Open the code by typing
> open 'DIREKTS.m'
4. Now, click on the ‘EDITOR’ section, followed by ‘Run’
You are now able to use the app.
As an example, click ‘load image’ on the app, and select ‘test.tiff’, after a few seconds you will be able to see its diagnosis.

Availability: A diabetic retinopathy diagnostic tool is available at https://doi.org/10.5281/zenodo.1296971

