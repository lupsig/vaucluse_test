# Chargement des packages et laibrairies

#install.packages("RPostgreSQL", repos='http://cran.us.r-project.org')
library(RPostgreSQL)

# Connection a la base de donnees Postgres

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "lizmap",
				 host = "localhost", port = 5432,
				 user = "postgres", password = "postgres")

# Recuperation des colonnes de la table en BDD

data_sel <- dbGetQuery(con,
	 "
	SELECT * FROM poi84 WHERE fclass IN(SELECT fclass FROM poi84 GROUP BY fclass HAVING(COUNT(*) >100 ));
	")


head(data_sel, n=10)

### Analyse de variance
variance <- aov(occupation ~ fclass,
data=data_sel)
summary(variance) 

#install.packages("dplyr")
group_by(data_sel, fclass) %>%
		summarise(
			mean = mean(occupation, na.rm = TRUE),
		) 

