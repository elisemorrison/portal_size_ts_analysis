#Morrison Assignment 10

library(DBI)
library(RSQLite)
library(ggplot2)

#1.1
#done

#1.2
conn<-dbConnect(SQLite(), "data/portal_mammals.sqlite")

#1.3
dbListTables(conn)

#1.4
dbListFields(conn, "plots")
dbListFields(conn, "surveys")

#1.5
DS_control<-'SELECT avg(weight) as average_weight, avg(hindfoot_length) as average_hindfoot_length
            FROM surveys JOIN plots
            ON surveys.plot_id = plots.plot_id
            JOIN species ON surveys.species_id = species.species_id
            WHERE species = "spectabilis" AND plot_type = "Control";'
DS_control_op<-dbGetQuery(conn, DS_control)
print(DS_control_op)

DS_control_male<-'SELECT avg(weight) as average_weight, avg(hindfoot_length) as average_hindfoot_length
                  FROM surveys JOIN plots 
                  ON surveys.plot_id = plots.plot_id
                  JOIN species ON surveys.species_id = species.species_id
                  WHERE species = "spectabilis" AND plot_type = "Control" AND sex = "M";'
DS_control_male_op<-dbGetQuery(conn, DS_control_male)
print(DS_control_male_op)

DS_control_female<-'SELECT avg(weight) as average_weight, avg(hindfoot_length) as average_hindfoot_length
                    FROM surveys JOIN plots
                    ON surveys.plot_id = plots.plot_id
                    JOIN species ON surveys.species_id = species.species_id
                    WHERE species = "spectabilis" AND plot_type = "Control" AND sex = "F";'
DS_control_female_op<-dbGetQuery(conn, DS_control_female)
print(DS_control_female_op)

#2
species_footlength_weight<-'SELECT species_id, sex, avg(weight) as avg_weight, avg(hindfoot_length) as avg_hindfoot_length
                    FROM surveys
                    WHERE sex IS NOT NULL
                    GROUP BY species_id;'
species_summary<-dbGetQuery(conn, species_footlength_weight)
print(species_summary)

#3.1 
conn<-dbConnect(SQLite(), "data/portal_mammals.sqlite")
#3.2
species_weight_by_year<-'SELECT year, species_id, avg(weight) as avg_weight 
                    FROM surveys JOIN plots
                    WHERE species_id IS NOT NULL
                    GROUP BY year;'
table_values<-dbGetQuery(conn, species_weight_by_year)
df_table_values<-data.frame(table_values)
head(df_table_values)

#3.3
dbWriteTable(conn, "Average_annual_species_weight", df_table_values)


#4.1
ordway_conn<-dbConnect(SQLite(), "data/ordway_mammals.sqlite")
dbListTables(ordway_conn)
dbListFields(ordway_conn, "traps")
dbListFields(conn, "surveys")


#4.2
disturbed_traps<-'SELECT COUNT(*) as count, plotID
                  FROM plots
                  WHERE disturbedTraps>0
                  GROUP BY plotID;'
disturbed_traps_count<-dbGetQuery(ordway_conn, disturbed_traps)
head(disturbed_traps_count)
qplot(x=plotID, y=count, data=disturbed_traps_count, geom="bar", stat="identity", ylab="Total No. of Traps Disturbed", xlab="Plot")
str(disturbed_traps_count)

#4.3
nlcdClass_data<-'SELECT scientificName, avg(weight) as average_weight, avg(hindfootLength) as average_hindfoot_length
            FROM capture
            WHERE nlcdClass = "woodyWetlands" AND weight IS NOT NULL
            GROUP BY scientificName;'
nlcdClass_all<-dbGetQuery(ordway_conn, nlcdClass_data)
str(nlcdClass_all)
head(nlcdClass_all)
qplot(x=scientificName, y=average_weight, data=nlcdClass_all, geom="bar", stat="identity", ylab="Average weight", xlab="Species Name")


