######## Basic statistics ######

#######Common functions

x<-c(1,1,1,1,2,3,4,5,6,7,8,8,8,9,10)
max(x)
mean(x)
median(x)
range(x)
quantile(x)
var(x)   #variance
sd(x)    #standard deviation
summary(x)  #Summary of x




#######Linear Regression
IndVar<-c(1,1,2,3,3,3,4,5,6,7,7,8,9,10,11,11,12,13,14,15)
DepVar<- 13 + IndVar*rnorm(20,1,0.25)     #DepVar has a slope is correlated with IndVar (therefore linear)
plot(IndVar,DepVar)     #Check out Linear relationship!
plot(DepVar~IndVar)     #Same plot, different syntax

#We know that IndVar and DepVar are linearly related... How to check?
#Least Squares of course!

LinReg1<- lm(IndVar~DepVar)   #It does the linear regression all for you!
summary(LinReg1)


A=c(rep("Yes",10),rep("No",15))
B=c(rep("Bloke",20),rep("Lady",5))

tab<-table(A,B)

#prop.table(table, dimension )         dimension is row (1) or columm (2)
prop.table(tab)   #Proportion of all entries in a given group (No or Yes, Lady or Bloke)
prop.table(tab,2)   #Proportion of Blokes/Ladies who said Yes/No
prop.table(tab,1)     #Proportion of people who said Yes/No who were Blokes/Ladies


########################################GGPLOT2################

Mydata<-data("ToothGrowth")

ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)



# Basic box plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot()
p


# Rotate the box plot
p + coord_flip()

# Notched box plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(notch=TRUE)

# Change outlier, color, shape and size
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)



p + scale_x_discrete(limits=c("0.5", "2"))    #Choose the x-axis notches


# Box plot with dot plot
p + geom_dotplot(binaxis='y', stackdir='center', dotsize=1)
# Box plot with jittered points
# 0.2 : degree of jitter in x direction
p + geom_jitter(shape=16, position=position_jitter(0.2))



# Change box plot line COLORS BY GROUPS
p<-ggplot(ToothGrowth, aes(x=dose, y=len, color=dose)) +
  geom_boxplot()
p

