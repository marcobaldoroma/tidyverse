install.packages("tidygapminder")
install.packages("devtools")
devtools::install_github("ebedthan/tidygapminder")   # And the development version from GitHub with:

install.packages("gapminder")
install.packages("dplyr")

library(gapminder)  # explane the data inside the dataframe
library(dplyr)

gapminder   # dataset 

# filtering an object, %>% is named "PIPE"
gapminder %>% 
filter(year==2007, country=="United States")

# Filter for China in 2002
gapminder %>%
filter( year==2002, country=="China")

# subsetting and select the exact colunm you want.
# for example gdp percapita from the last to the first country in a determinate year..

gapminder %>%
filter(year==2007) %>%
arrange(desc(gdpPercap))

#Arranging observations by life expectancy
#You use arrange() to sort observations in ascending or descending order of a particular variable. In this case, you'll sort the dataset based on the lifeExp variable.

# Sort in ascending order of lifeExp
gapminder%>%
arrange(lifeExp)

# Sort in descending order of lifeExp
gapminder%>%
arrange(desc(lifeExp))

#Filtering and arranging
#You'll often need to use the pipe operator (%>%) to combine multiple dplyr verbs in a row. In this case, you'll combine a filter() with an arrange() to find the highest population countries in a particular year.

# Filter for the year 1957, then arrange in descending order of population

gapminder%>%
filter(year==1957)%>%
arrange(desc(pop))

# Filter for the year 1957, then arrange in ascending order of population

gapminder%>%
filter(year==1957)%>%
arrange(pop)

# Using mutate to change or create a column
# Suppose we want life expectancy to be measured in months instead of years: you'd have to multiply the existing value by 12. You can use the mutate() verb to change this column, or to create a new column that's calculated this way.

# Use mutate to change lifeExp to be in months
gapminder%>%
mutate(lifeExp = 12 * lifeExp)

# Use mutate to create a new column called lifeExpMonths
gapminder%>%
mutate(lifeExpMonths = 12 * lifeExp)

# Filter, mutate, and arrange the gapminder dataset

gapminder%>%
filter(year==2007)%>%
mutate(lifeExpMonths = 12 * lifeExp) %>%
arrange(desc(lifeExpMonths))

# Throughout the exercises in this chapter, you'll be visualizing a subset of the gapminder data from the year 1952. First, you'll have to load the ggplot2 package, and create a gapminder_1952 dataset to visualize.
# Create gapminder_1952
library(ggplot2)

gapminder_1952 <- gapminder %>%
filter(year==1952)

# Comparing population and GDP per capita: In the video you learned to create a scatter plot with GDP per capita on the x-axis and life expectancy on the y-axis (the code for that graph is shown here). When you're exploring data visually, you'll often need to try different combinations of variables and aesthetics.

# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()

# Comparing population and life expectancy: In this exercise, you'll use ggplot2 to create a scatter plot from scratch, to compare each country's population with its life expectancy in the year 1952.

ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()

# Putting the x-axis on a log scale: You previously created a scatter plot with population on the x-axis and life expectancy on the y-axis. Since population is spread over several orders of magnitude, with some countries having a much higher population than others, it's a good idea to put the x-axis on a log scale.
# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()
  
# Adding color to a scatter plot: In this lesson you learned how to use the color aesthetic, which can be used to show which continent each point in a scatter plot represents.

# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x=pop, y=lifeExp, col=continent)) +
geom_point() +
scale_x_log10()

# Adding size and color to a plot: In the last exercise, you created a scatter plot communicating information about each country's population, life expectancy, and continent. Now you'll use the size of the points to communicate even more.
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size=gdpPercap)) +
  geom_point() +
  scale_x_log10()
  
# Creating a subgraph for each continent: You've learned to use faceting to divide a graph into subplots based on one of its variables, such as the continent.
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)
  
# Faceting by year: All of the graphs in this chapter have been visualizing statistics within one year. Now that you're able to use faceting, however, you can create a graph showing all the country-level data from 1952 to 2007, to understand how global statistics have changed over time.
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col= continent, size=pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ year) 


################################ Chapter 3

# Summarizing the median life expectancy: You've seen how to find the mean life expectancy and the total population across a set of observations, but mean() and sum() are only two of the functions R provides for summarizing a collection of numbers. Here, you'll learn to use the median() function in combination with summarize(). This will occur in future exercises each time you load dplyr: it's mentioning some built-in functions that are overwritten by dplyr. You won't need to worry about this message within this course.
# Summarize to find the median life expectancy
gapminder%>%
summarize(medianLifeExp = median(lifeExp))

# Summarizing the median life expectancy in 1957: Rather than summarizing the entire dataset, you may want to find the median life expectancy for only one particular year. In this case, you'll find the median in the year 1957.

# Filter for 1957 then summarize the median life expectancy
gapminder %>%
filter(year==1957) %>%
summarize(medianLifeExp = median(lifeExp))

# Summarizing multiple variables in 1957: The summarize() verb allows you to summarize multiple variables at once. In this case, you'll use the median() function to find the median life expectancy and the max() function to find the maximum GDP per capita.

# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
filter(year==1957) %>%
summarize(medianLifeExp = median(lifeExp),
          maxGdpPercap = max(gdpPercap)) 

# Summarizing by year: In a previous exercise, you found the median life expectancy and the maximum GDP per capita in the year 1957. Now, you'll perform those two summaries within each year in the dataset, using the group_by verb.
# Find median life expectancy and maximum GDP per capita in each year
gapminder %>%
group_by(year) %>%
summarize(medianLifeExp = median(lifeExp),
          maxGdpPercap = max(gdpPercap)) 

# Summarizing by continent: You can group by any variable in your dataset to create a summary. Rather than comparing across time, you might be interested in comparing among continents. You'll want to do that within one year of the dataset: let's use 1957.
# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>%
filter(year==1957) %>%
group_by(continent) %>%
summarize(medianLifeExp = median(lifeExp),
          maxGdpPercap = max(gdpPercap)) 

# Summarizing by continent and year: Instead of grouping just by year, or just by continent, you'll now group by both continent and year to summarize within each.
# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder %>%
group_by(year, continent) %>%
summarize(medianLifeExp = median(lifeExp),
          maxGdpPercap = max(gdpPercap)) 

# Visualizing median life expectancy over time: In the last chapter, you summarized the gapminder data to calculate the median life expectancy within each year. This code is provided for you, and is saved (with <-) as the by_year dataset. Now you can use the ggplot2 package to turn this into a visualization of changing life expectancy over time.
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(x= year, y=medianLifeExp)) +
geom_point() +
expand_limits(y=0)


# Visualizing median GDP per capita per continent over time: In the last exercise you were able to see how the median life expectancy of countries changed over time. Now you'll examine the median GDP per capita instead, and see how the trend differs among continents.

# Summarize medianGdpPercap within each continent within each year: by_year_continent

by_year_continent <- gapminder %>%
group_by(year, continent) %>%
summarize(medianGdpPercap = median(gdpPercap))

by_year_continet

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x=year, y=continent, col=continet)) +
geom_point() +
expand_limits(y = 0)
















