


# Dados ####
library(readr)

nomovariavel <- c("ID","ANO","DIA","HORA","VV_ane","DV_ane","PRP","P_atm","RFA_in","RFA_out","Roc_in","Roc_out",
                  "pirg_in","pirg_ref","R_lig","tpirg_in","tpirg_ref","T_ar","UR","Bat","SLO_flx","U_slo_1",
                  "U_sol_2","U_sol_3","U_sol_4","U_sol_5","U_sol_6","Tslo_02cm","Tslo_05cm","Tslo_10cm",
                  "Tslo_20cm","Tslo_50cm")


d01_FNS_AWS_11_001_0010_006_1630 <- read_csv("D:/Projetos/LBA_Certification_Project/Dados/2011_FNS_AWS/02. FNS_AWS_11_006(1640)_025(1600).dat", 
                                              col_names = nomovariavel, sep = ";",dec = ".", col_types = cols(X12 = col_double(), 
                                                                                  X27 = col_double(), X28 = col_double(), 
                                                                                  X29 = col_double(), X30 = col_double(), 
                                                                                  X31 = col_double(), X32 = col_double(), 
                                                                                  X5 = col_double(), X7 = col_double()), 
                                              locale = locale())
View(d01_FNS_AWS_11_001_0010_006_1630)


nomovariavel <- c("ID","ANO","DIA","HORA","VV_ane","DV_ane","PRP","P_atm","RFA_in","RFA_out","Roc_in","Roc_out",
                    "pirg_in","pirg_ref","R_lig","tpirg_in","tpirg_ref","T_ar","UR","Bat","SLO_flx","U_slo_1",
                    "U_sol_2","U_sol_3","U_sol_4","U_sol_5","U_sol_6","Tslo_02cm","Tslo_05cm","Tslo_10cm",
                    "Tslo_20cm","Tslo_50cm")


MyData <- read.csv(file="D:/LBA/Projeto_Certificação/Dados/2011_FNS_AWS/01.FNS_AWS_11_001(0010)_006(1630).dat", header=FALSE, sep=" ")
View(MyData)


data <- read.delim("D:/LBA/Projeto_Certificação/Dados/2011_FNS_AWS/02. FNS_AWS_11_006(1640)_025(1600).dat",
                header = FALSE, sep=",")

colnames(data) <- nomovariavel




# Create table ####


data_2011 <- "CREATE TABLE public."Dados_LBA_AWS_FNS_2011"
(
  ID bigint,
  ANO bigint,
  DIA bigint,
  HORA bigint,
  VV_ane double precision,
  DV_ane double precision,
  PRP double precision,
  P_atm double precision,
  RFA_in double precision,
  RFA_out double precision,
  Roc_in double precision,
  Roc_out double precision,
  pirg_in double precision,
  pirg_ref double precision,
  R_lig double precision,
  tpirg_in double precision,
  tpirg_ref double precision,
  T_ar double precision,
  UR double precision,
  SLO_flx	 double precision,
  U_slo_1 double precision,
  U_sol_2 double precision,
  U_sol_3 double precision,
  U_sol_4 double precision,
  U_sol_5 double precision,
  U_sol_6 double precision,
  Tslo_02cm double precision,
  Tslo_05cm double precision,
  Tslo_10cm double precision,
  Tslo_20cm double precision,
  Tslo_50cm double precision,
  Bat double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public."Dados_LBA_AWS_FNS_2011"
OWNER TO postgres;"

# sends the command and creates the table
dbGetQuery(con, sql_command)


# accessing table 

dados_2011 <- dbReadTable(con, 'Dados_LBA_AWS_FNS_2011')
View(dados_2011)
variable.names(dados_2011)

  # # creates df, a data.frame with the necessary columns
  # data(mtcars)
  # df <- data.frame(carname = rownames(mtcars), 
  #                  mtcars, 
  #                  row.names = NULL)
  # df$carname <- as.character(df$carname)
  # rm(mtcars)
  # 
  # # writes df to the PostgreSQL database "postgres", table "cartable" 
  dbWriteTable(con, "Dados_LBA_AWS_FNS_2011", 
              value = df, append = TRUE, row.names = TRUE)
   
  # # query the data from postgreSQL 
  dados_2011 <- dbGetQuery(con, "SELECT * from dados_lba_aws_fns_2011")
   
  # # compares the two data.frames
  # identical(df, df_postgres)
  # # TRUE
  # 
  # # Basic Graph of the Data
  # require(ggplot2)
  # ggplot(df_postgres, aes(x = as.factor(cyl), y = mpg, fill = as.factor(cyl))) + 
  #   geom_boxplot() + theme_bw()



### ext_tracks_widths ####

library(readr)

# Create a vector of the width of each column
ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)

# Create a vector of column names, based on the online documentation for this data
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                         "hour", "year", "latitude", "longitude",
                         "max_wind", "min_pressure", "rad_max_wind",
                         "eye_diameter", "pressure_1", "pressure_2",
                         paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                         "storm_type", "distance_to_land", "final")

# Read the file in from its url
ext_tracks <- read_fwf(ext_tracks_file, 
                       fwf_widths(ext_tracks_widths, ext_tracks_colnames),
                       na = "-99")
ext_tracks[1:3, 1:9]

