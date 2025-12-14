
# Required libraries
pacs <- c("tidyverse", "readxl", "lubridate", "tableone", "gridExtra", "survival")
sapply(pacs, require, character.only = TRUE)


# Medicare crosswalk ------------------------------------------------------

# Read crosswalk file: n = 70.968
crosswalk <- read_fwf("./Data/12172/2022/ssn_bene_xwalk_res000058038_req012172_2022.dat",
                      fwf_widths(c(9, 15, 1, 1, 1), c("ORIG_SSN", "BENE_ID", "SSN_MATCH", "SEX_MATCH", "DOB_MATCH")))

# # How many matches? -- 52,704 subjects (74%)
# # There were 115 invalid SSN
# crosswalk %>% 
#   group_by(SSN_MATCH) %>% 
#   tally() %>% 
#   mutate(pct = n / sum(n) * 100)
# 
# # Gender mismatch -- 824 subjects (1.6%)
# crosswalk %>% 
#   filter(SSN_MATCH == 1) %>% 
#   group_by(SEX_MATCH) %>% 
#   tally() %>% 
#   mutate(pct = n / sum(n) * 100)
# 
# # DOB mismatch -- 3331 subjects (6.3%)
# crosswalk %>% 
#   filter(SSN_MATCH == 1) %>% 
#   group_by(DOB_MATCH) %>% 
#   tally() %>% 
#   mutate(pct = n / sum(n) * 100)
# 
# # How many have both gender and DOB mismatch -- 787 subjects (1.5%)
# crosswalk %>% 
#   filter(SSN_MATCH == 1, SEX_MATCH == 0, DOB_MATCH == 0) %>%
#   nrow()
# 
# # How many have either gender OR DOB mismatch -- 3368 subjects (6.4%)
# crosswalk %>% 
#   filter(SSN_MATCH == 1 & (SEX_MATCH == 0 | DOB_MATCH == 0)) %>%
#   nrow()

# Extract matched BENE_IDs
all_matched_bene_ids <- crosswalk %>% 
  filter(SSN_MATCH == 1)

# BENE_IDs of gender or DOB mismatch (to be removed)
mismatches <- crosswalk %>% 
  filter(SSN_MATCH == 1 & (SEX_MATCH == 0 | DOB_MATCH == 0)) %>%
  select(BENE_ID)
  
# # There are two duplicates in BENE_IDs...
# all_matched_bene_ids %>% 
#   summarize(n = n_distinct(BENE_ID))

dup_BENE_IDs <- all_matched_bene_ids %>% 
  group_by(BENE_ID) %>% 
  summarize(n = sum(n())) %>% 
  filter(n > 1)

# all_matched_bene_ids %>% 
#   filter(BENE_ID %in% dup_BENE_IDs$BENE_ID)
# 
# # There are 106 SSN duplicates ???
# all_matched_bene_ids %>% 
#   summarize(n = n_distinct(ORIG_SSN))

dup_SSNs <- all_matched_bene_ids %>% 
  group_by(ORIG_SSN) %>% 
  summarize(n = sum(n())) %>% 
  filter(n > 1)

# all_matched_bene_ids %>% 
#   filter(ORIG_SSN %in% dup_SSNs$ORIG_SSN)

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

# Read MSBF files of additional 2 years: 2021-2022
year <- 2021:2022
fname <- paste0("./Data/14345/", year, "/mbsf_abcd_summary_res000058038_req014345_", year, ".dat")

add_msbf <- fname %>% 
  lapply(\(x) read_fwf(x, fwf_widths(fts_msbf$length, fts_msbf$long_name))) %>% 
  lapply(\(x) anti_join(x, exclude_BENE_IDs)) %>% 
  setNames(year)

# There are 33,593 BeneIDs in the 2 years
add_msbf %>% 
  do.call(rbind, .) %>% 
  select(BENE_ID) %>% 
  distinct()

# Append
all_msbf2 <- c(all_msbf, add_msbf)
all_msbf2 %>% sapply(nrow)

# Long format over years
all_msbf_long <- all_msbf2 %>% 
  do.call(rbind, .) %>% 
  arrange(BENE_ID, BENE_ENROLLMT_REF_YR)

# Num of beneficiaries each year
all_msbf_long %>% 
  group_by(BENE_ENROLLMT_REF_YR) %>% 
  tally()

# Unique beneficiaries across years (2008-2020): n = 44,585
# Unique beneficiaries across years (2021-2022): n = 46,897
all_msbf_bene_ids <- all_msbf_long %>% 
  select(BENE_ID) %>% 
  distinct()

nrow(all_msbf_bene_ids)

all_msbf_bene_ids %>% 
  left_join(crosswalk, by = "BENE_ID")

# 4546 matched beneficiaries were never appeared in MSBF files
# 2234 matched beneficiaries were never appeared in MSBF files
bene_ids_no_show <- all_matched_bene_ids %>% 
  anti_join(exclude_BENE_IDs) %>% 
  anti_join(all_msbf_bene_ids)

nrow(bene_ids_no_show)

# How many died during 2008-2022
# 16,105 (34.3%) died
all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  mutate(Dead = ifelse(is.na(BENE_DEATH_DT), 0, 1),
         Dead = factor(Dead, levels = 0:1, labels = c("Alive", "Dead"))) %>% 
  group_by(Dead) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# N deaths = 16,105
n_deaths <- all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n()) %>% 
  filter(!is.na(BENE_DEATH_DT)) %>% nrow()

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

# Data specification of Chronic files
fts_chronic <- read_excel("./Data/mbsf_chronic_format.xlsx")


# Read MSBF files of additional 2 years: 2021-2022
year <- 2021:2022
fname <- paste0("./Data/14345/", year, "/mbsf_chronic_summary_res000058038_req014345_", year, ".dat")

# Some CC variables must be renamed
# Chronic conditions; name changes
  # Hyperlipidemia: HYPERL_EVER to HLP_EVER
  # CHF: CHF_EVER to HF_EVER
  # Hypertension: HYPERT_EVER to HTN_EVER
  # Hypothyroid: HYPOTH_EVER to HYPTHYRD_EVER

