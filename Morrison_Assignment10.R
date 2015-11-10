#Assignment 10
library(DBI)
library(RSQLite)
conn<-dbConnect(SQLite(), "data/portal_mammals.sqlite")

#1.1
#done

#1.2
#done

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