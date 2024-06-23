
# Required libraries
pacs <- c("tidyverse", "readxl", "lubridate", "tableone", "gridExtra", "survival")
sapply(pacs, require, character.only = TRUE)


# Medicare crosswalk ------------------------------------------------------

# Read crosswalk file: n = 70.968
crosswalk <- read_fwf("./Data/12172/2022/ssn_bene_xwalk_res000058038_req012172_2022.dat",
                      fwf_widths(c(9, 15, 1, 1, 1), c("ORIG_SSN", "BENE_ID", "SSN_MATCH", "SEX_MATCH", "DOB_MATCH")))

# How many matches? -- 52,704 subjects (74%)
# There were 115 invalid SSN
crosswalk %>% 
  group_by(SSN_MATCH) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Gender mismatch -- 824 subjects (1.6%)
crosswalk %>% 
  filter(SSN_MATCH == 1) %>% 
  group_by(SEX_MATCH) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# DOB mismatch -- 3331 subjects (6.3%)
crosswalk %>% 
  filter(SSN_MATCH == 1) %>% 
  group_by(DOB_MATCH) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# How many have both gender and DOB mismatch -- 787 subjects (1.5%)
crosswalk %>% 
  filter(SSN_MATCH == 1, SEX_MATCH == 0, DOB_MATCH == 0) %>%
  nrow()

# How many have either gender OR DOB mismatch -- 3368 subjects (6.4%)
crosswalk %>% 
  filter(SSN_MATCH == 1 & (SEX_MATCH == 0 | DOB_MATCH == 0)) %>%
  nrow()

# Extract matched BENE_IDs
all_matched_bene_ids <- crosswalk %>% 
  filter(SSN_MATCH == 1)

# BENE_IDs of gender or DOB mismatch (to be removed)
mismatches <- crosswalk %>% 
  filter(SSN_MATCH == 1 & (SEX_MATCH == 0 | DOB_MATCH == 0)) %>%
  select(BENE_ID)
  
# There are two duplicates in BENE_IDs...
all_matched_bene_ids %>% 
  summarize(n = n_distinct(BENE_ID))

dup_BENE_IDs <- all_matched_bene_ids %>% 
  group_by(BENE_ID) %>% 
  summarize(n = sum(n())) %>% 
  filter(n > 1)

all_matched_bene_ids %>% 
  filter(BENE_ID %in% dup_BENE_IDs$BENE_ID)

# There are 106 SSN duplicates ???
all_matched_bene_ids %>% 
  summarize(n = n_distinct(ORIG_SSN))

dup_SSNs <- all_matched_bene_ids %>% 
  group_by(ORIG_SSN) %>% 
  summarize(n = sum(n())) %>% 
  filter(n > 1)

all_matched_bene_ids %>% 
  filter(ORIG_SSN %in% dup_SSNs$ORIG_SSN)

# BENE_IDs that need to be removed:
# Gender/DOB mismatch
# SSN/BENE_ID duplicates
exclude_BENE_IDs <- dup_BENE_IDs %>% 
  select(BENE_ID) %>% 
  union(all_matched_bene_ids %>% 
          filter(ORIG_SSN %in% dup_SSNs$ORIG_SSN) %>% 
          select(BENE_ID)
  ) %>% 
  union(mismatches)

# 3571 BENE_IDs to be removed
length(unique(exclude_BENE_IDs$BENE_ID))


# Medicare MSBF file ------------------------------------------------------

# Read MBSF Summary data on each year
# Data specification of MSBF files
fts_msbf <- read_excel("./Data/mbsf_format.xlsx")

# Create file names
year <- 2008:2020
fname <- paste0("./Data/12172/", year, "/mbsf_abcd_summary_res000058038_req012172_", year, ".dat")

# Read all MSBF files of 13 years
all_msbf <- fname %>% 
  lapply(\(x) read_fwf(x, fwf_widths(fts_msbf$length, fts_msbf$long_name))) %>% 
  lapply(\(x) anti_join(x, exclude_BENE_IDs)) %>% 
  setNames(year)

all_msbf %>% sapply(nrow)

# Long format over years
all_msbf_long <- all_msbf %>% 
  do.call(rbind, .) %>% 
  arrange(BENE_ID, BENE_ENROLLMT_REF_YR)

# Num of beneficiaries each year
all_msbf_long %>% 
  group_by(BENE_ENROLLMT_REF_YR) %>% 
  tally()

# Unique beneficiaries across years: n = 44,585
all_msbf_bene_ids <- all_msbf_long %>% 
  select(BENE_ID) %>% 
  distinct()

nrow(all_msbf_bene_ids)

all_msbf_bene_ids %>% 
  left_join(crosswalk, by = "BENE_ID")

# 4546 matched beneficiaries were never appeared in MSBF files
bene_ids_no_show <- all_matched_bene_ids %>% 
  anti_join(exclude_BENE_IDs) %>% 
  anti_join(all_msbf_bene_ids)

nrow(bene_ids_no_show)

# Age at the last year of appearance
all_msbf_long %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  mutate(AgeCat = cut(AGE_AT_END_REF_YR, breaks = c(0, 3:12 * 10), right = FALSE)) %>% 
  group_by(AgeCat) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Young medicare beneficiaries: What is the reason for entitlement?
# Mostly due to disability (~95%)
all_msbf_long %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  filter(AGE_AT_END_REF_YR < 65) %>% 
  select(BENE_ID, BENE_ENROLLMT_REF_YR, AGE_AT_END_REF_YR, ENTLMT_RSN_CURR) %>% 
  group_by(ENTLMT_RSN_CURR) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Current Reason for Entitlement Code