add_cc <- fname %>% 
  lapply(\(x) read_fwf(x, fwf_widths(fts_chronic$length, fts_chronic$long_name))) %>% 
  lapply(\(x) anti_join(x, exclude_BENE_IDs)) %>%
  lapply(\(x) rename(x, HYPERL_EVER = HLP_EVER, CHF_EVER = HF_EVER, HYPERT_EVER = HTN_EVER, HYPOTH_EVER = HYPTHYRD_EVER)) %>% 
  setNames(year)

# There are 33,593 BeneIDs in the 2 years
add_cc %>% 
  do.call(rbind, .) %>% 
  select(BENE_ID) %>% 
  distinct()

# Append
all_cc2 <- c(all_cc, add_cc)
all_cc2 %>% sapply(nrow)

# Long format over years
all_cc_long <- all_cc2 %>%
  # do.call(rbind, .) %>% 
  do.call(bind_rows, .) %>% 
  arrange(BENE_ID, BENE_ENROLLMT_REF_YR)

# Num of beneficiaries each year
all_cc_long %>% 
  group_by(BENE_ENROLLMT_REF_YR) %>% 
  tally()

# Unique beneficiaries across years: n = 44,585
# Unique beneficiaries across years (2021-2022): n = 46,897
all_cc_bene_ids <- all_cc_long %>% 
  select(BENE_ID) %>% 
  distinct()

nrow(all_cc_bene_ids)

# Hyperlipidemia status at the last year of appearance
# Have hyperlipidemia: n = 21,976 (46.9%)
all_cc_long %>% 
  mutate(HYPERL_YN    = ifelse(is.na(HYPERL_EVER), 0, 1)) %>% 
  group_by(BENE_ID) %>% 
  slice(n()) %>%
  # mutate(HYPERL_YN = max(HYPERL_YN)) %>% 
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

# # N = 96,144
ahsdata <- read.csv("./Data/BaselineDataForMedicare20190531.csv", header=TRUE)
names(ahsdata) <- tolower(names(ahsdata))

# File names of 5 imputed data
imputed_file_names <- dir("./Data", full.names = TRUE) %>% grep("04-24.csv", ., value = TRUE)

# Read into a list of data frames
imputed_data <- imputed_file_names %>% lapply(read_csv)

# Check sample sizes
imputed_data %>% sapply(nrow)

# N = 41,037
ahsdata2 <- imputed_data[[1]] %>%
  rename(agein = calc_baseline_age) %>% 
  
  # Get qreturndate from ahsdata and convert to date
  inner_join(ahsdata %>% select(analysisid, qreturndate), by = "analysisid") %>% 
  mutate(qreturndate = as.Date(qreturndate),
         
  # Demographic/lifestyle variables
         bmicat    = cut(bmi, breaks = c(0, 25, 30, Inf), right = FALSE),
         bmicat    = factor(bmicat, labels = c("Normal", "Overweight", "Obese")),
         marital   = recode(marital, "Never", "Married", "Married", "Married", "Div/Wid", "Div/Wid", "Div/Wid"),
         marital   = factor(marital, levels = c("Married", "Never", "Div/Wid")),
         # educyou   = factor(educat3, levels = c("HSch & below", "Some College", "Bachelors +")),
         educyou   = factor(educat3, labels = c("Bachelors +","HSch & below", "Some College")),
         educyou   = fct_relevel(educyou, "HSch & below", "Some College", "Bachelors +"),
         educyou2  = relevel(educyou, ref = "Bachelors +"),
         sleephrs  = recode(sleephrs - 2, "<= 5 hrs", "<= 5 hrs", "<= 5 hrs", "6 hrs", "7 hrs",  
                                      "8 hrs", ">= 9 hrs", ">= 9 hrs", ">= 9 hrs"),
         sleephrs  = factor(sleephrs, levels = c("<= 5 hrs", "6 hrs", "7 hrs", "8 hrs", ">= 9 hrs")),
         sleephrs2 = relevel(sleephrs, ref = "7 hrs"),
         vegstat   = 1 * vegan + 2 * lacto + 3 * semi + 4 * pesco + 5 * nonveg,
         vegstat   = factor(vegstat, labels=c("Vegan", "Lacto-ovo",  "Semi", "Pesco", "Non-veg")),
         vegstat2  = relevel(vegstat, ref = "Non-veg"),
         exercise  = cut(exermin_week, breaks = c(-Inf, 0, 30, 120, Inf), right = TRUE),
         exercise  = factor(exercise, labels = c("None", "≤0.5 hrs/wk", "0.5<-2 hrs/wk", ">2 hrs/wk")),
         # smokecat  = factor(smokecat6, labels = c("Never", rep("Ever", 5))),
         smokecat6 = factor(smokecat6),
         # alccat    = ifelse(wine2cat == "1no" & beerliq2 == "1no", "Never", "Ever"),
         alccat    = ifelse(winegd == 0 & beergd == 0 & liquorgd == 0, "Never", "Current"),
         alccat    = factor(alccat, levels = c("Never", "Current")), 
  
  # Dietary variables
         egg_freq  = recode(eggbetrf, 1, 2, 3, 4, 5, 5, 5, 5, 5),
         egg_freq  = factor(egg_freq, labels = c("Never", "1-3/mo", "1/wk", "2-4/wk", "5+/wk")),
         kcal      = kcaldiet + kcalsupp,
         meat_gramdiet = procredmeat_gramdiet + unprocredmeat_gramdiet + procpoultry_gramdiet + unprocpoultry_gramdiet,
         # fish_gramdiet = fattyfish_gramdiet + otherfish_gramdiet,
         grains_gramdiet = wholegrains_gramdiet + mixedgrains_gramdiet + refgrains_gramdiet,
         whole_mixed_grains_gramdiet = wholegrains_gramdiet + mixedgrains_gramdiet)

# Opt-outs: n = 395
optout <- read_csv("./Data/OptOutAnalysisIDs.csv") %>% setNames("analysisid")

