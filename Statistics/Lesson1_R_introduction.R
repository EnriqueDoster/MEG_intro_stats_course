# MEG_onboarding_tutorials 


#
##
### Arithmetic operators
##
#

5
5 + 3
5 + 1 / 2 # Think first: is this 3 or 5.5
3 * 2 + 1
3 * (2 + 1)
2^3 # Exponentiation
8 ^ (1/3) # Third root via exponentiation
7 %% 2  # Modulo operation (remainder of integer division)
7 %/% 2 # Integer division




#
##
### Logic
##
#


# Binary operators
1 == 1
1 != 1
1 != 2
1 < 2
1 > 2
1 <= 2 
1 >= 2

# Logical operators return TRUE or FALSE
#    Unary:
TRUE
FALSE
! TRUE  # read carefully: the "!" (meaning "not") is easily overlooked
! FALSE

#    & (means AND)
TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

#    | (means OR)
TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

# Predict what this will return
!(FALSE | (! FALSE))



#
##
### Data types
##
#
# Basic data types
# R Programming works with numerous data types, including:
## Scalars
## Vectors (numerical, character, logical)
## Lists
## Data frames
## Matrices

# You can store these data types in an R object (or variable). 
# Variables are created by R when you first use them and space in your computer's memory is allocated to store that variable.
# Variables are case-sensitive 
# A small number of names are reserved and cannot be overwritten.
?reserved

# To assign a value to a constant, use the assignment operator <-. This is the default way of assigning values in R. 
# You could also use the = sign, but there are subtle differences. (See: ?"<-")

# Scalar objects only contain a single value
a <- 5 
a
a + 3
b <- 8
b
a + b
a == b # not assignment: equality test
a != b # not equal
a < b  # less than

rm(a) # Delete variables
a


# Vectors
# A vector is a sequence of data elements of the same basic type (i.e. numerical, character, logical)
# Group elements using "c()" 
integer <-500      
integer
a_vector <- c(5,2,7,3,integer)   #Assign a vector, including the variable "integer"
a_vector                 # Call/Print the vector


Double <- 9.865768   # Doubles: also known as "numeric"
Double
DoubleVector <- c(5.5,2.2,7.7,3.3,Double) # Assign the vector
DoubleVector

Char <- "Bioinformatics is easy peasy" # Create a variable with a "character" object
Char
CharVector <- c("Bioinformatics","is","easy","peasy") #
CharVector

truth <- ", not!"

CharVector[4] <- truth # replace the fourth element in the vector
CharVector


Bool1<-TRUE
Bool2<-1 #1 for TRUE or 0 for FALSE
Bool1
Bool2
BoolVector<-c(TRUE,0,1,FALSE,T)
BoolVector


#Try adding these together:
Integer + Double
Bool1 + Double
Bool2 + Double
Bool1 + Integer
Bool2 + Integer
Char + Integer     #What's wrong with this?
Char + Bool2       #What's wrong with this one?!


#Add the Data Type Vectors together here:


#Add the Data Type Vectors together here:


## Naming and subsetting vectors
# Poker and roulette winnings from Monday to Friday:
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Select poker results for Monday, Tuesday and Wednesday
poker_start <- poker_vector[c("Monday", "Tuesday")]

# Which days did you make money on poker?
selection_vector <- poker_vector > 0

# Select from poker_vector these days
poker_winning_days <- poker_vector[selection_vector]


#
##
### Lists
##
#

#If you're ever having trouble understanding what a function does, type ??function_name
?list
?seq
?rep
?plot


Listy <- list(1,2,5,7,9,c(1,2,5,7,9),1:9,"Hello world!",rep("Hello World!",3))    #Lists can hold any data type
Listy
#In order to access elements of a list we use [] or [[]]
Listy[6]      #Calls "List Element" 6
Listy[[6]]        #Calls Value of "List Element" 6
Listy[6][1]           #Calls Index 1 of "List Element" 6
Listy[[6]][1:3]           #Calls Indices 1 thru 3 of Values of "List Element 6"


#Lists can even hold ANY DATA STRUCTURE. THEY CAN EVEN HOLD PLOTS. OR MORE LISTS!

#Just a making a plot! More on this later.
df<-data.frame(Int=IntegerVector,Dub=DoubleVector)
plotty<-ggplot(data=df,aes(x=Int,y=Dub)) + geom_point(color="cyan") + ggtitle("ExamplePlot") +
  xlab("Integers") + ylab("Doubles") + theme(plot.title = element_text(hjust = 0.5))
plotty
#A simple plot to be stored in list


ListPrime<-list(Listy,list(plotty,c(1,2,3,4,5)))      
ListPrime

#Try accessing some elements here


#Lists are notoriously hard to use. If you don't really get it, that's A OK, feel free to move on.



#
##
### Data frames
##
#

df<-data.frame(Variable1=21:40, Variable2= rep(seq(2,10,by=2),4), Category1= rep(c("Jesse","Is","A","Cool","Guy"),4),stringsAsFactors = FALSE)
df        #How does this look?
View(df)  #How does THIS look?

?dim
?class


#You can access elements similar to vectors!
#Syntax:   df[ Row Number, Column Number ]
df[1,]
df[,1]
df[1,1]

#You can also access columns (Variables) by name!
#Syntax:    df$"Column Name"
df$Variable1
df$Variable2
df$Category1
df$Category1[c(1,3,5)]    #Accessing the 1st, 3rd, and 5th element of the VECTOR df$Category1

class(df$Variable1) #What is Variable2?

#We can also change data as follows:
df[c(3,8,13,18),3] <- rep("An",4)
df[c(4,9,14,19),3] <- rep("Uncool",4)



#
##
### Matrices
##
#

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office, combines all movies
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, nrow=3,byrow=TRUE)

worldwide_vector <- rowSums(star_wars_matrix)

#########  Logical Subsetting #####
#We can use logic to group data according to certain conditions!
x<- c(1:5,5,9)
y<- c(2:6,4,9)

x < y     #Applies the Logical "Question" point-by-point. x1 < y1, x2 < y2, etc.

#AND, OR, NOT
z<-c(3:7,3,9)

!(x < y)  & (x==z)    #BOTH conditions must be true
(x == y) | (z != 6)   #EITHER condition must be true
!((x <= y)  & (x==z)) #NEITHER condition must be true

#%in%
#is a value WITHIN this vector?
9 %in% x
6 %in% x
6 %in% y




View(df)  #Reminder

#Select only data where the condition is TRUE
df[df$Variable1<35,]    #column AFTER conditional
df[df$Variable2!=10,]
df$Category1[df$Variable1<=35,]   #Can be used on Columns too!


#These can be read like:
#Dataframe df SUCH THAT values of Variable1 of df are less than 35
#Dataframe df SUCH THAT values of Variable2 of df are not equal to 10
#Column Category1 of dataframe df SUCH THAT values of Variable1 are less than or equal to 35





### Congratulations! If you weren't already, you are now officially a programmer!
