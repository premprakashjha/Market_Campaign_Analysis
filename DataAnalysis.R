# -----------------------------
# Install & Load Required Packages
# -----------------------------
packages <- c("tidyverse", "caret", "randomForest", "corrplot", 
              "cluster", "factoextra", "pROC", "scales")

installed <- rownames(installed.packages())
to_install <- setdiff(packages, installed)

if(length(to_install) > 0) {
  install.packages(to_install)
}

lapply(packages, library, character.only = TRUE)

# -----------------------------
# Load Dataset
# -----------------------------
data <- read.csv("C:/Users/Mohit Kumar/Downloads/marketing_campaign.csv", sep = ";")

# -----------------------------
# Data Cleaning & Feature Engineering
# -----------------------------
# Remove NAs
data <- na.omit(data)

# Create new features
data$Age <- 2024 - data$Year_Birth
data$TotalSpend <- data$MntWines + data$MntFruits + data$MntMeatProducts + 
  data$MntFishProducts + data$MntSweetProducts + data$MntGoldProds

# Convert categorical variables
data$Education <- as.factor(data$Education)
data$Marital_Status <- as.factor(data$Marital_Status)
data$Response <- as.factor(data$Response)

# -----------------------------
# Exploratory Data Analysis (Analyst View)
# -----------------------------

# 1. Age distribution
ggplot(data, aes(x=Age)) + 
  geom_histogram(bins=30, fill="blue", color="white") +
  labs(title="Age Distribution of Customers", x="Age", y="Count")

# 2. Income vs Response
ggplot(data, aes(x=Response, y=Income, fill=Response)) + 
  geom_boxplot() +
  labs(title="Income Distribution by Response", x="Response", y="Income")

# 3. Correlation Matrix for numeric variables
num_cols <- data %>% select(Age, Income, TotalSpend, Recency)
corrplot(cor(num_cols), method="circle")

# 4. Customer Segmentation (KMeans)
cluster_data <- data %>% select(Age, Income, TotalSpend)
cluster_scaled <- scale(cluster_data)
set.seed(123)
kmeans_result <- kmeans(cluster_scaled, centers=3)
fviz_cluster(kmeans_result, data=cluster_scaled)

# -----------------------------
# Extra Graphs for Business/General Audience
# -----------------------------

# 5. Campaign Response Rate
ggplot(data, aes(x=Response, fill=Response)) +
  geom_bar() +
  labs(title="Campaign Response Rate", x="Response (0 = No, 1 = Yes)", y="Number of Customers")

# 6. Average Spending by Product Category
spend_data <- data %>%
  select(MntWines, MntFruits, MntMeatProducts, MntFishProducts, MntSweetProducts, MntGoldProds) %>%
  summarise_all(mean) %>%
  pivot_longer(cols = everything(), names_to = "Category", values_to = "AvgSpend")

ggplot(spend_data, aes(x=Category, y=AvgSpend, fill=Category)) +
  geom_col() +
  labs(title="Average Spending by Product Category", x="Product Category", y="Average Spend")

# 7. Income vs Spending
ggplot(data, aes(x=Income, y=TotalSpend)) +
  geom_point(alpha=0.5, color="blue") +
  geom_smooth(method="lm", se=FALSE, color="red") +
  labs(title="Income vs Total Spending", x="Income", y="Total Spend")

# 8. Response Rate by Marital Status
ggplot(data, aes(x=Marital_Status, fill=Response)) +
  geom_bar(position="fill") +
  scale_y_continuous(labels=scales::percent) +
  labs(title="Response Rate by Marital Status", x="Marital Status", y="Response Rate (%)")

# 9. Response Rate by Age Group
data$AgeGroup <- cut(data$Age, breaks=c(20,30,40,50,60,70,100), 
                     labels=c("20-29","30-39","40-49","50-59","60-69","70+"))

ggplot(data, aes(x=AgeGroup, fill=Response)) +
  geom_bar(position="fill") +
  scale_y_continuous(labels=scales::percent) +
  labs(title="Response Rate by Age Group", x="Age Group", y="Response Rate (%)")

# -----------------------------
# Models (Optional - already done earlier)
# -----------------------------

# Train/Test Split
set.seed(123)
trainIndex <- createDataPartition(data$Response, p=0.8, list=FALSE)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]

# Logistic Regression Model
log_model <- glm(Response ~ Age + Income + TotalSpend + Recency, data=train, family="binomial")
log_pred <- predict(log_model, newdata=test, type="response")
log_class <- ifelse(log_pred > 0.5, 1, 0)
confusionMatrix(as.factor(log_class), test$Response)

# ROC Curve
roc_curve <- roc(as.numeric(test$Response), log_pred)
plot(roc_curve, col="blue")

# Random Forest Model
rf_model <- randomForest(Response ~ Age + Income + TotalSpend + Recency, data=train, ntree=500)
rf_pred <- predict(rf_model, newdata=test)
confusionMatrix(rf_pred, test$Response)

