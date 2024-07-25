Egg CVD study
================

## Aim

- Assess if the risk of developing CVD varies according to levels of
  meat intake among regular egg consumers with hyperlipidemia using the
  AHS-2 cohort linked with Medicare data

- Assess the interaction between race and egg intake on the incidence of
  CVD among those with hyperlipidemia.

## Datasets

- Medicare data
  - For details regarding Medicare data, see [AHS-2 Medicare
    Linkage](https://github.com/keijioda/ahs_medicare_linkage/blob/main/summary.md)
    repository.

  - Master Beneficiary Summary File (MBSF), 2008-2020

    - Contains beneficiary characteristics and enrollment information

  - Chronic Conditions file (CC), 2008-2020

    - Contains the first occurrence date of 27 specific chronic
      conditions
    - Used to identify prevalent/incident cases of dementia and/or
      Alzheimer’s disease and
    - to identify comorbidities

  - Both files include n = 44,585 unique subjects across years, after
    excluding

    - Gender/DOB mismatch with AHS-2 data
    - Dupulicate beneficiary IDs and SSNs
- AHS-2, n = 96,144
  - Baseline data
  - Dietary data
- After merging Medicare and AHS-2 data, there were n = 44,359 subjects.

## Inclusion/exclusion criteria

- Medicare beneficiaries who did not reach the age of 65 between 2008
  and 2020 (e.g., younger beneficiaries with disabilities or end-stage
  renal disease) were excluded (n = 1545), resulting n = 42,814.

- n = 1322 subjects with missing BMI or extreme BMI (\<16 or \>60),
  according to AHS questionnaire, were excluded, resulting n = 41,492.

- n = 1136 subjects with extreme calorie intake (\<500 or \>4500 kcal)
  were excluded, resulting n = 40,356.

- Unverified dates of deaths

  - Medicare data include a variable (`VALID_DEATH_DT_SW`) indicating
    whether a beneficiary’s day of death has been verified by the Social
    Security Administration or the Railroad Retirement Board.
  - There were 22 unverified death dates. Excluding these resulted n =
    40,334.

## Exploratory analysis

### Hyperlipidemia cases

- There are 21,635 (53.6%) subjects who have developed hyperlipidemia
  before the end of year 2020
- Among them, there are 6,491 subjects whose diagnosis date precedes the
  enrollment into AHS-2
- Plus, there are 647 subjects who were diagnosed within 6 months after
  the enrollment
- Thus, considering 6 months as a cut-off, there are 7,138 prevalent
  cases (33.0% among all hyperlipidemia cases)
- \[To consider\]
  - We could use the status of hyperlipidemia (yes/no) as time-dependent
    variable in the cox model
  - Or include into analysis anyone with the diagnoses regardless of
    prevalence/incidence?

### CVD cases

- The medicare data include five relevant diagnosis: Ischemic HD,
  stroke/TIA, acute MI, CHF, and atrial fibrillation
- For each of these 5 conditions, the number of cases (prevalence and
  incidence) is shown below:

|                              | Overall      |
|:-----------------------------|:-------------|
| n                            | 40334        |
| ISCHEMICHEART_EVER = Yes (%) | 14266 (35.4) |
| STROKE_TIA_EVER = Yes (%)    | 6306 (15.6)  |
| AMI_EVER = Yes (%)           | 1977 ( 4.9)  |
| CHF_EVER = Yes (%)           | 9818 (24.3)  |
| ATRIAL_FIB_EVER = Yes (%)    | 6527 (16.2)  |

- Many of these CVD cases have more than one of the 5 conditions. See
  below for the frequency table of CVD conditions:

| n_CVDs |     n |       pct |
|-------:|------:|----------:|
|      0 | 22153 | 0.5492389 |
|      1 |  6657 | 0.1650469 |
|      2 |  5081 | 0.1259731 |
|      3 |  4037 | 0.1000893 |
|      4 |  2066 | 0.0512223 |
|      5 |   340 | 0.0084296 |

- If we define CVD cases as any one of the 5 conditions:
  - There are 18,181 cases (45.1%) of CVDs
  - Among them, there are 5,315 prevalent cases and 12,866 incident
    cases
  - When the prevalent CVD cases were excluded, we have an analytic
    sample of n = 35,019 with 12,866 incident CVD cases (36.7%).
- \[Approach\] Start with all 5 conditions combined and then explore
  individual conditions as sensitivity analysis

### Other variables

- Other variables, including demographic, lifestyle, comorbidity, and
  dietary variables were defined as previously described
  - (Will add these descriptions later)
- Missing values in covariates
  - There were n = 2806 subjects who has at least one missing value on
    covariates (such as marital status, education, exercise level, sleep
    hours, smoking and alcohol use, all of them come from AHS
    questionnaire). These subjects were excluded, resulting in n =
    32,213.
  - Among them, there are 11,668 incident cases (36.2%) of CVD
- For those diagnosed with CVD, the mean age at diagnosis was 74.8 years
  (median 73.6 years)

|                                  | level          | Overall      | Non-case     | Case         | p       | test |
|:---------------------------------|:---------------|:-------------|:-------------|:-------------|:--------|:-----|
| n                                |                | 32213        | 20545        | 11668        |         |      |
| agecat (%)                       | 65-69          | 6377 (19.8)  | 5656 (27.5)  | 721 ( 6.2)   | \<0.001 |      |
|                                  | 70-74          | 6557 (20.4)  | 5068 (24.7)  | 1489 (12.8)  |         |      |
|                                  | 75-79          | 5775 (17.9)  | 3648 (17.8)  | 2127 (18.2)  |         |      |
|                                  | 80-84          | 4720 (14.7)  | 2474 (12.0)  | 2246 (19.2)  |         |      |
|                                  | 85-89          | 3522 (10.9)  | 1649 ( 8.0)  | 1873 (16.1)  |         |      |
|                                  | 90-94          | 2740 ( 8.5)  | 1143 ( 5.6)  | 1597 (13.7)  |         |      |
|                                  | 95+            | 2522 ( 7.8)  | 907 ( 4.4)   | 1615 (13.8)  |         |      |
| bene_age_at_end_2020 (mean (SD)) |                | 79.29 (9.75) | 76.64 (8.93) | 83.95 (9.38) | \<0.001 |      |
| bene_sex_F (%)                   | M              | 11495 (35.7) | 7038 (34.3)  | 4457 (38.2)  | \<0.001 |      |
|                                  | F              | 20718 (64.3) | 13507 (65.7) | 7211 (61.8)  |         |      |
| rti_race3 (%)                    | NH White       | 23715 (73.6) | 14534 (70.7) | 9181 (78.7)  | \<0.001 |      |
|                                  | Black          | 6185 (19.2)  | 4307 (21.0)  | 1878 (16.1)  |         |      |
|                                  | Other          | 2313 ( 7.2)  | 1704 ( 8.3)  | 609 ( 5.2)   |         |      |
| marital (%)                      | Married        | 24093 (74.8) | 15686 (76.3) | 8407 (72.1)  | \<0.001 |      |
|                                  | Never          | 1145 ( 3.6)  | 759 ( 3.7)   | 386 ( 3.3)   |         |      |
|                                  | Div/Wid        | 6975 (21.7)  | 4100 (20.0)  | 2875 (24.6)  |         |      |
| educyou (%)                      | HS or less     | 6320 (19.6)  | 3638 (17.7)  | 2682 (23.0)  | \<0.001 |      |
|                                  | Some college   | 12763 (39.6) | 8197 (39.9)  | 4566 (39.1)  |         |      |
|                                  | Col grad+      | 13130 (40.8) | 8710 (42.4)  | 4420 (37.9)  |         |      |
| vegstat (%)                      | Vegan          | 2951 ( 9.2)  | 1888 ( 9.2)  | 1063 ( 9.1)  | 0.046   |      |
|                                  | Lacto-ovo      | 10765 (33.4) | 6822 (33.2)  | 3943 (33.8)  |         |      |
|                                  | Semi           | 1804 ( 5.6)  | 1112 ( 5.4)  | 692 ( 5.9)   |         |      |
|                                  | Pesco          | 2967 ( 9.2)  | 1952 ( 9.5)  | 1015 ( 8.7)  |         |      |
|                                  | Non-veg        | 13726 (42.6) | 8771 (42.7)  | 4955 (42.5)  |         |      |
| bmicat (%)                       | Normal         | 12640 (39.2) | 8499 (41.4)  | 4141 (35.5)  | \<0.001 |      |
|                                  | Overweight     | 11604 (36.0) | 7364 (35.8)  | 4240 (36.3)  |         |      |
|                                  | Obese          | 7969 (24.7)  | 4682 (22.8)  | 3287 (28.2)  |         |      |
| bmi (mean (SD))                  |                | 27.26 (5.72) | 26.93 (5.52) | 27.82 (6.00) | \<0.001 |      |
| exercise (%)                     | None           | 7417 (23.0)  | 4566 (22.2)  | 2851 (24.4)  | \<0.001 |      |
|                                  | Low            | 7248 (22.5)  | 4568 (22.2)  | 2680 (23.0)  |         |      |
|                                  | Moderate       | 10833 (33.6) | 7002 (34.1)  | 3831 (32.8)  |         |      |
|                                  | Vigorous       | 6715 (20.8)  | 4409 (21.5)  | 2306 (19.8)  |         |      |
| sleephrs (%)                     | \<= 5 hrs      | 3044 ( 9.4)  | 1893 ( 9.2)  | 1151 ( 9.9)  | \<0.001 |      |
|                                  | 6 hrs          | 7081 (22.0)  | 4622 (22.5)  | 2459 (21.1)  |         |      |
|                                  | 7 hrs          | 11960 (37.1) | 7891 (38.4)  | 4069 (34.9)  |         |      |
|                                  | 8 hrs          | 8464 (26.3)  | 5199 (25.3)  | 3265 (28.0)  |         |      |
|                                  | \>= 9 hrs      | 1664 ( 5.2)  | 940 ( 4.6)   | 724 ( 6.2)   |         |      |
| smokecat (%)                     | Never          | 25800 (80.1) | 16637 (81.0) | 9163 (78.5)  | \<0.001 |      |
|                                  | Ever           | 6413 (19.9)  | 3908 (19.0)  | 2505 (21.5)  |         |      |
| alccat (%)                       | Never          | 19627 (60.9) | 12260 (59.7) | 7367 (63.1)  | \<0.001 |      |
|                                  | Ever           | 12586 (39.1) | 8285 (40.3)  | 4301 (36.9)  |         |      |
| como_depress (%)                 | No             | 31474 (97.7) | 20286 (98.7) | 11188 (95.9) | \<0.001 |      |
|                                  | Yes            | 739 ( 2.3)   | 259 ( 1.3)   | 480 ( 4.1)   |         |      |
| como_disab (%)                   | No             | 26889 (83.5) | 18836 (91.7) | 8053 (69.0)  | \<0.001 |      |
|                                  | Yes            | 5324 (16.5)  | 1709 ( 8.3)  | 3615 (31.0)  |         |      |
| como_diabetes (%)                | No             | 31212 (96.9) | 20258 (98.6) | 10954 (93.9) | \<0.001 |      |
|                                  | Yes            | 1001 ( 3.1)  | 287 ( 1.4)   | 714 ( 6.1)   |         |      |
| como_resp (%)                    | No             | 31568 (98.0) | 20374 (99.2) | 11194 (95.9) | \<0.001 |      |
|                                  | Yes            | 645 ( 2.0)   | 171 ( 0.8)   | 474 ( 4.1)   |         |      |
| como_kidney (%)                  | No             | 32050 (99.5) | 20502 (99.8) | 11548 (99.0) | \<0.001 |      |
|                                  | Yes            | 163 ( 0.5)   | 43 ( 0.2)    | 120 ( 1.0)   |         |      |
| como_hypoth (%)                  | No             | 30939 (96.0) | 20152 (98.1) | 10787 (92.4) | \<0.001 |      |
|                                  | Yes            | 1274 ( 4.0)  | 393 ( 1.9)   | 881 ( 7.6)   |         |      |
| como_cancers (%)                 | No             | 31483 (97.7) | 20321 (98.9) | 11162 (95.7) | \<0.001 |      |
|                                  | Yes            | 730 ( 2.3)   | 224 ( 1.1)   | 506 ( 4.3)   |         |      |
| meat_gram_ea_4 (%)               | None           | 16546 (51.4) | 10575 (51.5) | 5971 (51.2)  | 0.056   |      |
|                                  | \<11 g/d       | 5059 (15.7)  | 3189 (15.5)  | 1870 (16.0)  |         |      |
|                                  | 11-\<32 g/d    | 5130 (15.9)  | 3218 (15.7)  | 1912 (16.4)  |         |      |
|                                  | 32+ g/d        | 5478 (17.0)  | 3563 (17.3)  | 1915 (16.4)  |         |      |
| fish_gram_ea_4 (%)               | None           | 16331 (50.7) | 10334 (50.3) | 5997 (51.4)  | 0.006   |      |
|                                  | \<8.7 g/d      | 5253 (16.3)  | 3327 (16.2)  | 1926 (16.5)  |         |      |
|                                  | 8.7-\<17.4 g/d | 5348 (16.6)  | 3405 (16.6)  | 1943 (16.7)  |         |      |
|                                  | 17.4+ g/d      | 5281 (16.4)  | 3479 (16.9)  | 1802 (15.4)  |         |      |
| eggs_gram_ea_4 (%)               | \<3.6 g/d      | 8054 (25.0)  | 5139 (25.0)  | 2915 (25.0)  | 0.315   |      |
|                                  | 3.6-7.5 g/d    | 8053 (25.0)  | 5110 (24.9)  | 2943 (25.2)  |         |      |
|                                  | 7.5-\<16 g/d   | 8053 (25.0)  | 5201 (25.3)  | 2852 (24.4)  |         |      |
|                                  | 16+ g/d        | 8053 (25.0)  | 5095 (24.8)  | 2958 (25.4)  |         |      |
| dairy_gram_ea_4 (%)              | \<30 g/d       | 8054 (25.0)  | 5170 (25.2)  | 2884 (24.7)  | 0.753   |      |
|                                  | 30-100 g/d     | 8053 (25.0)  | 5118 (24.9)  | 2935 (25.2)  |         |      |
|                                  | 100-\<236 g/d  | 8053 (25.0)  | 5147 (25.1)  | 2906 (24.9)  |         |      |
|                                  | 236+ g/d       | 8053 (25.0)  | 5110 (24.9)  | 2943 (25.2)  |         |      |

- Let’s look at the same descriptive table only among those with
  hyperlipidemia. Among n = 32,213, there are 15,601 subjects (48.4%)
  have diagnosis of hyperlipidemia either before the enrollment or any
  time during the follow-up.
  - Among these, there are 9,364 incident cases (60.0%) of CVD.

|                                  | level          | Overall      | Non-case     | Case         | p       | test |
|:---------------------------------|:---------------|:-------------|:-------------|:-------------|:--------|:-----|
| n                                |                | 15601        | 6237         | 9364         |         |      |
| agecat (%)                       | 65-69          | 1434 ( 9.2)  | 908 (14.6)   | 526 ( 5.6)   | \<0.001 |      |
|                                  | 70-74          | 2731 (17.5)  | 1553 (24.9)  | 1178 (12.6)  |         |      |
|                                  | 75-79          | 3140 (20.1)  | 1365 (21.9)  | 1775 (19.0)  |         |      |
|                                  | 80-84          | 2964 (19.0)  | 1058 (17.0)  | 1906 (20.4)  |         |      |
|                                  | 85-89          | 2288 (14.7)  | 709 (11.4)   | 1579 (16.9)  |         |      |
|                                  | 90-94          | 1716 (11.0)  | 424 ( 6.8)   | 1292 (13.8)  |         |      |
|                                  | 95+            | 1328 ( 8.5)  | 220 ( 3.5)   | 1108 (11.8)  |         |      |
| bene_age_at_end_2020 (mean (SD)) |                | 81.64 (8.95) | 78.58 (8.12) | 83.67 (8.91) | \<0.001 |      |
| bene_sex_F (%)                   | M              | 5223 (33.5)  | 1774 (28.4)  | 3449 (36.8)  | \<0.001 |      |
|                                  | F              | 10378 (66.5) | 4463 (71.6)  | 5915 (63.2)  |         |      |
| rti_race3 (%)                    | NH White       | 12029 (77.1) | 4655 (74.6)  | 7374 (78.7)  | \<0.001 |      |
|                                  | Black          | 2652 (17.0)  | 1150 (18.4)  | 1502 (16.0)  |         |      |
|                                  | Other          | 920 ( 5.9)   | 432 ( 6.9)   | 488 ( 5.2)   |         |      |
| marital (%)                      | Married        | 11581 (74.2) | 4791 (76.8)  | 6790 (72.5)  | \<0.001 |      |
|                                  | Never          | 524 ( 3.4)   | 204 ( 3.3)   | 320 ( 3.4)   |         |      |
|                                  | Div/Wid        | 3496 (22.4)  | 1242 (19.9)  | 2254 (24.1)  |         |      |
| educyou (%)                      | HS or less     | 3310 (21.2)  | 1155 (18.5)  | 2155 (23.0)  | \<0.001 |      |
|                                  | Some college   | 6219 (39.9)  | 2523 (40.5)  | 3696 (39.5)  |         |      |
|                                  | Col grad+      | 6072 (38.9)  | 2559 (41.0)  | 3513 (37.5)  |         |      |
| vegstat (%)                      | Vegan          | 1140 ( 7.3)  | 416 ( 6.7)   | 724 ( 7.7)   | 0.057   |      |
|                                  | Lacto-ovo      | 5071 (32.5)  | 2013 (32.3)  | 3058 (32.7)  |         |      |
|                                  | Semi           | 954 ( 6.1)   | 371 ( 5.9)   | 583 ( 6.2)   |         |      |
|                                  | Pesco          | 1414 ( 9.1)  | 590 ( 9.5)   | 824 ( 8.8)   |         |      |
|                                  | Non-veg        | 7022 (45.0)  | 2847 (45.6)  | 4175 (44.6)  |         |      |
| bmicat (%)                       | Normal         | 5261 (33.7)  | 2232 (35.8)  | 3029 (32.3)  | \<0.001 |      |
|                                  | Overweight     | 5913 (37.9)  | 2403 (38.5)  | 3510 (37.5)  |         |      |
|                                  | Obese          | 4427 (28.4)  | 1602 (25.7)  | 2825 (30.2)  |         |      |
| bmi (mean (SD))                  |                | 27.92 (5.80) | 27.51 (5.47) | 28.20 (6.00) | \<0.001 |      |
| exercise (%)                     | None           | 3715 (23.8)  | 1447 (23.2)  | 2268 (24.2)  | 0.005   |      |
|                                  | Low            | 3497 (22.4)  | 1342 (21.5)  | 2155 (23.0)  |         |      |
|                                  | Moderate       | 5192 (33.3)  | 2097 (33.6)  | 3095 (33.1)  |         |      |
|                                  | Vigorous       | 3197 (20.5)  | 1351 (21.7)  | 1846 (19.7)  |         |      |
| sleephrs (%)                     | \<= 5 hrs      | 1474 ( 9.4)  | 522 ( 8.4)   | 952 (10.2)   | \<0.001 |      |
|                                  | 6 hrs          | 3366 (21.6)  | 1377 (22.1)  | 1989 (21.2)  |         |      |
|                                  | 7 hrs          | 5614 (36.0)  | 2381 (38.2)  | 3233 (34.5)  |         |      |
|                                  | 8 hrs          | 4255 (27.3)  | 1631 (26.2)  | 2624 (28.0)  |         |      |
|                                  | \>= 9 hrs      | 892 ( 5.7)   | 326 ( 5.2)   | 566 ( 6.0)   |         |      |
| smokecat (%)                     | Never          | 12477 (80.0) | 5118 (82.1)  | 7359 (78.6)  | \<0.001 |      |
|                                  | Ever           | 3124 (20.0)  | 1119 (17.9)  | 2005 (21.4)  |         |      |
| alccat (%)                       | Never          | 9823 (63.0)  | 3941 (63.2)  | 5882 (62.8)  | 0.649   |      |
|                                  | Ever           | 5778 (37.0)  | 2296 (36.8)  | 3482 (37.2)  |         |      |
| como_depress (%)                 | No             | 15012 (96.2) | 6056 (97.1)  | 8956 (95.6)  | \<0.001 |      |
|                                  | Yes            | 589 ( 3.8)   | 181 ( 2.9)   | 408 ( 4.4)   |         |      |
| como_disab (%)                   | No             | 11529 (73.9) | 5159 (82.7)  | 6370 (68.0)  | \<0.001 |      |
|                                  | Yes            | 4072 (26.1)  | 1078 (17.3)  | 2994 (32.0)  |         |      |
| como_diabetes (%)                | No             | 14691 (94.2) | 5997 (96.2)  | 8694 (92.8)  | \<0.001 |      |
|                                  | Yes            | 910 ( 5.8)   | 240 ( 3.8)   | 670 ( 7.2)   |         |      |
| como_resp (%)                    | No             | 15105 (96.8) | 6127 (98.2)  | 8978 (95.9)  | \<0.001 |      |
|                                  | Yes            | 496 ( 3.2)   | 110 ( 1.8)   | 386 ( 4.1)   |         |      |
| como_kidney (%)                  | No             | 15460 (99.1) | 6200 (99.4)  | 9260 (98.9)  | 0.001   |      |
|                                  | Yes            | 141 ( 0.9)   | 37 ( 0.6)    | 104 ( 1.1)   |         |      |
| como_hypoth (%)                  | No             | 14556 (93.3) | 5958 (95.5)  | 8598 (91.8)  | \<0.001 |      |
|                                  | Yes            | 1045 ( 6.7)  | 279 ( 4.5)   | 766 ( 8.2)   |         |      |
| como_cancers (%)                 | No             | 15045 (96.4) | 6094 (97.7)  | 8951 (95.6)  | \<0.001 |      |
|                                  | Yes            | 556 ( 3.6)   | 143 ( 2.3)   | 413 ( 4.4)   |         |      |
| meat_gram_ea_4 (%)               | None           | 7557 (48.4)  | 2990 (47.9)  | 4567 (48.8)  | 0.751   |      |
|                                  | \<11 g/d       | 2640 (16.9)  | 1074 (17.2)  | 1566 (16.7)  |         |      |
|                                  | 11-\<32 g/d    | 2672 (17.1)  | 1073 (17.2)  | 1599 (17.1)  |         |      |
|                                  | 32+ g/d        | 2732 (17.5)  | 1100 (17.6)  | 1632 (17.4)  |         |      |
| fish_gram_ea_4 (%)               | None           | 7549 (48.4)  | 2940 (47.1)  | 4609 (49.2)  | 0.014   |      |
|                                  | \<8.7 g/d      | 2690 (17.2)  | 1118 (17.9)  | 1572 (16.8)  |         |      |
|                                  | 8.7-\<17.4 g/d | 2750 (17.6)  | 1084 (17.4)  | 1666 (17.8)  |         |      |
|                                  | 17.4+ g/d      | 2612 (16.7)  | 1095 (17.6)  | 1517 (16.2)  |         |      |
| eggs_gram_ea_4 (%)               | \<3.6 g/d      | 3564 (22.8)  | 1391 (22.3)  | 2173 (23.2)  | 0.616   |      |
|                                  | 3.6-7.5 g/d    | 3996 (25.6)  | 1610 (25.8)  | 2386 (25.5)  |         |      |
|                                  | 7.5-\<16 g/d   | 3980 (25.5)  | 1607 (25.8)  | 2373 (25.3)  |         |      |
|                                  | 16+ g/d        | 4061 (26.0)  | 1629 (26.1)  | 2432 (26.0)  |         |      |
| dairy_gram_ea_4 (%)              | \<30 g/d       | 3427 (22.0)  | 1297 (20.8)  | 2130 (22.7)  | 0.008   |      |
|                                  | 30-100 g/d     | 3921 (25.1)  | 1544 (24.8)  | 2377 (25.4)  |         |      |
|                                  | 100-\<236 g/d  | 4084 (26.2)  | 1674 (26.8)  | 2410 (25.7)  |         |      |
|                                  | 236+ g/d       | 4169 (26.7)  | 1722 (27.6)  | 2447 (26.1)  |         |      |

## To do

- Let’s move on to Cox models: Modeling strategy:
  - Model with dietary pattern, adjusting for demographics and lifestyle
    variables
  - Model including meat and egg without dietary pattern, adjusting for
    others
  - Examine meat/egg interaction if necessary
  - Adding further diaetary variables as covariates?
- Depending on results, we could change CVD criteria?