all_msbf_long %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  mutate(ENTLMT_RSN_CURR = factor(ENTLMT_RSN_CURR, levels = 0:3, labels = c("OASI", "DIB", "ESRD", "DIB & ESRD"))) %>% 
  group_by(ENTLMT_RSN_CURR) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Sex/race at the last year of appearance
all_msbf_long %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  group_by(SEX_IDENT_CD) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# How many died during 2008-2020
# 13,218 (29.6%) died
all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  mutate(Dead = ifelse(is.na(BENE_DEATH_DT), 0, 1),
         Dead = factor(Dead, levels = 0:1, labels = c("Alive", "Dead"))) %>% 
  group_by(Dead) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# N deaths = 13,218
n_deaths <- all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  filter(!is.na(BENE_DEATH_DT)) %>% nrow()

all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  mutate(year_died = substr(BENE_DEATH_DT, 1, 4)) %>% 
  group_by(year_died) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)


# Medicare chronic condition file -----------------------------------------

# Read chronic conditions data on each year
# Data specification of CC files
fts_cc <- read_excel("./Data/mbsf_cc_format.xlsx")

# Create file names
year <- 2008:2020
fname <- paste0("./Data/12172/", year, "/mbsf_cc_summary_res000058038_req012172_", year, ".dat")

# Read all MSBF files of 13 years
all_cc <- fname %>% 
  lapply(\(x) read_fwf(x, fwf_widths(fts_cc$length, fts_cc$long_name))) %>% 
  lapply(\(x) anti_join(x, exclude_BENE_IDs)) %>% 
  setNames(year)

# Long format over years
all_cc_long <- all_cc %>% 
  do.call(rbind, .) %>% 
  arrange(BENE_ID, BENE_ENROLLMT_REF_YR)

# Num of beneficiaries each year
all_cc_long %>% 
  group_by(BENE_ENROLLMT_REF_YR) %>% 
  tally()

# Unique beneficiaries across years: n = 44,585
all_cc_bene_ids <- all_cc_long %>% 
  select(BENE_ID) %>% 
  distinct()

nrow(all_cc_bene_ids)

# Hyperlipidemia status at the last year of appearance
# Have hyperlipidemia: n = 23,685 (53.1%)
all_cc_long %>% 
  mutate(HYPERL_YN    = ifelse(is.na(HYPERL_EVER), 0, 1)) %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  group_by(HYPERL_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100) 

# Year of hyperlipidemia diagnosis at the last year of appearance
all_cc_long %>% 
  filter(!is.na(HYPERL_EVER)) %>% 
  mutate(HYPERL_DX_YR = substr(HYPERL_EVER, 1, 4)) %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  group_by(HYPERL_DX_YR) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100) %>% 
  print(n = Inf)

# AHS-2 Medicare link file ------------------------------------------------

# AHS-2 analysis ID: N = 51,917
ahs <- read_csv("./Data/MedicareMatches2022.csv")

# There are 103 analysis IDs that appears twice
# There are 226 NULL values on analysis ID
ahs %>% 
  group_by(AnalysisID) %>%
  tally() %>% 
  filter(n > 1) %>% 
  print(n = Inf)

ahs %>% filter(AnalysisID == "NULL")

# Remove NULL and those appears twice
ahs %>% 
  group_by(AnalysisID) %>%
  tally() %>% 
  filter(n > 1) %>% 
  summarize(sum = sum(n))

ahs %>% 
  group_by(AnalysisID) %>%
  tally() %>% 
  filter(n > 1) %>% 
  print(n = Inf)
 
# 104 analysis IDs (103 duplicates + NAs) to be removed
exclude_analysisIDs <- ahs %>% 
  group_by(AnalysisID) %>%
  tally() %>% 
  filter(n > 1) %>%
  select(AnalysisID)

exclude_analysisIDs %>% print(n = Inf)

# 432 rows removed (103 * 2 + 226)
# yielding 51,485 unique analysis ID (and unique Bene_IDs)
ahs_dup_removed <- ahs %>% anti_join(exclude_analysisIDs)
ahs_dup_removed %>% distinct(Bene_ID) %>% nrow() 


# AHS-2 data --------------------------------------------------------------

# N = 96,144
ahsdata <- read.csv("./Data/BaselineDataForMedicare20190531.csv", header=TRUE)
names(ahsdata) <- tolower(names(ahsdata))

# Remove those with missing analysis ID
# Calculate birth date and age in 2010
ahsdata <- 
  ahsdata %>% 
  filter(!is.na(analysisid)) %>% 
  mutate(mob         = ifelse(mob > 12, NA, mob),
         dob         = ifelse(dob > 31, NA, dob),
         yob         = ifelse(yob >= 9999, NA, yob),
         bdate       = as.Date(paste(yob, mob, dob, sep="-")),
         qreturndate = as.Date(qreturndate),
         agein       = as.numeric((qreturndate - bdate) / 365.242),
         age2010     = floor(as.numeric((as.Date("2010-12-31") - bdate) / 365.242)),
         age2011     = floor(as.numeric((as.Date("2011-12-31") - bdate) / 365.242)),
         deceased    = as.Date(deceased, format = "%Y-%m-%d"))

# Convert to numeric
ahsdata <- ahsdata %>% 
  mutate_at(vars(eggbetrf:educyou, incomeh:alcnow, cancer, anginay:a05q9, sleephrs:walkruna), 
            function(x) as.numeric(as.character(x)))

# Calculate BMI and BMI category
ahsdata <- ahsdata %>% 
  mutate(heighti = ifelse(heighti > 11, NA, heighti),
         bmi     = weight / (heightf * 12 + heighti) ^ 2 * 702,
         # bmicat  = cut(bmi, breaks = c(0, 18.5, 25, 30, Inf), right = FALSE),
         bmicat  = cut(bmi, breaks = c(0, 25, 30, Inf), right = FALSE),
         # bmicat  = factor(bmicat, labels = c("Underweight", "Normal", "Overweight", "Obese")))
         bmicat  = factor(bmicat, labels = c("Normal", "Overweight", "Obese")))

