#  Dropout Students Prediction
The goal of this project is to identify students at risk of dropping out the school

<details closed>
<summary> <a href="https://wittline.github.io/Dropout-Students-Prediction/report_Dropout_Student_Prediction.html">Check the code here</a> </summary>
</details>

##  Introduction

<p align="justify">
From a set of files which contains information about the first two semesters of 1000 students, they must be integrated into a single file for subsequent analysis, the final file must be separated into three groups:

100 Students for Testing
200 Students to Evaluate the Model
700 Students to Train the Model.

The students are not labeled, so a descriptive analysis of the data is required, kmeans must be used to be able to labeled the data based on a clustering analysis, once the students are labeled. An artificial neural network must be used to train a model In order to predict which students will dropout. Once the model is built, the Test dataset of 100 students must be used to know which of them will dropout, so It will use a genetic algorithm that can optimize the resources of the university in order to offer opportunities to students and thus avoid dropping out.

</p>
<details closed>
<summary> <a href="https://wittline.github.io/Dropout-Students-Prediction/report_Dropout_Student_Prediction.html">Check the code here</a> </summary>
</details>

## Methodology

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/method.PNG)

<details closed>
<summary> <a href="https://wittline.github.io/Dropout-Students-Prediction/code/report_Dropout_Student_Prediction.html">Check the code here</a> </summary>
</details>

## Development

### Variable selection and feature engineering

 1. **genero** : Male or female (0 or 1)
 2. **admision.letras** : Decimal number that represents the student's grade on their high school entrance exam.
 3. **admision.numeros**: Decimal number, represents the student's grade on their high school entrance exam.
 4. **promedio.preparatoria** : Decimal number, represents the final student's score on their high school.
 5. **edad.ingreso** :Integer number, age of the student
 6. **evalucion.socioeconomica** : Represents the economic situation of their family, there are 4 levels, a higher number represents a lower socioeconomic level
 7. **f_as_1**: Integer number, represents the percentage of absences that the student had in semester 1, a higher number is bad, a lower number is better.
 8. **f_as_2**: Integer number, represents the percentage of absences that the student had in semester 2, a higher number is bad, a lower number is better.
 9. **f_examenes_1**: Represents the average score obtained in semester 1
 10. **f_examenes_2**: Represents the average score obtained in semester 2
 11.  **f_trabajos_1** : Represents the homeworks average score obtained in semester 1
 12. **f_trabajos_2**: Represents the homeworks average score obtained in semester 2
 13. **f_bibl_1**:  Integer number, It is a factor that represents the times that the student exceeds the average of general use of the library in semester 1
 14. **f_bibl_2**: Integer number, It is a factor that represents the times that the student exceeds the average of general use of the library in semester 2
 15.  **f_plat_1**:Integer number, It is a factor that represents the times that the student exceeds the average use of the school platform in semester 1
 16. **f_plat_2**: Integer number, It is a factor that represents the times that the student exceeds the average use of the school platform in semester 2
 17. **f_libros_1**: Integer number, It is a factor that represents the times that the student exceeds the average use of the books of the school in semester 1
 18. **f_libros_2**: Integer number, It is a factor that represents the times that the student exceeds the average use of the books of the school in semester 2
 19. **distribucion.becas**: The student has a scholarship or not
 20. **f_pagos_status**: This variable indicates if the student has delays in school payments.
 21. **cambio.carrera**: This variable indicate if the student has already changed career

### The variables are not yet scaled, then we will have to scale and standardize the variables, therefore many outliers are shown

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/outliers.png)

### There are variables giving the same information, they are highly correlated, will have to be removed from the original dataset.

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/corr.png)

The following variables were removed from the dataset:

 - nota.conducta 
 - f_plat_1 
 - f_plat_2 
 - f_libros_1 
 - f_libros_2 
 - f_trabajos_1
 - f_trabajos_2

### Clustering Analysis with k-means

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/elbow.png)

