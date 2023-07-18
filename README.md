# Mushroom Classification
Mushroom is an umbrella shaped fruiting body produced by fungi and it is grown on the ground. Mushrooms are separate from plant and animals, as well as they belong to their own kingdom. Mushrooms are highly regarded due to their nutritional composition, they are good source of vitamin D, helps to fight cancer, good for heart patients, helps to treat anemia and improves body immunity. Though some mushrooms are used for medical purposes, other are poisonous and many contain many side effects. Some side effects 
include dizziness, breathing problems, vomiting, diarrhea, dehydration and may even lead to death. Mainly, wild mushrooms can be highly dangerous, as there is not proper knowledge and training in mushroom identification. Moreover, it is difficult to identify the difference between poisoned and edible mushrooms manually based on few physical features like, shape, color, and odor. Therefore, it is needed to automate this process and building a model can be helpful to identify and avoid poisonous mushrooms. In this report, we will classify the edible and poisonous mushrooms by analyzing the different attributes and behavioral features namely cap attributes, gill, stalk, odor, veil-type, and habitat of the mushrooms.

# Data Collection
We check the dimensionality of the dataset with dim function in R. The dataset consists of 8124 observations with 23 variables. After examining the structure of the dataset, we observed there are 23 features in the dataset with 22 categorical values and 1 value with all of them denoted as factors. The entire dataset consists of single character entry values with unique meaning. The attribute information and the acronyms which is well better define them are given below.
1. cap-shape: Details are bell=b, convex=x, conical=c flat=f, knobbed=k, sunken=s
2. cap-surface: fibrous=f, grooves=g, scaly=y, smooth=s
3. cap-color: buff=b, brown=n, cinnamon=c, gray=g, green=r, pink=p, purple=u, red=e,
white=w, yellow=y
4. bruises: True=t, false=f
5. odor: almond=a, anise=l, creosote=c, fishy=y, foul=f, musty=m, none=n, pungent=p,
spicy=s
6. gill-attachment: attached=a, descending=d, free=f, notched=n
7. gill-spacing: close=c, crowded=w, distant=d
8. gill-size: broad=b, narrow=n
9. gill-color: black=k, brown=n, buff=b, chocolate=h, gray=g, green=r, orange=o,
pink=p, purple=u, red=e, white=w, yellow=y
10. stalk-shape: enlarging=e, tapering=t
11. stalk-root: bulbous=b, club=c, cup=u, equal=e, rhizomorphs=z, rooted=r, missing=?
12. stalk-surface-above-ring: fibrous=f, scaly=y, silky=k, smooth=s
13. stalk-surface-below-ring: fibrous=f, scaly=y, silky=k, smooth=s
14. stalk-color-above-ring: brown=n, buff=b, cinnamon=c, gray=g, orange=o, pink=p,
red=e, white=w, yellow=y
15. stalk-color-below-ring: brown=n, buff=b, cinnamon=c, gray=g, orange=o, pink=p,
red=e, white=w, yellow=y
16. veil-type: partial=p, universal=u
17. veil-color: brown=n, orange=o, white=w, yellow=y
18. ring-number: none=n, one=o, two=t
19. ring-type: cobwebby=c, evanescent=e, flaring=f, large=l, none=n, pendant=p,
sheathing=s, zone=z
20. spore-print-color: black=k, brown=n, buff=b, chocolate=h, green=r, orange=o,
purple=u, white=w, yellow=y
21. population: abundant=a, clustered=c, numerous=n, scattered=s, several=v,
solitary=y
22. habitat: grasses=g, leaves=l, meadows=m, paths=p, urban=u, waste=w, woods=d
23. class: Edibility of mushroom whether it is edible (e) or poisonous (p)

# Data Cleaning
The first step in data preprocessing and one of the essential phases is data cleaning, to check data is clean without any duplicate values and there are no missing values. I performed missing value analysis for every feature; there were no missing values in any attribute. This process is analyzed with multiple functions and the results are attached in the screenshots.

# Data Preperation and Transformation
In this phase, we analyze the redundant or trivial features in our dataset that will add no value in analysis and for observations that are irrelevant. For example, features like unnecessary identifiers. As number of features is directly proportional to training time, so redundant features can slow down the training process. After analyzing there were no trivial, or redundant features in dataset and in the next stage of the preparation process I checked the levels of each attribute, the feature veil_type contains only one level called “partial” or ‘’p’’, so I removed this attribute, and it can also be noted in the table. Moreover, factor variables with only one level can create issues further on in modelling stage. R will throw out an error for categorical variable with one level. 
For data transformation, In this next step of pre-processing, we convert dataset in to factors to process it further. Moreover, we converted data into more understandable format, so it easy to train models.As we view our dataset, data is in character format, so we convert it into more meaningful value. So, for better understanding of the data, we rename each label and variable. This can be also useful for future understanding and results are attached. 

# Exploratory and Multivariate data analysis
In data exploration phase, we find the attributes that are exclusive in either class, so we have plotted the bar graph, as it is good way to represent categorical data and for this, we used histogram. It is plotted for each category and then we split them into two graphs according to their edibility. If exclusiveness is more, it suggests towards a stronger correlation among the attribute and edibility of the mushroom and moreover EDA is an important part of analysis as it indicates the quality of data.
For mulivariate analysis, I took two attributes to find their relationship with the class and how they contribute towards the edibility of the mushrooms. The choice of attributes is based upon the previous Chi-squared test. The attributes that are decided on based of test are odor with highest value, then spore print color, ring type, gill color, gill size, stalk surface above and below ring, stalk color above and below ring, and bruises.
The results of analysis are attached in the form of screenshots and observations are given as: 
## Obervation for Exploratory Data Analysis
Histograms are a part of bi-variate analysis. It is to be noted, that the observations made from these histograms may be questionable as the reason for this being the limitation of the histogram itself. These are the following observations that were made after analyzing histogram.
• No single attribute can serve as a deciding factor.
• If exclusiveness is high, it depicts that the attribute can strong contribution towards the edibility.
• There are some attributes which have no part in decision making, so it’s better to ignore them. This is technically termed as dimensionality reduction, and it helps in 
achieving better results and efficiency.
## Observation for Multivariate analysis
This analysis is for calculating the exclusiveness of two attributes taken together and to classify them as per the class of the mushroom whether edible or poisonous. In this approach, I have tried narrow down on the deciding factors based on the chi-squared test. These graphs depict the ambiguities and decisiveness based on two attributes together. The limitation to this analysis was that there were only one to two attributes, that contribute to measuring the decisiveness of mushroom edibility. Its important to get a holistic view, to understand the actual importance of each attribute and further on it is training model process to decide the edibility of mushroom.

# Results of Classification
I performed the model training by dividing the data and implemented Decision Tree and Random Forest to determine the edibility of the mushroom. After analyzing, the importance of attributes was clearly plotted, hence both models Decision Tree and Random Forest accurately classify the mushrooms. And the results suggest Random Forest is more accurate in predicting.