# Recode marital statas, education and sleep
ahsdata <- ahsdata %>% 
  mutate(marital   = recode(marital, "Never", "Married", "Married", "Married", "Div/Wid", "Div/Wid", "Div/Wid"),
         marital   = factor(marital, levels = c("Married", "Never", "Div/Wid")),
         educyou   = recode(educyou, "HS or less",   "HS or less",   "HS or less", 
                                     "Some college", "Some college", "Some college", 
                                     "Col grad+",    "Col grad+",    "Col grad+"),
         educyou   = factor(educyou, levels = c("HS or less", "Some college", "Col grad+")),
         educyou2  = relevel(educyou, ref = "Col grad+"),
         sleephrs  = recode(sleephrs, "<= 5 hrs", "<= 5 hrs", "<= 5 hrs", "6 hrs", "7 hrs",  
                                      "8 hrs", ">= 9 hrs", ">= 9 hrs", ">= 9 hrs"),
         sleephrs  = factor(sleephrs, levels = c("<= 5 hrs", "6 hrs", "7 hrs", "8 hrs", ">= 9 hrs")),
         sleephrs2 = relevel(sleephrs, ref = "7 hrs"))

# Dietary pattern
ahsdata$vegstat <- factor(ahsdata$vegstat, labels=c("Vegan", "Lacto-ovo",  "Semi", "Pesco", "Non-veg"))

# Physical activity
test <- ahsdata %>% 
  mutate(times    = walkrunf - 1,
         duration = recode(exeramt, 0, 5, 15, 25, 35, 45, 55, 60),
         minutes  = recode(walkruna, 5, 15, 25, 35, 45, 55, 60),
         distance = recode(walkrund, 0.25, 0.5, 1, 1.5, 2, 3, 4),
         vigofreq = ifelse(exerfreq - 2 < 0, 0, exerfreq - 2),
         ex4b4c   = times * distance,
         ex4b4d   = times * minutes,
         ex3a3b   = vigofreq * duration)

test <- test %>% 
  mutate(none = ifelse((ex3a3b == 0 & (walkrun == 2 | is.na(walkrun))) | 
                       (ex3a3b == 0 & times == 0) | (vigofreq == 0 & walkrun == 2), 1, 0),
         low  = ifelse((0 < ex3a3b & ex3a3b < 105) | (0 < ex4b4d & ex4b4d < 105) | (0 < ex4b4c & ex4b4c < 3), 1, 0),
         mid  = ifelse(ex3a3b >= 105 | (105 <= ex4b4d & ex4b4d < 175) | (3 <= ex4b4c & ex4b4c < 9), 1, 0),
         hi   = ifelse(ex4b4d >= 175 | ex4b4c >= 9, 1, 0))

ahsdata$exercise[test$none == 1] <- 1
ahsdata$exercise[test$low  == 1] <- 2
ahsdata$exercise[test$mid  == 1] <- 3
ahsdata$exercise[test$hi   == 1] <- 4
ahsdata$exercise <- factor(ahsdata$exercise, labels=c("None", "Low", "Moderate", "Vigorous"))
rm(test)

# agein
summary(ahsdata$agein)
ahsdata %>% 
  filter(!is.na(agein)) %>% 
  mutate(cagein = cut(agein, breaks = c(24, 30, 40, 50, 60, 70, 80, 90, Inf), right = FALSE)) %>% 
  group_by(cagein) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100,
         cumpct = cumsum(pct))

# AHS-2 dietary data ------------------------------------------------------

# N = 91099 obs, 105 variables
ahsdiet0 <- read.csv("./Data/MEDC_DMENT-FULL-20191008-0.csv", header = TRUE)
dim(ahsdiet0)

# N = 4498 obs, 105 variables
ahsdiet_ex <- read.csv("./Data/MEDC_DMENT-FULL-EXCLUDED-20191008-0.csv", header = TRUE)
dim(ahsdiet_ex)

# Concatenate two dfs
ahsdiet <- ahsdiet0 %>% bind_rows(ahsdiet_ex)
names(ahsdiet) <- tolower(names(ahsdiet))
ahsdiet$bmi <- NULL

# Merge AHS data with Medicare --------------------------------------------

# Extract data of the last seen: MSBF and CC files  
msbf_last_seen <- all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n())

cc_last_seen <- all_cc_long %>%
  group_by(BENE_ID) %>% 
  slice(n())

# Merge AHS data with Medicare
# Results in n = 44,384 subjects
ahs_medic <- msbf_last_seen %>% 
  inner_join(cc_last_seen %>% select(-BENE_ENROLLMT_REF_YR), by = "BENE_ID") %>%
  inner_join(ahs_dup_removed %>% 
               rename(BENE_ID = Bene_ID) %>% 
               mutate(analysisid = parse_number(AnalysisID)), by = "BENE_ID") %>% 
  inner_join(ahsdata, by = "analysisid") %>% 
  left_join(ahsdiet, by = "analysisid") %>% 
  ungroup()


# Apply inclusion/exclusion criteria --------------------------------------

# Remove if qreturndate is missing -- 25 subjects
ahs_medic %>%
  summarize(n = sum(is.na(qreturndate)))

# Results in n = 44,359 subjects
ahs_medic <- ahs_medic %>% 
  filter(!is.na(qreturndate))

# Remove if AGE_AT_END_REF_YR < 65 (n = 1545)
# Results in n = 42,814
ahs_medic %>% 
  filter(AGE_AT_END_REF_YR < 65) %>% 
  nrow()
  