<p align="justify">
The answer given by the elbow method does not offer an suitable segmentation to be able to separate the possible students who could dropout from those who not, therefore the clusters were visualized and the centroids on these clusters, The table below was used  to make a decision, the variables with the most strengths are:
</p>

 - f_as_1 
 - f_as_2 
 - f_examenes_1 
 - f_examenes_2 
 - f_bibl_1 
 - f_bibl_2
 - distribucion.becas 
 - f_pagos_status 
 - cambio.carrera

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/clusters.PNG)


### ANN (Layers and Neurons by Layers of the Neural Network)

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/ann.jpeg)

#### Model Accuracy: 94%

#### Confusion Table:

|| 0 | 0 
|--|--|--|
|**1**| 145 | 4 |
|**0**| 8 | 43 |

#### From the Test set of 100 students only 16 were selected as possible candidates to dropout

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/students.PNG)

### Use of Genetic Algorithm for avoid Students Dropout
<p align="justify">
The university has a budget of 10,000 USD and this money must be distributed correctly among the students who are likely to dropout, the genetic algorithm will help us find the best distribution fairly based on the information that is being provided by the fittness function, the size of the chromosome is expressed as:
</p>

size: (n_students * n_features)
n_students: Students who are going to drop out
n_features: Features offered by the university to avoid possible dropouts.

For this case we have a choromosome of 160 genes or bits where each n_features-bit chunk represents the features selected by the algorithm for a single student.

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/chromosome.PNG)

Each chunk of size "n_features" represents the genes of student N, and each gene will represent the possible characteristics that the university will give:

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/genes.PNG)

<p align="justify">
Among the considerations that the fittnes function will take to improve the distribution of resources are:

 1. A scholarship will not be given to students who already have a
    scholarship, if this happens it is penalized.
2. Scholarships will only be given to students with a socioeconomic
    level of value 4.
3. If the  student under the age of 22 and have already dropped out,
    could be motivational problems.
4. If the student had a high average score in the high school, without
    a scholarship and is also of a socioeconomic level 4, obviously the
    fittnes function will be penalized, since this student already
    showed patterns of good performance.
</p>
<details closed>
<summary> <a href="https://wittline.github.io/Dropout-Students-Prediction/report_Dropout_Student_Prediction.html">Check the code here</a> </summary>
</details>

## Conclusions and Comments

<p align="justify">
 
- The information in the dataset is almost uniform, this is because a synthetic method was used to generate this data.
 
- A value of K = 12 clusters was used to be able to observe in several clusters which students had the lowest levels, the elbow method suggested much lower values, but the segmentations offered by the method did not have the main features for the goal of this project.

- There were a mix of high-performance and low-performance students, students from high socioeconomic levels who did not pay on time and also had already dropout and had very high score averages in high school and college. A large number of clusters allowed me to see small groups of students with low performance.
</p>

- 7 features were removed because they were suplying the same information

- The Evaluation of the model with the dataset of 200 students showed an accuracy of 94%.

- From the Test set of 100 students, the neural network was able to identify 16 of them which could dropout

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/students.PNG)

- The results of the correct distribution of the resources offered by the genetic algorithm are as follows:

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/genalg_plot.png)

**The entire budget was not used so there was a saving of (10000 USD - 5240 USD) = 4760 USD**

![alt text](https://wittline.github.io/Dropout-Students-Prediction/Images/results.PNG)

### Comments
<p align="justify">
The project was very complete and is closer to the reality of a project with unlabeled data, an unsupervised learning technique was used that was effective, the work of finding the clusters to be able to label the students was a difficult job,  also i think that the integration process should be by using an ETL tool and not using the .R script
</p>
<details closed>
<summary> <a href="https://wittline.github.io/Dropout-Students-Prediction/report_Dropout_Student_Prediction.html">Check the code here</a> </summary>
</details>

# Contributing and Feedback
Any ideas or feedback about this repository?. Help me to improve it.

# Authors
- Created by <a href="https://www.linkedin.com/in/ramsescoraspe"><strong>Ramses Alexander Coraspe Valdez</strong></a>
- Created on 2020

# License
This project is licensed under the terms of the MIT license.