# Already excluded?
ahsdata2 %>% semi_join(optout) %>% nrow()

# Those who live outside US
# None found in the AHS data above 
outside_us <- read_csv("./Data/outside_us.csv")
ahsdata2 %>% semi_join(outside_us, by = "analysisid") %>% nrow()

nrow(ahsdata2)


# Merge AHS data with Medicare --------------------------------------------

# Extract data of the last seen: MSBF and CC files  
msbf_last_seen <- all_msbf_long %>%
  group_by(BENE_ID) %>% 
  slice(n())

cc_last_seen <- all_cc_long %>%
  group_by(BENE_ID) %>% 
  slice(n())

# Merge AHS data with Medicare
# Results in n = 41,037 subjects
ahs_medic <- msbf_last_seen %>% 
  inner_join(cc_last_seen %>% select(-BENE_ENROLLMT_REF_YR), by = "BENE_ID") %>%
  inner_join(ahs_dup_removed %>% 
               rename(BENE_ID = Bene_ID) %>% 
               mutate(analysisid = parse_number(AnalysisID)), by = "BENE_ID") %>% 
  inner_join(ahsdata2, by = "analysisid") %>% 
  # left_join(ahsdiet, by = "analysisid") %>% 
  # inner_join(ahsdiet, by = "analysisid") %>% 
  ungroup()

nrow(ahs_medic)

# Apply inclusion/exclusion criteria --------------------------------------

# Remove if AGE_AT_END_REF_YR < 65 (n = 1105)
# Results in n = 39,932
ahs_medic %>% 
  filter(AGE_AT_END_REF_YR < 65) %>% 
  nrow()
  
ahs_medic <- ahs_medic %>% 
  filter(AGE_AT_END_REF_YR >= 65)

# Remove if BMI is extreme (n = 82)
# Resuts in n = 39,850
ahs_medic %>% filter(bmi < 16 | bmi > 60) %>% tally()
ahs_medic <- ahs_medic %>% 
  filter(bmi >= 16, bmi <= 60)

# Need to exclude unverified deaths
# There are 23 unverified deaths
ahs_medic %>% 
  filter(!is.na(BENE_DEATH_DT)) %>% 
  group_by(VALID_DEATH_DT_SW) %>% 
  tally()

unverified_deaths <- ahs_medic %>% 
  filter(!is.na(BENE_DEATH_DT)) %>%
  filter(is.na(VALID_DEATH_DT_SW)) %>% 
  select(analysisid)

# Exclude unverified deaths
# Yields n = 39,827
ahs_medic <- ahs_medic %>% 
  anti_join(unverified_deaths, by = "analysisid") 

# Identify afib cases
ahs_medic <- ahs_medic %>% 
  mutate(AFIB_YN = ifelse(is.na(ATRIAL_FIB_EVER), 0, 1),
         AFIB_YN = factor(AFIB_YN, label = c("No", "Yes")))   