ahs_medic %>% 
  filter(AGE_AT_END_REF_YR < 65) %>% 
  select(AGE_AT_END_REF_YR) %>% 
  group_by(AGE_AT_END_REF_YR) %>% 
  tally() %>% 
  print(n = Inf)

ahs_medic <- ahs_medic %>% 
  filter(AGE_AT_END_REF_YR >= 65)

# Remove if BMI is missing (n = 1174) or extreme (n = 148)
# Resuts in n = 41,492
ahs_medic %>% filter(is.na(bmi)) %>% tally()
ahs_medic %>% filter(bmi < 16 | bmi > 60) %>% tally()
ahs_medic %>% filter(bmi < 16 | bmi > 60 | is.na(bmi)) %>% tally()
ahs_medic <- ahs_medic %>% 
  filter(bmi >= 16, bmi <= 60)

# Exclude missing kcal/diet (n = 97) or extreme kcal intake (n = 1039)
# Results in n = 40,356
ahs_medic %>% filter(is.na(kcal)) %>% tally()
ahs_medic %>% filter(!(kcal > 500 & kcal < 4500)) %>% tally()
ahs_medic <- ahs_medic %>% 
  filter(kcal > 500 & kcal < 4500)

# Check deaths
ahs_medic %>% 
  filter(!is.na(BENE_DEATH_DT)) %>% 
  select(BENE_DEATH_DT, deceased) %>% 
  filter(BENE_DEATH_DT != deceased) %>% 
  print(n = Inf)

# Do not use "deceased" variable!
ahs_medic %>% 
  filter(!is.na(deceased), !is.na(HYPERL_EVER)) %>% 
  select(HYPERL_EVER, BENE_DEATH_DT, deceased) %>% 
  filter(deceased < HYPERL_EVER)

# Need to exclude unverified deaths
# There are 22 unverified deaths
ahs_medic %>% 
  filter(!is.na(BENE_DEATH_DT)) %>% 
  group_by(VALID_DEATH_DT_SW) %>% 
  tally()

unverified_deaths <- ahs_medic %>% 
  filter(!is.na(BENE_DEATH_DT)) %>%
  filter(is.na(VALID_DEATH_DT_SW)) %>% 
  select(analysisid)

# Exclude unverified deaths
# Yields n = 40,334
ahs_medic <- ahs_medic %>% 
  anti_join(unverified_deaths, by = "analysisid") 

nrow(ahs_medic)

# Identify hyperlipidemia cases -------------------------------------------

# Identify those with hyperlipidemia
# Both prevalence and incidence
ahs_medic <- ahs_medic %>% 
  mutate(HYPERL_YN = ifelse(is.na(HYPERL_EVER), 0, 1),
         HYPERL_YN = factor(HYPERL_YN, label = c("No", "Yes")),  
         BENE_BIRTH_DT = ymd(BENE_BIRTH_DT),
         BENE_DEATH_DT = ymd(BENE_DEATH_DT),
         HYPERL_EVER = ymd(HYPERL_EVER))

