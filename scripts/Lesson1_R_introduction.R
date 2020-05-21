# MEG_onboarding_tutorials 

# In this lesson we'll go over "Arithmetic operators", "Logic", and R "data types"

# R has built in functions like "sum()" and "mean()"
#If you're ever having trouble understanding what a function does, type ??function_name
?sum
?seq
?rep
?plot



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

#  & (means AND)
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
## Matrices
## Data frames
## Lists

# You can store these data types in an R object (or variable). 
# Variables are created by R when you first use them and space in your computer's memory is allocated to store that variable.
# Variables are case-sensitive 
# A small number of names are reserved and cannot be overwritten.
?reserved

# R has built in functions like "sum()" and "mean()"
#If you're ever having trouble understanding what a function does, type "?function_name"
?sum
?seq
?rep
?plot
?c()


# To assign a value to a constant, use the assignment operator <-. This is the default way of assigning values in R. 
# You could also use the = sign, but there are subtle differences. (See: ?"<-")

# Scalar objects only contain a single value
a <- 5 
a # If we run the variable alone, we get to see what it contains

a + 3
b <- 8
b
a + b  


# We can compare the contents of R variables
a == b # not assignment: equality test
a != b # not equal
a < b  # less than

rm(a) # Delete variables
a


# Vectors
# A vector is a sequence of data elements of the same basic type (i.e. numerical, character, logical)
# Group elements using "c()" 
Integer <-500      
Integer
a_vector <- c(5,2,7,3,integer)   #Assign a vector, including the variable "integer"
a_vector                 # Call/Print the vector
Double <- 9.865768   # Doubles: also known as "numeric"
Double
DoubleVector <- c(5.5,2.2,7.7,3.3,Double) # Assign the vector
DoubleVector

Char <- "Bioinformatics is easy peasy" # Create a variable with a "character" object
Char
CharVector <- c("Bioinformatics","is","easy","peasy") # We can combine several string objects by using "c()"
CharVector

truth <- ", not!" 

CharVector[4] <- truth # replace the fourth element in the vector
CharVector

paste(CharVector, collapse = ' ') # we can paste together the string elements add a space between strings using collapse = ''


# We can make be
Bool1 <- TRUE
Bool2 <- 1 #1 for TRUE or 0 for FALSE
Bool1
Bool2

#Try adding these together:
Integer + Double
Bool1 + Double
Bool2 + Double
Bool1 + Integer
Bool2 + Integer

# We can check the type of data using "class"
class(Bool1)

# Try adding these?
Char + Integer     #What's wrong with this?
Char + Bool2       #What's wrong with this one?!


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
selection_vector <- poker_vector < 0  # Is this right?

# Subset the winning days in "selection_vector" from the "poker_vector"
poker_winning_days <- poker_vector[selection_vector]

# We can sum all values in our poker_vector
sum(poker_vector) 

# How much money did we have after our crazy week of playing poker and roulette everyday?


# What were our average winnings? 


# Is it true that we made more money on poker every day than on roulette?
# Hint: think of comparing vectors




#
##
### Matrices
##
#

# A matrix is a collection of data elements arranged in a two-dimensional rectangular layout. 
# Same as vector, the components in a matrix must be of the same basic type. The following is an example of a matrix with 4 rows and 3 columns.

# Basic way to make an easy matrix
t <- matrix( 1:12,     # the data components (could be vector of values)
 nrow=4,               # number of rows
 ncol=3,               # number of columns
 byrow = FALSE)        # fill matrix by columns

t                      # print the matrix

# Below, we'll see how to combine vectors into a matrix
# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office, combines all movies
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, nrow=3,byrow=TRUE)
# Use RStudio "View" to see the matrix
View(star_wars_matrix)

## Sum values in the rows and output a vector
worldwide_vector <- rowSums(star_wars_matrix)
worldwide_vector

# Like vectors, we can subset parts of matrix
star_wars_matrix[1, 2] # view the value in the first row, second column

star_wars_matrix[1:2,] # Just view the first two rows of the matrix



#
##
### Data frames
##
#

# A data frame is more general than a matrix, in that different columns can have different basic data types.
# Data frame is the most common data type we use in R. In Lesson 1, Step 3 we'll go over how to read-in count matrices from bioinformatics analysis.

# Here's how you can make your own data frame from scratch
sample_ids <- c(1,2,3,4)
col <- c("red", "white", "red", NA)
results <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(sample_ids,col,results)
mydata # Notice the name of the columns correspond with the variables we used to make the dataframe

# We can change the column names to something more informative
names(mydata) <- c("ID","Color","Passed")      # variable names
mydata

# To better explore the data.frame, we can use "View"
View(mydata)

# Easily determine the number of columns and rows
dim(mydata)



#You can access elements similar to vectors!
#Syntax:   dataframe[ Row Number, Column Number ]
mydata[1,]
mydata[,1]
mydata[1,1]

#You can also access columns (Variables) by name!
#Syntax:    df$"Column Name"
mydata$ID
mydata$Color
mydata$Passed
mydata$ID[c(1,3)]    #Access the 1st and 3rd of the VECTOR that makes up the ID column

# What type of data is in the ID column?



#
##
### Lists
##
#

# A list is a generic vector containing other R objects. 
# There is no restriction on data types or length of the components.
# Lists are trickier to use, so we'll just introduce them here but don't worry about 

# T
n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 
b = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
combined_list = list(n, s, b, 3, mydata)   # x contains copies of n, s, b, the integer 3, and the dataframe we created above

# Try accessing some elements here
# We retrieve a list slice with the single square bracket "[]" operator. 

# The following is a slice containing the second member of x, which is a copy of s.
combined_list[2]

# With an index vector, we can retrieve a slice with multiple members. Here a slice containing the 2nd and fifth members of x.
combined_list[c(2,5)]

# In order to reference a list member directly, we have to use the double square bracket "[[]]" operator.
# The following object combined_list[[2]] is the second member of the list. While this was originally the "s" object, we now have a copy in the list
combined_list[[2]]

# We can edit the data directly
combined_list[[2]][1] = "ta" 
combined_list[[2]] 

# Did anything change with the orginal s object
s

# Another quick thing to consider, we can name the objects within the list
named_combined_list = list(integers = n, strings = s, boolean = b, single_int = 3, mydf = mydata) 

# Explore how this named list is different. Specifically, you can call objects in the list by their name.
named_combined_list[["mydf"]]


# Lists are notoriously hard to use. If you don't really get it, that's A OK, feel free to move on.




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


View(mydata)  #Reminder

#Select only data rows where the condition is TRUE
mydata[mydata$Passed == TRUE,]    

# Only pick the sample with ID #2
mydata[mydata$ID == 2,]    

# Pick out the row with the white color
mydata[mydata$Color == white,]    # Notice that we didn't use quotes with the other examples above, what is different about the values in the "Color" column


### Congratulations! If you weren't already, you are now officially a programmer!