# There are 7160 afib cases (18.0%)
ahs_medic %>%
  group_by(AFIB_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Find prevalent cases: 857 prevalent cases
ahs_medic %>% 
  filter(AFIB_YN == "Yes") %>% 
  mutate(ATRIAL_FIB_EVER = ymd(ATRIAL_FIB_EVER)) %>%
  filter(ATRIAL_FIB_EVER <= qreturndate) %>% 
  select(analysisid, AFIB_YN, qreturndate, ATRIAL_FIB_EVER)

prev_cases <- ahs_medic %>% 
  filter(AFIB_YN == "Yes") %>% 
  mutate(ATRIAL_FIB_EVER = ymd(ATRIAL_FIB_EVER)) %>%
  filter(ATRIAL_FIB_EVER <= qreturndate) %>% 
  select(BENE_ID, analysisid)

# Exclude prevalent cases
# Yields n = 38,970 subjects
ahs_medic <- ahs_medic %>% 
  anti_join(prev_cases, by = "analysisid") %>% 
  mutate(BENE_BIRTH_DT = ymd(BENE_BIRTH_DT),
         BENE_DEATH_DT = ymd(BENE_DEATH_DT),
         ATRIAL_FIB_EVER = ymd(ATRIAL_FIB_EVER))

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

# There are 18,804 hyperlipidemia cases (48.3%)
ahs_medic %>%
  group_by(HYPERL_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Find prevalent cases: n = 3099
ahs_medic %>% 
  filter(HYPERL_YN == "Yes") %>% 
  mutate(HYPERL_EVER = ymd(HYPERL_EVER)) %>%
  filter(HYPERL_EVER <= qreturndate) %>% 
  select(analysisid, HYPERL_YN, qreturndate, HYPERL_EVER)

hyperl_diag_date <- ahs_medic %>% 
  filter(HYPERL_YN == "Yes") %>% 
  mutate(HYPERL_EVER = ymd(HYPERL_EVER)) %>%
  mutate(DateDiff = interval(qreturndate, HYPERL_EVER),
         DateDiff_days = as.numeric(DateDiff, 'days'), 
         DateDiff_months = as.numeric(DateDiff, 'months'), 
         DateDiff_years = as.numeric(DateDiff, 'years')) 

# How many cases in which qreturndate > diagnosis date?
# 3,099 such cases
hyperl_diag_date %>% 
  filter(DateDiff_days <= 0) %>% 
  select(HYPERL_YN, HYPERL_EVER, qreturndate, DateDiff_days, DateDiff_months, DateDiff_years)

# Hyperlipidemia -- use as time-dependent variable in the cox model?
# Or only include anyone with the diagnoses regardless of prevalence/incidence

# Define CVD cases --------------------------------------------------------

names(ahs_medic) %>% grep("_EVER", ., value = TRUE)
# cvd_vars <- c("ISCHEMICHEART_EVER", "STROKE_TIA_EVER", "AMI_EVER", "CHF_EVER", "ATRIAL_FIB_EVER")
cvd_vars <- c("ATRIAL_FIB_EVER")

ahs_medic %>% select(all_of(cvd_vars))

cvd_df <- ahs_medic %>% 
  select(all_of(cvd_vars)) %>% 
  mutate_all(ymd) %>% 
  mutate_all(\(x) ifelse(is.na(x), "No", "Yes"))

# Number of cases for each condition
CreateTableOne(cvd_vars, data = cvd_df)

# Based on AFib only
ahs_medic2 <- ahs_medic %>% 
  mutate(ATRIAL_FIB_EVER = ymd(ATRIAL_FIB_EVER), 
         AFIB_YN = ifelse(is.na(ATRIAL_FIB_EVER), 0, 1),
         AFIB_YN = factor(AFIB_YN, labels = c("No", "Yes")))

ahs_medic2 %>% 
  group_by(AFIB_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

# Define variables for models ---------------------------------------------

# Define ageout
# If CVD_EVER exists (incident cases), the use this diag date
# If non-case and BENE_DEATH_DT exists, then use this date died (censored)
# Otherwise, use the end of BENE_ENROLLMT_REF_YR (year last seen)
# Calculate age at hyperlipidemia
# If hyperlipidemia occurs after CVD event, set hyperl_age as missing
ahs_medic_inc <- ahs_medic2 %>% 
  mutate(
    age_last_seen = time_length(interval(BENE_BIRTH_DT, make_date(BENE_ENROLLMT_REF_YR, 12, 31)), "year"),
    ageout = case_when(
              AFIB_YN == "Yes" ~ time_length(interval(BENE_BIRTH_DT, ATRIAL_FIB_EVER), "year"),
              AFIB_YN == "No" & !is.na(BENE_DEATH_DT)  ~ time_length(interval(BENE_BIRTH_DT, BENE_DEATH_DT), "year"),
              AFIB_YN == "No" &  is.na(BENE_DEATH_DT)  ~ age_last_seen),
    hyperl_age = case_when(
              HYPERL_YN == "Yes" ~ time_length(interval(BENE_BIRTH_DT, HYPERL_EVER), "year"),
              .default = NA
    ),
    hyperl_age = if_else(hyperl_age > ageout, NA, hyperl_age),
    fuyear = ageout - agein,
    bene_sex_F = factor(SEX_IDENT_CD, labels = c("M", "F")),
    bene_age_at_end_2020 = time_length(interval(BENE_BIRTH_DT, make_date(2020, 12, 31)), "year"),
    agecat     = cut(bene_age_at_end_2020, breaks = c(65, 70, 75, 80, 85, 90, 95, 130), right = FALSE),
    agecat     = factor(agecat, labels = c("65-69", "70-74", "75-79", "80-84", "85-89", "90-94", "95+")),
    rti_race3  = recode(RTI_RACE_CD + 1, 3, 1, 2, 3, 3, 3, 3),
    rti_race3  = factor(rti_race3, labels = c("NH White", "Black", "Other"))
  )

summary(ahs_medic_inc$agein)
summary(ahs_medic_inc$ageout)

# Mean/median follow-up years: Mean 16.3 years, Median 18.2 years
summary(ahs_medic_inc$fuyear) %>% round(2)
sum(ahs_medic_inc$fuyear)

# Age at diagnosis: Mean 80.9 years, Median 81.4 years
ahs_medic_inc %>% 
  filter(AFIB_YN == "Yes") %>% 
  select(ageout) %>% 
  summary()

ahs_medic_inc %>% 
  filter(AFIB_YN == "Yes") %>% 
  pull(ageout) %>% sd()

# Co-morbidity ------------------------------------------------------------

# Prevalent comorbidity according to CMS
dzvars <- c("cataract", "chronickidney", "copd", "diabetes", "glaucoma",
            "hip_fracture", "depression", "osteoporosis", "ra_oa",  
            "cancer_breast", "cancer_colorectal", "cancer_prostate", "cancer_lung", "cancer_endometrial",
            "asthma", "hyperl", "hypert", "hypoth", "anemia")
dzvars <- paste0(toupper(dzvars), "_EVER")

# Convert all comodidity ever variables to date
test <- ahs_medic_inc %>% 
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
         como_anemia   = ANEMIA_EVER_YN,
         como_hypert   = HYPERT_EVER_YN,
         como_hyperl   = HYPERL_EVER_YN,
         como_cancers  = ifelse(rowSums(.[grep("CANCER_", names(.))]) > 0, 1, 0),
         como_disab    = ifelse(rowSums(.[grep("CATARACT|GLAU|HIP|OSTEO|RA_OA", names(.))]) > 0, 1, 0),
         como_hthl     = ifelse(rowSums(.[grep("HYPERT|HYPERL",  names(.))]) > 0, 1, 0),
         como_resp     = ifelse(rowSums(.[grep("COPD|ASTHMA",  names(.))]) > 0, 1, 0)) %>% 
  mutate_at(vars(starts_with("como_")), factor, labels = c("No", "Yes")) %>% 
  select(starts_with("como_"))

ahs_medic_inc2 <- ahs_medic_inc %>% 
  bind_cols(dzdf)

# dietary variables -------------------------------------------------------

# List of dietary variables
# names(ahsdiet)

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

ahs_medic_inc2$meat_gram_ea      <- kcal_adjust(meat_gramdiet,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$fish_gram_ea      <- kcal_adjust(fish_gramdiet,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$eggs_gram_ea      <- kcal_adjust(eggs_gramdiet,  kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$alldairy2_gram_ea <- kcal_adjust(alldairy2_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)

ahs_medic_inc2$nutsseeds_gram_ea <- kcal_adjust(nutsseeds_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$totalveg_gram_ea  <- kcal_adjust(totalveg_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$fruits_gram_ea    <- kcal_adjust(fruits_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$legumes_gram_ea   <- kcal_adjust(legumes_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)

ahs_medic_inc2$refgrains_gram_ea    <- kcal_adjust(refgrains_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)
ahs_medic_inc2$whole_mixed_grains_gram_ea    <- kcal_adjust(whole_mixed_grains_gramdiet, kcal, data = ahs_medic_inc2, log = TRUE)


# # Create quantile groups
# # Specify p for other percentile groups
# cutQ <- function(x, p=0:4/4, na.rm=FALSE) cut(x, quantile(x, p, na.rm=na.rm), include.lowest=TRUE)
# 
# # Quartiles for egg, dairy and nuts/seeds
# ea_diet_vars <- c("alldairy2_gram_ea", "totalveg_gram_ea",
#                   "fruits_gram_ea", "refgrains_gram_ea", "whole_mixed_grains_gram_ea", 
#                   "nutsseeds_gram_ea", "legumes_gram_ea")
# get_percentile <- function(var, data = ahs_medic_inc2) cutQ(data[[var]], na.rm = TRUE, p = 0:4/4)
# test <- lapply(ea_diet_vars, get_percentile)
# names(test) <- paste0(ea_diet_vars, "_4")
# ahs_medic_inc2 <- cbind(ahs_medic_inc2, test)
# rm(test)

# # There are many zeros in meat/fish intake
# table(cutQ(ahs_medic_inc2$meat_gram_ea[ahs_medic_inc2$meat_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
# table(cut(ahs_medic_inc2$meat_gram_ea, breaks = c(-Inf, 0, 11, 33, Inf), right = TRUE)) %>% prop.table
# table(cutQ(ahs_medic_inc2$fish_gram_ea[ahs_medic_inc2$fish_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
# table(cut(ahs_medic_inc2$fish_gram_ea, breaks = c(-Inf, 0, 9, 18, Inf), right = TRUE)) %>% prop.table
# table(cutQ(ahs_medic_inc2$alldairy2_gram_ea[ahs_medic_inc2$alldairy2_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
# table(cutQ(ahs_medic_inc2$totalveg_gram_ea, na.rm = TRUE, p = 0:4/4))
# table(cutQ(ahs_medic_inc2$eggs_gram_ea[ahs_medic_inc2$eggs_gram_ea > 0], na.rm = TRUE, p = 0:3/3))
# table(cutQ(ahs_medic_inc2$eggs_gram_ea[ahs_medic_inc2$eggs_gram_ea > 0], na.rm = TRUE, p = 0:4/4))

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  mutate(meat_gram_ea_4 = cut(meat_gram_ea, breaks = c(-Inf, 0, 11, 33, Inf), right = TRUE), 
         fish_gram_ea_4 = cut(fish_gram_ea, breaks = c(-Inf, 0,  9, 18, Inf), right = TRUE),
         alldairy2_gram_ea_4 = cut(alldairy2_gram_ea, breaks = c(-Inf, 0,  50, 180, Inf), right = TRUE),
         totalveg_gram_ea_4 = cut(totalveg_gram_ea, breaks = c(-Inf, 185, 270, 380, Inf), right = TRUE),
         fruits_gram_ea_4 = cut(fruits_gram_ea, breaks = c(-Inf, 170, 280, 420, Inf), right = TRUE),
         nutsseeds_gram_ea_4 = cut(nutsseeds_gram_ea, breaks = c(-Inf, 9, 18, 32, Inf), right = TRUE),
         legumes_gram_ea_4 = cut(legumes_gram_ea, breaks = c(-Inf, 33, 60, 100, Inf), right = TRUE),
         refgrains_gram_ea_4 = cut(refgrains_gram_ea, breaks = c(-Inf, 40, 83, 150, Inf), right = TRUE),
         whole_mixed_grains_gram_ea_4 = cut(whole_mixed_grains_gram_ea, breaks = c(-Inf, 120, 210, 350, Inf), right = TRUE),
         eggs_gram_ea_4 = cut(eggs_gram_ea, breaks = c(-Inf, 0, 4.5, 16.5, Inf), right = TRUE)
         # eggs_gram_ea_4 = cut(eggs_gram_ea, breaks = c(-Inf, 0, 3.5, 7.5, 20, Inf), right = TRUE)
         ) 

ahs_medic_inc2 %>% 
  group_by(eggs_gram_ea_4) %>% 
  tally() %>% 
  mutate(pct = n / nrow(ahs_medic_inc2) * 100)

ahs_medic_inc2 %>%
  as_tibble() %>%
  select(meat_gram_ea_4, fish_gram_ea_4, eggs_gram_ea_4, alldairy2_gram_ea_4) %>%
  lapply(levels)

levels(ahs_medic_inc2$meat_gram_ea_4)  <- c("None", "<11 g/d", "11-<33 g/d", "33+ g/d")
levels(ahs_medic_inc2$fish_gram_ea_4)  <- c("None", "<9 g/d", "9-<18 g/d", "18+ g/d")
levels(ahs_medic_inc2$eggs_gram_ea_4)  <- c("None", "<4.5 g/d", "4.5-<16.5 g/d", "16.5+ g/d")
levels(ahs_medic_inc2$alldairy2_gram_ea_4) <- c("None", "<50 g/d", "50-<180 g/d", "180+ g/d")
levels(ahs_medic_inc2$totalveg_gram_ea_4) <- c("<185 g/d", "185-<270 g/d", "270-<380 g/d", "380+ g/d")
levels(ahs_medic_inc2$fruits_gram_ea_4) <- c("<170 g/d", "170-<280 g/d", "280-<420 g/d", "420+ g/d")
levels(ahs_medic_inc2$refgrains_gram_ea_4) <- c("<40 g/d", "40-<83 g/d", "83-<150 g/d", "150+ g/d")
levels(ahs_medic_inc2$whole_mixed_grains_gram_ea_4) <- c("<120 g/d", "120-<210 g/d", "219-<350 g/d", "350+ g/d")
levels(ahs_medic_inc2$nutsseeds_gram_ea_4) <- c("<9 g/d", "9-<18 g/d", "18-<32 g/d", "32+ g/d")
levels(ahs_medic_inc2$legumes_gram_ea_4) <- c("<33 g/d", "33-<60 g/d", "60-<100 g/d", "100+ g/d")

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
               "smokecat6", 
               "alccat", 
               "como_depress",
               "como_disab", 
               "como_diabetes", 
               # "como_hthl", 
               "como_hypert", 
               "como_hyperl", 
               "como_resp", 
               "como_anemia", 
               "como_kidney", 
               "como_hypoth", 
               "como_cancers",
               # "eggs_gram_ea_4",
               "eggs_gram_ea",
               "meat_gram_ea_4",
               "meat_gram_ea",
               "fish_gram_ea_4",
               "fish_gram_ea",
               "alldairy2_gram_ea_4",
               "alldairy2_gram_ea",
               "totalveg_gram_ea_4",
               "totalveg_gram_ea",
               "fruits_gram_ea_4",
               "fruits_gram_ea",
               "refgrains_gram_ea_4",
               "refgrains_gram_ea",
               "whole_mixed_grains_gram_ea_4",
               "whole_mixed_grains_gram_ea",
               "nutsseeds_gram_ea_4",
               "nutsseeds_gram_ea",
               "legumes_gram_ea_4",
               "legumes_gram_ea"
               )

ahs_medic_inc2 %>% 
  group_by(AFIB_YN) %>% 
  tally() %>% 
  mutate(pct = n / sum(n) * 100)

ahs_medic_inc2 %>% 
  CreateTableOne(tablevars, strata = "eggs_gram_ea_4", data = ., addOverall = TRUE) %>% 
  print(showAllLevels = TRUE, noSpaces = TRUE, printToggle = FALSE) %>% 
  write.csv(file = "Desc_Tab_by_egg.csv")

out <- ahs_medic_inc2 %>%
  mutate(AFIB_YN2 = fct_recode(AFIB_YN, "Non-case" = "No", "Case" = "Yes")) %>%
  CreateTableOne(tablevars, strata = "AFIB_YN2", data = ., addOverall = TRUE)
print(out, showAllLevels = TRUE)

# Same Table 1, but only among those with hyperlipidemia
# ahs_medic_inc2 %>% 
#   group_by(HYPERL_YN) %>% 
#   tally() %>% 
#   mutate(pct = n / sum(n))
# 
# out <- ahs_medic_inc2 %>% 
#   filter(HYPERL_YN == "Yes") %>% 
#   mutate(CVD_YN2 = fct_recode(CVD_YN, "Non-case" = "No", "Case" = "Yes")) %>% 
#   CreateTableOne(tablevars, strata = "CVD_YN2", data = ., addOverall = TRUE)
# print(out, showAllLevels = TRUE)

# Cox models --------------------------------------------------------------

# Indep vars (will be age-adjusted)
# vars <- c("bene_sex_F", "rti_race3", "marital", "educyou2", "vegstat3", "bmicat", "exercise", "sleephrs2", "smokecat", "alccat",
#           "como_depress", "como_disab", "como_diabetes",  "como_resp", "como_anemia", "como_kidney", "como_hypoth", "como_cancers")

# Indep vars (will be age-adjusted)
vars <- c("bene_sex_F", "rti_race3", "marital", "educyou2", "bmicat", "exercise", "sleephrs2", "smokecat6", "alccat",
          "hyperl",
          # "como_hyperl",
          "como_hypert", "como_resp",
          "como_anemia", "como_kidney", "como_hypoth", "como_cancers",
          # "kcal100", "egg_freq", "meat_gram_ea", "fish_gram_ea",  "alldairy2_gram_ea",
          "kcal100", "eggs_gram_ea_4", "meat_gram_ea_4", "fish_gram_ea",  "alldairy2_gram_ea",
          "totalveg_gram_ea", "fruits_gram_ea", "refgrains_gram_ea", "whole_mixed_grains_gram_ea",
          "nutsseeds_gram_ea", "legumes_gram_ea"
)

ahs_medic_inc2 <- ahs_medic_inc2 %>% 
  mutate(bene_sex_F = relevel(bene_sex_F, ref="F"),
         bmicat     = relevel(bmicat, ref="Normal"),
         inc_AFIB   = ifelse(AFIB_YN == "Yes", 1, 0),
         kcal100    = kcal / 100,
         meat_gram_ea100 = meat_gram_ea / 100,
         fish_gram_ea100 = fish_gram_ea / 100,
         alldairy2_gram_ea100 = alldairy2_gram_ea / 100,
         totalveg_gram_ea100 = totalveg_gram_ea / 100,
         fruits_gram_ea100 = fruits_gram_ea / 100,
         refgrains_gram_ea100 = refgrains_gram_ea / 100,
         whole_mixed_grains_gram_ea100 = whole_mixed_grains_gram_ea / 100,
         nutsseeds_gram_ea100 = nutsseeds_gram_ea / 100,
         legumes_gram_ea100 = legumes_gram_ea / 100)
         # vegstat3   = fct_collapse(vegstat2, "Non-veg" = c("Non-veg", "Semi")))

# Convert to data in time-dependent form
ahs_medic_inc2_td <- tmerge(ahs_medic_inc2, ahs_medic_inc2, id=analysisid, 
               tstart = agein, tstop = ageout, hyperl = tdc(hyperl_age))

# Check
ahs_medic_inc2_td %>% 
  as_tibble() %>% 
  # filter(HYPERL_YN == "No") %>%
  filter(HYPERL_YN == "Yes") %>%
  select(analysisid, tstart, tstop, inc_AFIB, hyperl_age, hyperl, HYPERL_EVER, STROKE_TIA_EVER)

ahs_medic_inc2_td %>% 
  as_tibble() %>% 
  filter(HYPERL_YN == "Yes") %>%
  filter(hyperl_age < agein) %>%
  select(analysisid, agein, tstart, tstop, inc_AFIB, hyperl_age, hyperl, HYPERL_EVER, STROKE_TIA_EVER)

# Cox proportinal hazards model
coxm <- function(var, dsn = ahs_medic_inc2_td){
  fm <- formula(Surv(tstart, tstop, inc_AFIB) ~ var)
  mod <- coxph(fm, data = dsn, method = "efron")
  return(mod)
}

getHR <- function(coxph, digits = 2){
  hrci <- cbind(uniHR = exp(coef(coxph)), exp(confint(coxph))) %>% round(digits)
  return(hrci)
}
replace_var <- function(x, varname) gsub("var", varname, names(coef(x[1])))

# Function to calculate Wald CI
wald_ci <- function(beta, L, V, alpha = 0.05){
  est <- as.numeric(L %*% beta)
  se  <- as.numeric(sqrt(t(L) %*% V %*% L))
  ci  <- est + c(-1, 1) * qnorm(1 - alpha/2) * se
  # c(Estimate = est, SE = se, lwr = ci[1], upr = ci[2])
  c(Estimate = exp(est), lwr = exp(ci[1]), upr = exp(ci[2]))
}

# Function to calculate HR with interaction
rr_intx <- function(var, beta, V){
  i <- match(var, names(beta))
  L <- rep(0, length(beta))
  L[i] <- 1
  wald_ci(beta, L, V)
}


# Without time-dependent hyperlipidemia -----------------------------------

# Model 1
# Demographics, lifestyles, egg intake (as categorical) and kcal
mv_mod1 <- coxph(Surv(agein, ageout, inc_AFIB) ~ eggs_gram_ea_4 + 
                  bene_sex_F + rti_race3 + marital + educyou2 + 
                  bmicat + exercise + sleephrs2 + smokecat6 + alccat +  
                  kcal100, data = ahs_medic_inc2, method = "efron")

summary(mv_mod1)

# Model 2, adjusting for other foods
# Meat as categorical
# Other food groups as continuous
mv_mod2 <- update(mv_mod1, .~. + meat_gram_ea100 + fish_gram_ea100 + alldairy2_gram_ea100 + totalveg_gram_ea100 +
                                fruits_gram_ea100 + refgrains_gram_ea100 + whole_mixed_grains_gram_ea100 +
                                nutsseeds_gram_ea100 + legumes_gram_ea100)

summary(mv_mod2)

# Model3 3, adjusting for comorbidity 
mv_mod3 <- update(mv_mod2, .~. + como_depress + como_disab + como_diabetes + como_hyperl  + como_resp + 
                    como_anemia + como_kidney + como_hypoth + como_cancers)

summary(mv_mod3)

# gtsummary
library(gtsummary)

var_labels <- list(
  eggs_gram_ea_4                = "Egg (energy-adjusted)",
  bene_sex_F                    = "Sex",
  rti_race3                     = "Race (RTI race code)",
  marital                       = "Marital status",
  educyou2                      = "Educational level",
  bmicat                        = "BMI",
  exercise                      = "Exercise",
  sleephrs2                     = "Sleep hours",
  smokecat6                     = "Smoking status",
  alccat                        = "Alcohol use",
  kcal100                       = "Total energy (per 100 kcal)",
  meat_gram_ea100               = "Meat (per 100 g/d)",
  fish_gram_ea100               = "Fish (per 100 g/d)",
  alldairy2_gram_ea100          = "Dairy (per 100 g/d)",
  totalveg_gram_ea100           = "Total vegetables (per 100 g/d)",
  fruits_gram_ea100             = "Fruits (per 100 g/d)",
  refgrains_gram_ea100          = "Refined grains (per 100 g/d)",
  whole_mixed_grains_gram_ea100 = "Whole/mixed grains (per 100 g/d)",
  nutsseeds_gram_ea100          = "Nuts/seeds (per 100 g/d)",
  legumes_gram_ea100            = "Legumes (per 100 g/d)",
  como_depress                  = "Depression",
  como_disab                    = "Functional disability",
  como_diabetes                 = "Diabetes",
  como_hyperl                   = "Hyperlipidemia",
  como_resp                     = "Respiratory diseases",
  como_anemia                   = "Anemia",
  como_kidney                   = "Chronic kidney disease",
  como_hypoth                   = "Hypothyroid",
  como_cancers                  = "Cancers"
)

t1 <- tbl_regression(mv_mod1,
                     label = var_labels,
                     add_estimate_to_reference_rows = TRUE,
                     exponentiate = TRUE,
                     pvalue_fun = label_style_pvalue(digits = 3)) %>% 
  add_global_p(keep = FALSE)

t2 <- tbl_regression(mv_mod2,
                     label = var_labels,
                     add_estimate_to_reference_rows = TRUE,
                     exponentiate = TRUE,
                     pvalue_fun = label_style_pvalue(digits = 3)) %>% 
  add_global_p(keep = FALSE)

t3 <- tbl_regression(mv_mod3,
                     label = var_labels,
                     add_estimate_to_reference_rows = TRUE,
                     exponentiate = TRUE,
                     pvalue_fun = label_style_pvalue(digits = 3)) %>% 
  add_global_p(keep = FALSE)

tbl_merge(tbls = list(t1, t2, t3),
          tab_spanner = c("**Model 1**", "**Model 2**", "**Model 3**")) %>% 
  modify_header(label = "**Variable**", 
                p.value_1 = "**p**", 
                p.value_2 = "**p**", 
                p.value_3 = "**p**") %>% 
  as_flex_table()

# Checking interactions ---------------------------------------------------

# Egg x meat intereaction (as categorical)
# Not significant p = 0.958718
mv_mod3 %>% update(.~. - meat_gram_ea100 + eggs_gram_ea_4 * meat_gram_ea_4) %>% anova()

# Egg x fish intereaction (as categorical)
# Not significant p = 0.576888    
mv_mod3 %>% update(.~. - fish_gram_ea100 + eggs_gram_ea_4 * fish_gram_ea_4) %>% anova()

# Egg x dairy intereaction (as categorical)
# Not significant p = 0.972066 
mv_mod3 %>% update(.~. - alldairy2_gram_ea100 + eggs_gram_ea_4 * alldairy2_gram_ea_4) %>% anova()

# Checking the linearity of dietary variables -----------------------------

library(rms)
library(rmsMD)

# Restricted cubic spline
dd <- datadist(ahs_medic_inc2)
options(datadist='dd')

# Model 3
# Egg as cubic spline with 5 knots
# egg nonlinear p = 0.0011
# nuts/seed nonlinear p = 0.0379
mv_mod3_rcs <- cph(Surv(agein, ageout, inc_AFIB) ~ bene_sex_F + rti_race3 + marital + educyou2 + 
                       bmicat + exercise + sleephrs2 + smokecat6 + alccat + kcal100 +
                       rcs(eggs_gram_ea, parms = 4) + 
                       rcs(meat_gram_ea, parms = 4) + 
                       rcs(fish_gram_ea, parms = 4) + 
                       rcs(alldairy2_gram_ea, parms = 4) + 
                       rcs(totalveg_gram_ea, parms = 4) + 
                       rcs(fruits_gram_ea, parms = 4) + 
                       rcs(refgrains_gram_ea, parms = 4) + 
                       rcs(whole_mixed_grains_gram_ea, parms = 4) + 
                       rcs(nutsseeds_gram_ea, parms = 4) + 
                       rcs(legumes_gram_ea, parms = 4), 
                       data = ahs_medic_inc2, method = "efron", x = TRUE, y = TRUE)

anova(mv_mod3_rcs)
ggrmsMD(mv_mod3_rcs, ahs_medic_inc2, ncol = 5)

# Remove RCS terms for all other food groups
mv_mod3_rcs2 <- cph(Surv(agein, ageout, inc_AFIB) ~ bene_sex_F + rti_race3 + marital + educyou2 + 
                       bmicat + exercise + sleephrs2 + smokecat6 + alccat + kcal100 +
                       rcs(eggs_gram_ea, parms = 4) + 
                       meat_gram_ea + 
                       fish_gram_ea + 
                       alldairy2_gram_ea + 
                       totalveg_gram_ea + 
                       fruits_gram_ea + 
                       refgrains_gram_ea + 
                       whole_mixed_grains_gram_ea +
                       nutsseeds_gram_ea +
                       legumes_gram_ea, 
                       data = ahs_medic_inc2, method = "efron", x = TRUE, y = TRUE)

summary(mv_mod3_rcs2)
anova(mv_mod3_rcs2)
ggrmsMD(mv_mod3_rcs2, ahs_medic_inc2)

# Change the reference to 10 g/d
dd$limits$eggs_gram_ea[2] <- 10

mv_mod3_rcs3 <- update(mv_mod3_rcs2)
Predict(mv_mod3_rcs3, eggs_gram_ea = seq(0, 60, by = 5), fun = exp, ref.zero = TRUE) %>% 
  select(eggs_gram_ea, yhat, lower, upper)

Predict(mv_mod3_rcs3, eggs_gram_ea = c(5, 10, 15, 20, 30, 50), fun = exp, ref.zero = TRUE) %>% 
  select(eggs_gram_ea, yhat, lower, upper)

# pdf("RCS_egg_MV3_MI1.pdf", width = 6.5, height = 5)
Predict(mv_mod3_rcs3, eggs_gram_ea = seq(0, 50, by = 1), fun = exp, ref.zero = TRUE) %>% 
  ggplot() +
  geom_line(linewidth = 1.3) +
  scale_y_continuous(breaks = 9:14 / 10) +
  geom_hline(yintercept =  1, linetype = 2) +
  coord_cartesian(ylim = c(0.88, 1.22)) +
  labs(x = "Egg intake (energy-adjusted, gram/day)",
       y = "Adjusted hazard ratio (95% CI)",
       caption = "",
       title = "Model 3: Cubic spline for egg intake") +
  theme(text=element_text(size = 14))
# dev.off()

# Change the reference to 0 g/d
dd$limits$eggs_gram_ea[2] <- 0
mv_mod3_rcs3 <- update(mv_mod3_rcs2)

Predict(mv_mod3_rcs3, eggs_gram_ea = seq(0, 60, by = 5), fun = exp, ref.zero = TRUE) %>% 
  select(eggs_gram_ea, yhat, lower, upper)

# pdf("RCS_egg_MV3_MI1.pdf", width = 6.5, height = 5)
Predict(mv_mod3_rcs3, eggs_gram_ea = seq(0, 50, by = 1), fun = exp, ref.zero = TRUE) %>% 
  ggplot() +
  geom_line(linewidth = 1.3) +
  scale_y_continuous(breaks = 5:14 / 10) +
  geom_hline(yintercept =  1, linetype = 2) +
  coord_cartesian(ylim = c(0.7, 1.1)) +
  labs(x = "Egg intake (energy-adjusted, gram/day)",
       y = "Adjusted hazard ratio (95% CI)",
       caption = "",
       title = "Model 3: Cubic spline for egg intake (Ref = 0 g/d)") +
  theme(text=element_text(size = 14))
# dev.off()

# With time-dependent hyperlipidemia --------------------------------------

# Multivariable Cox model
mv_mod <- coxph(Surv(agein, ageout, inc_AFIB) ~ bene_sex_F + rti_race3 + marital + educyou2 + 
                  bmicat + exercise + sleephrs2 + smokecat6 + alccat + hyperl + 
                  kcal100 + eggs_gram_ea_4 + hyperl * eggs_gram_ea_4, data = ahs_medic_inc2_td, method = "efron")

mv_out  <- summary(mv_mod)
anova(mv_mod)

# For models with other food group
mv_mod2 <- update(mv_mod, .~. + meat_gram_ea + fish_gram_ea + alldairy2_gram_ea + totalveg_gram_ea +
                                fruits_gram_ea + refgrains_gram_ea + whole_mixed_grains_gram_ea +
                                nutsseeds_gram_ea + legumes_gram_ea)

mv_out <- summary(mv_mod2)
anova(mv_mod2)

# Model with comorbidity 
mv_mod3 <- update(mv_mod2, .~. + como_depress + como_disab + como_diabetes + como_resp + 
                    como_anemia + como_kidney + como_hypoth + como_cancers)
mv_out <- summary(mv_mod3)
anova(mv_mod3)