# There are 21,635 hyperlipidemia cases (53.6%)
ahs_medic %>%
  group_by(HYPERL_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Find prevalent cases
ahs_medic %>% 
  filter(HYPERL_YN == "Yes") %>% 
  mutate(HYPERL_EVER = ymd(HYPERL_EVER)) %>%
  filter(HYPERL_EVER < qreturndate) %>% 
  select(analysisid, HYPERL_YN, qreturndate, HYPERL_EVER)

hyperl_diag_date <- ahs_medic %>% 
  filter(HYPERL_YN == "Yes") %>% 
  mutate(HYPERL_EVER = ymd(HYPERL_EVER)) %>%
  mutate(DateDiff = interval(qreturndate, HYPERL_EVER),
         DateDiff_days = as.numeric(DateDiff, 'days'), 
         DateDiff_months = as.numeric(DateDiff, 'months'), 
         DateDiff_years = as.numeric(DateDiff, 'years')) 

# How many cases in which qreturndate > diagnosis date?
# 6,491 such cases
hyperl_diag_date %>% 
  filter(DateDiff_days < 0) %>% 
  select(HYPERL_YN, HYPERL_EVER, qreturndate, DateDiff_days, DateDiff_months, DateDiff_years)

# How many cases who were diagnosed within 6 months after qreturndate?
# 647 cases
hyperl_diag_date %>% 
  filter(between(DateDiff_months, 0, 6)) %>% 
  select(HYPERL_YN, qreturndate, HYPERL_EVER, DateDiff_days, DateDiff_months, DateDiff_years)

# Considering 6 months as a cut-off, there are 7,138 prevalent cases
hyperl_diag_date %>% 
  filter(DateDiff_months <= 6) %>% 
  select(BENE_ID, analysisid, HYPERL_YN, qreturndate, HYPERL_EVER, DateDiff_days, DateDiff_months, DateDiff_years)

# Hyperlipidemia -- use as time-dependent variable in the cox model?
# Or only include anyone with the diagnoses regardless of prevalence/incidence


# Define CVD cases --------------------------------------------------------

names(ahs_medic) %>% grep("_EVER", ., value = TRUE)
cvd_vars <- c("ISCHEMICHEART_EVER", "STROKE_TIA_EVER", "AMI_EVER", "CHF_EVER", "ATRIAL_FIB_EVER")

ahs_medic %>% select(all_of(cvd_vars))

cvd_df <- ahs_medic %>% 
  select(all_of(cvd_vars)) %>% 
  mutate_all(ymd) %>% 
  mutate_all(\(x) ifelse(is.na(x), "No", "Yes"))

cvd_vars %>% 
  lapply(\(x) group_by(cvd_df, .data[[x]]) %>% tally() %>% mutate(pct = n / sum(n) * 100))


# Based on ischemic HD, stroke, MI, CHF and Afib
ahs_medic2 <- ahs_medic %>% 
  # mutate(CVD_EVER = pmin(ISCHEMICHEART_EVER, STROKE_TIA_EVER, AMI_EVER, na.rm = TRUE),
  mutate(CVD_EVER = pmin(ISCHEMICHEART_EVER, STROKE_TIA_EVER, AMI_EVER, CHF_EVER, ATRIAL_FIB_EVER, na.rm = TRUE),
         CVD_EVER = ymd(CVD_EVER), 
         CVD_YN = ifelse(is.na(CVD_EVER), 0, 1),
         CVD_YN = factor(CVD_YN, labels = c("No", "Yes")))

ahs_medic2 %>% 
  group_by(CVD_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Find prevalent cases
ahs_medic2 %>% 
  filter(CVD_YN == "Yes") %>% 
  filter(CVD_EVER < qreturndate) %>% 
  select(analysisid, CVD_YN, qreturndate, CVD_EVER)

cvd_diag_date <- ahs_medic2 %>% 
  filter(CVD_YN == "Yes") %>% 
  mutate(DateDiff = interval(qreturndate, CVD_EVER),
         DateDiff_days = as.numeric(DateDiff, 'days'), 
         DateDiff_months = as.numeric(DateDiff, 'months'), 
         DateDiff_years = as.numeric(DateDiff, 'years')) 

# How many cases in which qreturndate > diagnosis date?
# 5,315 such cases
cvd_diag_date %>% 
  filter(DateDiff_days < 0) %>% 
  select(analysisid, CVD_YN, CVD_EVER, qreturndate, DateDiff_days, DateDiff_months, DateDiff_years)

prev_cvd <- cvd_diag_date %>% 
  filter(DateDiff_days < 0) %>% 
  select(analysisid)

ahs_medic2 %>% 
  anti_join(prev_cvd) %>% 
  group_by(CVD_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Start with all 5 conditions combined and then explore individual conditions as sensitivity analysis











# Define variables for models ---------------------------------------------

# Define ageout
# If ALZH_DEMEN_EVER exists (incident cases), the use this diag date
# If non-case and BENE_DEATH_DT exists, then use this date died (censored)
# Otherwise, use the end of BENE_ENROLLMT_REF_YR (year last seen)
ahs_medic_inc2 <- ahs_medic_inc %>% 
  mutate(
    age_last_seen = time_length(interval(BENE_BIRTH_DT, make_date(BENE_ENROLLMT_REF_YR, 12, 31)), "year"),
    ageout = case_when(
              ALZH_DEMEN_YN == "Yes" ~ time_length(interval(BENE_BIRTH_DT, ALZH_DEMEN_EVER), "year"),
              ALZH_DEMEN_YN == "No" & !is.na(BENE_DEATH_DT)  ~ time_length(interval(BENE_BIRTH_DT, BENE_DEATH_DT), "year"),
              ALZH_DEMEN_YN == "No" &  is.na(BENE_DEATH_DT)  ~ age_last_seen),
    fuyear = ageout - agein
  )

summary(ahs_medic_inc2$agein)
summary(ahs_medic_inc2$ageout)

# Mean/median follow-up years: Mean 14.8 years, Median 16.5 years
summary(ahs_medic_inc2$fuyear) %>% round(2)

# Age at diagnosis: Mean 83.2 years, Median 84.0 years
ahs_medic_inc2 %>% 
  filter(ALZH_DEMEN_YN == "Yes") %>% 
  select(ageout) %>% 
  summary()

# Factor gender, categorize age into age groups, recode RTI race, smoking, and drinking
ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  mutate(
    bene_sex_F = factor(SEX_IDENT_CD, labels = c("M", "F")),
    # bene_age_at_end_2008 = time_length(interval(BENE_BIRTH_DT, make_date(2008, 12, 31)), "year"),
    bene_age_at_end_2020 = time_length(interval(BENE_BIRTH_DT, make_date(2020, 12, 31)), "year"),
    # agecat     = cut(bene_age_at_end_2008, breaks = c(50, 60, 65, 70, 75, 80, 85, 120), right = FALSE),
    # agecat     = factor(agecat, labels = c("<60", "60-64", "65-69", "70-74", "75-79", "80-84", "85+")),
    agecat     = cut(bene_age_at_end_2020, breaks = c(65, 70, 75, 80, 85, 90, 95, 130), right = FALSE),
    agecat     = factor(agecat, labels = c("65-69", "70-74", "75-79", "80-84", "85-89", "90-94", "95+")),
    rti_race3  = recode(RTI_RACE_CD + 1, 3, 1, 2, 3, 3, 3, 3),
    rti_race3  = factor(rti_race3, labels = c("NH White", "Black", "Other")),
    smokenow   = ifelse(is.na(smokenow), 0, smokenow),
    smokecat   = ifelse(smokenow == 1, 2, ifelse(smoke > 1, 2, 1)),
    smokecat   = factor(smokecat, labels = c("Never", "Ever")),
    alcnow     = ifelse(is.na(alcnow), 0, alcnow),
    alccat     = ifelse(alcnow == 1, 2, ifelse(alcohol > 1, 2, 1)),
    alccat     = factor(alccat, labels = c("Never", "Ever")),
    vegstat2   = relevel(vegstat, ref = "Non-veg"))


# Co-morbidity ------------------------------------------------------------

# Prevalent comorbidity according to CMS
dzvars <- c("ami", "atrial_fib", "cataract", "chronickidney", "copd", "chf", "diabetes", "glaucoma",
            "hip_fracture", "ischemicheart", "depression", "osteoporosis", "ra_oa", "stroke_tia", 
            "cancer_breast", "cancer_colorectal", "cancer_prostate", "cancer_lung", "cancer_endometrial",
            "asthma", "hyperl", "hypert", "hypoth")
dzvars <- paste0(toupper(dzvars), "_EVER")

# Convert all comodidity ever variables to date
test <- ahs_medic_inc2 %>% 
  mutate(across(all_of(dzvars), ymd)) 

find_prevalence <- function(var, data, start){
  cc_var <- data[[var]]
  strtdt  <- data[[start]]
  out <- ifelse(cc_var <= strtdt, 1, 0)
  out <- ifelse(is.na(cc_var), 0, out)
  return(out)
}

dzdf <- as.data.frame(lapply(dzvars, find_prevalence, data = test, start = "qreturndate"))
names(dzdf) <- paste0(dzvars, "_YN")
dzdf <- as_tibble(dzdf)

dzdf <- dzdf %>% 
  mutate(como_depress  = DEPRESSION_EVER_YN,
         como_diabetes = DIABETES_EVER_YN,
         como_kidney   = CHRONICKIDNEY_EVER_YN,
         como_hypoth   = HYPOTH_EVER_YN,
         como_cancers  = ifelse(rowSums(.[grep("CANCER_", names(.))]) > 0, 1, 0),
         como_cvd      = ifelse(rowSums(.[grep("AMI|ATRIAL|CHF|ISCHEMIC|STROKE", names(.))]) > 0, 1, 0),
         como_disab    = ifelse(rowSums(.[grep("CATARACT|GLAU|HIP|OSTEO|RA_OA", names(.))]) > 0, 1, 0),
         como_hthl     = ifelse(rowSums(.[grep("HYPERT|HYPERL",  names(.))]) > 0, 1, 0),
         como_resp     = ifelse(rowSums(.[grep("COPD|ASTHMA",  names(.))]) > 0, 1, 0)) %>% 
  mutate_at(vars(starts_with("como_")), factor, labels = c("No", "Yes")) %>% 
  select(starts_with("como_"))

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  bind_cols(dzdf)

modelvars <- c("bene_age_at_end_2020", 
               "bene_sex_F", 
               "rti_race3", 
               "marital", 
               "educyou", 
               "vegstat", 
               "bmi", 
               "exercise", 
               "sleephrs", 
               "smokecat", 
               "alccat", 
               "como_depress",
               "como_disab", 
               "como_diabetes", 
               "como_cvd", 
               "como_hthl", 
               "como_resp", 
               "como_kidney", 
               "como_hypoth", 
               "como_cancers",
               "meat_gram",
               "fish_gram",
               "eggs_gram",
               "dairy_gram"
)

ahs_medic_inc2 %>% 
  select(all_of(modelvars)) %>% 
  sapply(\(x) sum(is.na(x)))

# After excluding missing on covariates
# there are 36,549 subjects
complete_cases <- ahs_medic_inc2 %>% 
  select(analysisid, all_of(modelvars)) %>% 
  filter(complete.cases(.)) %>% 
  select(analysisid)

nrow(complete_cases)

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  inner_join(complete_cases, by = "analysisid")

# dietary variables -------------------------------------------------------

# List of dietary variables
names(ahsdiet)

# Food group variables
# Energy-adjust with zero partition
# By default, variables are log-transformed (excluding zeros)
kcal_adjust <- function(data, var, energy, log=TRUE){
  if (missing(var))
    stop("Need to specify variable for energy-adjustment.")
  if (missing(energy))
    stop("Need to specify energy intake.")
  if (missing(data))
    stop("Need to specify a data frame.")
  df <- eval(substitute(data.frame(y = data$var, ea_y = data$var, kcal = data$energy)))
  count_negative <- sum(df$y < 0, na.rm=TRUE)
  if (count_negative > 0)
    warning("There are negative values in variable.")
  if(log) df$y[df$y > 0 & !is.na(df$y)] <- log(df$y[df$y > 0 & !is.na(df$y)])
  mod <- lm(y ~ kcal, data=df[df$y != 0, ])
  if(log){
    ea <- exp(resid(mod) + mean(df$y[df$y != 0], na.rm=TRUE))
    df$ea_y[!is.na(df$y) & df$y != 0] <- ea
  }
  else{
    ea <- resid(mod) + mean(df$y[df$y != 0], na.rm=TRUE)
    df$ea_y[!is.na(df$y) & df$y != 0] <- ea
  }
  return(df$ea_y)
}

ahs_medic_inc2$meat_gram_ea      <- kcal_adjust(meat_gram,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$fish_gram_ea      <- kcal_adjust(fish_gram,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$eggs_gram_ea      <- kcal_adjust(eggs_gram,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$dairy_gram_ea     <- kcal_adjust(dairy_gram, kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$nutsseeds_gram_ea <- kcal_adjust(nutsseeds_gram, kcal, data = ahs_medic_inc2, log = TRUE)

diet_plot <- function(var, diet_label){
  var <- enquo(var)
  p1 <- ahs_medic_inc2 %>% 
    filter(!is.na(!!var)) %>% 
    ggplot(aes(x = !!var)) + 
    geom_histogram(bins = 50) +
    labs(title = paste("Histogram of", diet_label, "intake (g/d, energy-adjusted)"))
  
  p2 <- ahs_medic_inc2 %>% 
    filter(!is.na(!!var)) %>% 
    ggplot(aes(x = log(!!var + 1))) + 
    geom_histogram(bins = 50) +
    labs(title = "Log transformed")
  
  grid.arrange(p1, p2, ncol = 2)
}

diet_plot(eggs_gram_ea,      "egg")
diet_plot(dairy_gram_ea,     "dairy")
diet_plot(nutsseeds_gram_ea, "nuts/seeds")
diet_plot(meat_gram_ea,      "meat")
diet_plot(fish_gram_ea,      "fish")

# Create quantile groups
# Specify p for other percentile groups
cutQ <- function(x, p=0:4/4, na.rm=FALSE) cut(x, quantile(x, p, na.rm=na.rm), include.lowest=TRUE)

# Quartiles for egg, dairy and nuts/seeds
ea_diet_vars <- c("eggs_gram_ea", "dairy_gram_ea", "nutsseeds_gram_ea")
get_percentile <- function(var, data = ahs_medic_inc2) cutQ(data[[var]], na.rm = TRUE, p = 0:4/4)
test <- lapply(ea_diet_vars, get_percentile)
names(test) <- paste0(ea_diet_vars, "_4")
ahs_medic_inc2 <- cbind(ahs_medic_inc2, test)
rm(test)

# There are many zeros in meat/fish intake
table(cutQ(ahs_medic_inc2$meat_gram_ea[ahs_medic_inc2$meat_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
table(cut(ahs_medic_inc2$meat_gram_ea, breaks = c(-Inf, 0, 11, 32, Inf), right = TRUE)) %>% prop.table

table(cutQ(ahs_medic_inc2$fish_gram_ea[ahs_medic_inc2$fish_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
table(cut(ahs_medic_inc2$fish_gram_ea, breaks = c(-Inf, 0, 8.6, 17.2, Inf), right = TRUE)) %>% prop.table

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  mutate(meat_gram_ea_4 = cut(meat_gram_ea, breaks = c(-Inf, 0, 11, 32, Inf), right = TRUE), 
         fish_gram_ea_4 = cut(fish_gram_ea, breaks = c(-Inf, 0,  8.6, 17.2, Inf), right = TRUE))

ahs_medic_inc2 %>% 
  as_tibble() %>% 
  select(meat_gram_ea_4, fish_gram_ea_4, eggs_gram_ea_4, dairy_gram_ea_4) %>% 
  lapply(levels)

levels(ahs_medic_inc2$meat_gram_ea_4)  <- c("None", "<11 g/d", "11-<32 g/d", "32+ g/d")
levels(ahs_medic_inc2$fish_gram_ea_4)  <- c("None", "<8.6 g/d", "8.6-<17.2 g/d", "17.2+ g/d")
levels(ahs_medic_inc2$eggs_gram_ea_4)  <- c("<3.6 g/d", "3.6-7.5 g/d", "7.5-<16 g/d", "16+ g/d")
levels(ahs_medic_inc2$dairy_gram_ea_4) <- c("<30 g/d", "30-100 g/d", "100-<236 g/d", "236+ g/d")

# Table 1 -----------------------------------------------------------------

# Variables to be included
tablevars <- c("agecat", 
               # "bene_age_at_end_2008", 
               "bene_age_at_end_2020", 
               "bene_sex_F", 
               "rti_race3", 
               "marital", 
               "educyou", 
               "vegstat", 
               "bmicat", 
               "bmi", 
               "exercise", 
               "sleephrs", 
               "smokecat", 
               "alccat", 
               "como_depress",
               "como_disab", 
               "como_diabetes", 
               "como_cvd", 
               "como_hthl", 
               "como_resp", 
               "como_kidney", 
               "como_hypoth", 
               "como_cancers",
               "meat_gram_ea_4",
               "fish_gram_ea_4",
               "eggs_gram_ea_4",
               "dairy_gram_ea_4"
               )

summary(ahs_medic_inc2$ALZH_DEMEN_YN)

out <- ahs_medic_inc2 %>% 
  mutate(ALZH_DEMEN_YN2 = fct_recode(ALZH_DEMEN_YN, "Non-case" = "No", "Case" = "Yes")) %>% 
  CreateTableOne(tablevars, strata = "ALZH_DEMEN_YN2", data = ., addOverall = TRUE)
print(out, showAllLevels = TRUE)

ahs_medic_inc2  %>% 
  jstable::CreateTableOne2(strata = "ALZH_DEMEN_YN", 
                           vars = tablevars, 
                           addOverall = TRUE,
                           showAllLevels = TRUE,
                           quote = F) 

# Check numbers of missing
sapply(ahs_medic_inc2[tablevars], function(x) sum(is.na(x)))


# Cox models --------------------------------------------------------------

# Indep vars (will be age-adjusted)
vars <- c("bene_sex_F", "rti_race3", "marital", "educyou2", "vegstat3", "bmicat", "exercise", "sleephrs2", "smokecat", "alccat",
          "como_depress", "como_disab", "como_diabetes", "como_cvd", "como_hthl", "como_resp", "como_kidney", "como_hypoth", "como_cancers")

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  mutate(bene_sex_F = relevel(bene_sex_F, ref="F"),
         bmicat     = relevel(bmicat, ref="Normal"),
         inc_demen  = ifelse(ALZH_DEMEN_YN == "Yes", 1, 0),
         kcal100    = kcal / 100,
         vegstat3   = fct_collapse(vegstat2, "Non-veg" = c("Non-veg", "Semi")))

# Cox proportinal hazards model
coxm <- function(var, dsn = ahs_medic_inc2){
  fm <- formula(Surv(agein, ageout, inc_demen) ~ var)
  mod <- coxph(fm, data = dsn, method = "efron")
  return(mod)
}

getHR <- function(coxph, digits = 2){
  hrci <- cbind(uniHR = exp(coef(coxph)), exp(confint(coxph))) %>% round(digits)
  return(hrci)
}
replace_var <- function(x, varname) gsub("var", varname, names(coef(x[1])))

# Unadjusted HRs
cox_out <- lapply(ahs_medic_inc2[vars], coxm)
out <- do.call(rbind, lapply(cox_out, getHR))
rownames(out) <- unlist(mapply(replace_var, cox_out, varname = names(cox_out)))
out

# Multivariable Cox model
mv_mod <- coxph(Surv(agein, ageout, inc_demen) ~ bene_sex_F + rti_race3 + marital + educyou2 + vegstat3 + 
                  bmicat + exercise + sleephrs2 + smokecat + alccat + como_depress + como_disab + como_diabetes + 
                  como_cvd + como_hthl + como_resp + como_kidney + como_hypoth + como_cancers, data = ahs_medic_inc2, method = "efron")

mv_out  <- summary(mv_mod)
mv_out2 <- cbind(mvHR = coef(mv_out)[, "exp(coef)"], exp(confint(mv_mod))) %>% round(2)

# Model 1 Trend p-value
mv_mod_tmp <- update(mv_mod, .~. - educyou2 + as.numeric(educyou))
summary(mv_mod_tmp)
mv_mod_tmp <- update(mv_mod, .~. - bmicat + as.numeric(bmicat))
summary(mv_mod_tmp)
mv_mod_tmp <- update(mv_mod, .~. - exercise + as.numeric(exercise))
summary(mv_mod_tmp)
mv_mod_tmp <- update(mv_mod, .~. - sleephrs2 + as.numeric(sleephrs))
summary(mv_mod_tmp)

# For models with food group (remove dietary pattern)
vars <- c("bene_sex_F", "rti_race3", "marital", "educyou2", "bmicat", "exercise", "sleephrs2", "smokecat", "alccat",
          "como_depress", "como_disab", "como_diabetes", "como_cvd", "como_hthl", "como_resp", "como_kidney", "como_hypoth", "como_cancers",
          "kcal100", "meat_gram_ea_4", "fish_gram_ea_4", "eggs_gram_ea_4", "dairy_gram_ea_4")

cox_out <- lapply(ahs_medic_inc2[vars], coxm)
out <- do.call(rbind, lapply(cox_out, getHR))
rownames(out) <- unlist(mapply(replace_var, cox_out, varname = names(cox_out)))
out

mv_mod2 <- update(mv_mod, .~. - vegstat2 + kcal100 + meat_gram_ea_4 + fish_gram_ea_4 + eggs_gram_ea_4 + dairy_gram_ea_4)
mv_out <- summary(mv_mod2)
mv_out2 <- cbind(mvHR = coef(mv_out)[, "exp(coef)"], exp(confint(mv_mod2))) %>% round(2)
cbind(out, mv_out2)

drop1(mv_mod2)
anova(mv_mod2, update(mv_mod2, .~. - meat_gram_ea_4))
anova(mv_mod2, update(mv_mod2, .~. - fish_gram_ea_4))
anova(mv_mod2, update(mv_mod2, .~. - eggs_gram_ea_4))
anova(mv_mod2, update(mv_mod2, .~. - dairy_gram_ea_4))

# Trend p-value
mv_mod4 <- update(mv_mod2, .~. - educyou2 + as.numeric(educyou))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - bmicat + as.numeric(bmicat))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - exercise + as.numeric(exercise))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - sleephrs2 + as.numeric(sleephrs))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - meat_gram_ea_4 + as.numeric(meat_gram_ea_4))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - fish_gram_ea_4 + as.numeric(fish_gram_ea_4))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - eggs_gram_ea_4 + as.numeric(eggs_gram_ea_4))
summary(mv_mod4)
mv_mod4 <- update(mv_mod2, .~. - dairy_gram_ea_4 + as.numeric(dairy_gram_ea_4))
summary(mv_mod4)

# Model with dietary pattern and egg
mv_mod1a <- update(mv_mod, .~. + kcal100 + eggs_gram_ea_4)
mv_out <- summary(mv_mod1a)
mv_out2 <- cbind(mvHR = coef(mv_out)[, "exp(coef)"], exp(confint(mv_mod1a))) %>% round(2)

# Model with meat x egg interaction
mv_mod3 <- update(mv_mod2, .~. + meat_gram_ea_4 * eggs_gram_ea_4)
mv_out3 <- summary(mv_mod3)
mv_out3 <- cbind(mvHR = coef(mv_out3)[, "exp(coef)"], exp(confint(mv_mod3))) %>% round(2)

# LR test for interaction
anova(mv_mod2, mv_mod3)

# Checking PH assumption
mv_mod_zph <- cox.zph(mv_mod, transform = "km", global = FALSE, terms = FALSE)
mv_mod_zph

# Variables violating PH assumptions
plot.zph <- function(var,...){
  plot(mv_mod_zph, var = var, resid = FALSE, col = c("red", "pink"), lwd = 2, cex.lab = 2, cex.axis = 2,...)
  abline(h = 0, lty = 2)
} 

par(mfrow=c(2, 4), mar=c(c(5.1, 5.1, 4.1, 2.1)))
  plot.zph("rti_race3Black",     ylim = c(-4, 4))
  plot.zph("maritalDiv/Wid",     ylim = c(-4, 4))
  plot.zph("educyou2HS or less", ylim = c(-4, 4))
  plot.zph("bmicatObese",        ylim = c(-4, 4))
  plot.zph("sleephrs2<= 5 hrs",  ylim = c(-4, 4))
  plot.zph("sleephrs2>= 9 hrs",  ylim = c(-4, 4))
  plot.zph("smokecatEver",       ylim = c(-4, 4))
  plot.zph("alccatEver",         ylim = c(-4, 4))
par(mfrow=c(1, 1))

par(mfrow=c(2, 4), mar=c(c(5.1, 5.1, 4.1, 2.1)))
  plot.zph("como_depressYes",    ylim = c(-4, 4))
  plot.zph("como_diabetesYes",   ylim = c(-4, 4))
  plot.zph("como_cvdYes",        ylim = c(-4, 4))
  plot.zph("como_respYes",       ylim = c(-4, 4))
  plot.zph("como_kidneyYes",     ylim = c(-4, 4))
  plot.zph("como_cancersYes",    ylim = c(-4, 4))
par(mfrow=c(1, 1))
