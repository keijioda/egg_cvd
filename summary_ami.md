Egg CVD study (acute MI as outcome)
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

  - Master Beneficiary Summary File (MBSF), 2008-2022

    - Contains beneficiary characteristics and enrollment information

  - Chronic Conditions file (CC), 2008-2022

    - Contains the first occurrence date of 27 or 30 specific chronic
      conditions
      - 27 chronic conditions for data 2008-2020
      - 30 chronic conditions for data 2021-2022
    - Used to identify prevalent/incident cases of cardio-vascular
      diseases and
    - to identify comorbidities

  - Both files include n = 46,897 unique subjects across years, after
    excluding

    - Gender/DOB mismatch with AHS-2 data
    - Dupulicate beneficiary IDs and SSNs
- For AHS-2 baseline data, including food-frequency questionnaire (FFQ),
  a guided multiple imputation was used to fill missing data ([Fraser &
  Yan, 2007](https://pubmed.ncbi.nlm.nih.gov/17259903/))
  - Five imputed data sets were generated for subsequent analyses (See
    the analysis section for more details)
  - For descriptive analysis, we present results from the first imputed
    data
- AHS-2 baseline imputed data \#1: n = 41,037
  - ~~Among this, n = 383 subjects were excluded because they opted out
    of the study~~
  - ~~After removing opt-outs, there were n = 87,668 subjects~~
  - Opt-outs were already excluded
- After merging Medicare and AHS-2 data, there were n = 41,037 subjects.

## Inclusion/exclusion criteria

- Medicare beneficiaries who did not reach the age of 65 between 2008
  and 2020 (e.g., younger beneficiaries with disabilities or end-stage
  renal disease) were excluded (n = 1105), resulting n = 39,932.

- Subjects with extreme BMI (\<16 or \>60), according to AHS
  questionnaire, were excluded (n = 82), resulting n = 39,850.

- Unverified dates of deaths

  - Medicare data include a variable (`VALID_DEATH_DT_SW`) indicating
    whether a beneficiary’s day of death has been verified by the Social
    Security Administration or the Railroad Retirement Board.
  - There were 23 unverified death dates. Excluding these resulted n =
    39,827.

- Prevalent cases of acute MI

  - If the first diagnosis was made on or before AHS-2 enrollment date,
    consider it as a prevalent case
  - n = 157 prevalent cases were excluded, resulting n = 39,670 subjects

## Outcome

- The outcome is acute MI
- Among n = 39,670 subjects, there were 1700 incident cases (4.3%) of
  acute MI
- Age at diagnosis was calculated using `AMI_EVER` variable in the
  Chronic Condition Warehouse (CCW) data. This variable shows the date
  when the beneficiary first met the criteria after January 1, 1999.
  - For 27 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/documents/10280/19139421/ccw-chronic-condition-algorithms.pdf)
  - For 30 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/web/guest/condition-categories-chronic)
- Among these incident acute MI cases, the mean (SD) age of diagnosis
  was 81.9 (8.4) years. The median age of diagnosis was 82.4 years.

## Comorbidity

## Dietary variables

## Descriptive table

- The descriptive table by acute MI incidence:

|  | level | Overall | Non-case | Case | p | test |
|:---|:---|:---|:---|:---|:---|:---|
| n |  | 39670 | 37970 | 1700 |  |  |
| agecat (%) | 65-69 | 6679 (16.9) | 6622 (17.5) | 57 ( 3.4) | \<0.001 |  |
|  | 70-74 | 6947 (17.6) | 6819 (18.1) | 128 ( 7.6) |  |  |
|  | 75-79 | 6290 (15.9) | 6084 (16.1) | 206 (12.2) |  |  |
|  | 80-84 | 5622 (14.3) | 5365 (14.2) | 257 (15.2) |  |  |
|  | 85-89 | 5029 (12.8) | 4712 (12.5) | 317 (18.7) |  |  |
|  | 90-94 | 4263 (10.8) | 3933 (10.4) | 330 (19.5) |  |  |
|  | 95+ | 4611 (11.7) | 4212 (11.2) | 399 (23.6) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 81.02 (10.52) | 80.72 (10.46) | 87.70 (9.65) | \<0.001 |  |
| bene_sex_F (%) | M | 14356 (36.2) | 13597 (35.8) | 759 (44.6) | \<0.001 |  |
|  | F | 25314 (63.8) | 24373 (64.2) | 941 (55.4) |  |  |
| rti_race3 (%) | NH White | 29436 (74.2) | 28038 (73.8) | 1398 (82.2) | \<0.001 |  |
|  | Black | 7574 (19.1) | 7345 (19.3) | 229 (13.5) |  |  |
|  | Other | 2660 ( 6.7) | 2587 ( 6.8) | 73 ( 4.3) |  |  |
| marital (%) | Married | 28996 (73.1) | 27812 (73.2) | 1184 (69.6) | \<0.001 |  |
|  | Never | 1369 ( 3.5) | 1337 ( 3.5) | 32 ( 1.9) |  |  |
|  | Div/Wid | 9305 (23.5) | 8821 (23.2) | 484 (28.5) |  |  |
| educyou (%) | HSch & below | 8542 (21.5) | 8067 (21.2) | 475 (27.9) | \<0.001 |  |
|  | Some College | 15700 (39.6) | 15041 (39.6) | 659 (38.8) |  |  |
|  | Bachelors + | 15428 (38.9) | 14862 (39.1) | 566 (33.3) |  |  |
| vegstat (%) | Vegan | 3282 ( 8.3) | 3150 ( 8.3) | 132 ( 7.8) | 0.129 |  |
|  | Lacto-ovo | 12803 (32.3) | 12243 (32.2) | 560 (32.9) |  |  |
|  | Semi | 2205 ( 5.6) | 2089 ( 5.5) | 116 ( 6.8) |  |  |
|  | Pesco | 3800 ( 9.6) | 3633 ( 9.6) | 167 ( 9.8) |  |  |
|  | Non-veg | 17580 (44.3) | 16855 (44.4) | 725 (42.6) |  |  |
| bmicat (%) | Normal | 15330 (38.6) | 14743 (38.8) | 587 (34.5) | 0.002 |  |
|  | Overweight | 14456 (36.4) | 13803 (36.4) | 653 (38.4) |  |  |
|  | Obese | 9884 (24.9) | 9424 (24.8) | 460 (27.1) |  |  |
| bmi (mean (SD)) |  | 27.21 (5.47) | 27.19 (5.47) | 27.61 (5.45) | 0.002 |  |
| exercise (%) | None | 8818 (22.2) | 8295 (21.8) | 523 (30.8) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9609 (24.2) | 9240 (24.3) | 369 (21.7) |  |  |
|  | 0.5\<-2 hrs/wk | 10487 (26.4) | 10101 (26.6) | 386 (22.7) |  |  |
|  | \>2 hrs/wk | 10756 (27.1) | 10334 (27.2) | 422 (24.8) |  |  |
| sleephrs (%) | \<= 5 hrs | 3887 ( 9.8) | 3719 ( 9.8) | 168 ( 9.9) | \<0.001 |  |
|  | 6 hrs | 8639 (21.8) | 8266 (21.8) | 373 (21.9) |  |  |
|  | 7 hrs | 14340 (36.1) | 13792 (36.3) | 548 (32.2) |  |  |
|  | 8 hrs | 10529 (26.5) | 10052 (26.5) | 477 (28.1) |  |  |
|  | \>= 9 hrs | 2275 ( 5.7) | 2141 ( 5.6) | 134 ( 7.9) |  |  |
| smokecat6 (%) | A_Never | 31590 (79.6) | 30319 (79.8) | 1271 (74.8) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3406 ( 8.6) | 3189 ( 8.4) | 217 (12.8) |  |  |
|  | C_QuitYrs21To30 | 2024 ( 5.1) | 1941 ( 5.1) | 83 ( 4.9) |  |  |
|  | D_QuitYrs11To20 | 1368 ( 3.4) | 1299 ( 3.4) | 69 ( 4.1) |  |  |
|  | E_QuitYrs6To10 | 485 ( 1.2) | 462 ( 1.2) | 23 ( 1.4) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 797 ( 2.0) | 760 ( 2.0) | 37 ( 2.2) |  |  |
| alccat (%) | Never | 37737 (95.1) | 36097 (95.1) | 1640 (96.5) | 0.010 |  |
|  | Current | 1933 ( 4.9) | 1873 ( 4.9) | 60 ( 3.5) |  |  |
| como_depress (%) | No | 38819 (97.9) | 37203 (98.0) | 1616 (95.1) | \<0.001 |  |
|  | Yes | 851 ( 2.1) | 767 ( 2.0) | 84 ( 4.9) |  |  |
| como_disab (%) | No | 33806 (85.2) | 32718 (86.2) | 1088 (64.0) | \<0.001 |  |
|  | Yes | 5864 (14.8) | 5252 (13.8) | 612 (36.0) |  |  |
| como_diabetes (%) | No | 38171 (96.2) | 36659 (96.5) | 1512 (88.9) | \<0.001 |  |
|  | Yes | 1499 ( 3.8) | 1311 ( 3.5) | 188 (11.1) |  |  |
| como_hypert (%) | No | 35367 (89.2) | 34165 (90.0) | 1202 (70.7) | \<0.001 |  |
|  | Yes | 4303 (10.8) | 3805 (10.0) | 498 (29.3) |  |  |
| como_hyperl (%) | No | 36222 (91.3) | 34942 (92.0) | 1280 (75.3) | \<0.001 |  |
|  | Yes | 3448 ( 8.7) | 3028 ( 8.0) | 420 (24.7) |  |  |
| como_resp (%) | No | 38620 (97.4) | 37031 (97.5) | 1589 (93.5) | \<0.001 |  |
|  | Yes | 1050 ( 2.6) | 939 ( 2.5) | 111 ( 6.5) |  |  |
| como_anemia (%) | No | 37267 (93.9) | 35830 (94.4) | 1437 (84.5) | \<0.001 |  |
|  | Yes | 2403 ( 6.1) | 2140 ( 5.6) | 263 (15.5) |  |  |
| como_kidney (%) | No | 39288 (99.0) | 37647 (99.1) | 1641 (96.5) | \<0.001 |  |
|  | Yes | 382 ( 1.0) | 323 ( 0.9) | 59 ( 3.5) |  |  |
| como_hypoth (%) | No | 38143 (96.2) | 36614 (96.4) | 1529 (89.9) | \<0.001 |  |
|  | Yes | 1527 ( 3.8) | 1356 ( 3.6) | 171 (10.1) |  |  |
| como_cancers (%) | No | 38781 (97.8) | 37179 (97.9) | 1602 (94.2) | \<0.001 |  |
|  | Yes | 889 ( 2.2) | 791 ( 2.1) | 98 ( 5.8) |  |  |
| eggs_gram_ea_5 (%) | None | 10704 (27.0) | 10220 (26.9) | 484 (28.5) | 0.262 |  |
|  | \<4 g/d | 8575 (21.6) | 8242 (21.7) | 333 (19.6) |  |  |
|  | 4-\<10 g/d | 8069 (20.3) | 7717 (20.3) | 352 (20.7) |  |  |
|  | 10-\<23 g/d | 7355 (18.5) | 7044 (18.6) | 311 (18.3) |  |  |
|  | 23+ g/d | 4967 (12.5) | 4747 (12.5) | 220 (12.9) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.03 (16.01) | 9.99 (15.85) | 10.92 (19.10) | 0.019 |  |
| meat_gram_ea (mean (SD)) |  | 14.68 (26.04) | 14.73 (26.13) | 13.48 (23.88) | 0.053 |  |
| fish_gram_ea (mean (SD)) |  | 9.05 (16.29) | 9.11 (16.40) | 7.74 (13.52) | 0.001 |  |
| alldairy2_gram_ea (mean (SD)) |  | 149.26 (187.11) | 149.01 (186.41) | 154.82 (202.13) | 0.210 |  |
| totalveg_gram_ea (mean (SD)) |  | 302.40 (179.12) | 302.20 (179.09) | 306.73 (179.87) | 0.309 |  |
| fruits_gram_ea (mean (SD)) |  | 321.94 (221.62) | 321.69 (221.65) | 327.41 (220.81) | 0.298 |  |
| refgrains_gram_ea (mean (SD)) |  | 113.31 (116.50) | 113.67 (116.60) | 105.48 (113.97) | 0.005 |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.46 (188.66) | 256.12 (188.52) | 264.08 (191.70) | 0.089 |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.39 (20.26) | 23.36 (20.28) | 24.01 (19.73) | 0.195 |  |
| legumes_gram_ea (mean (SD)) |  | 77.28 (69.15) | 77.37 (69.22) | 75.29 (67.48) | 0.225 |  |

- The descriptive table by egg intake (5 groups):

|  | level | Overall | None | \<4 g/d | 4-\<10 g/d | 10-\<23 g/d | 23+ g/d | p | test |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| n |  | 39670 | 10704 | 8575 | 8069 | 7355 | 4967 |  |  |
| AMI_YN (%) | No | 37970 (95.7) | 10220 (95.5) | 8242 (96.1) | 7717 (95.6) | 7044 (95.8) | 4747 (95.6) | 0.262 |  |
|  | Yes | 1700 ( 4.3) | 484 ( 4.5) | 333 ( 3.9) | 352 ( 4.4) | 311 ( 4.2) | 220 ( 4.4) |  |  |
| agecat (%) | 65-69 | 6679 (16.9) | 1644 (15.4) | 1432 (16.8) | 1438 (17.9) | 1267 (17.3) | 898 (18.2) | \<0.001 |  |
|  | 70-74 | 6947 (17.6) | 1799 (16.9) | 1456 (17.1) | 1483 (18.5) | 1261 (17.2) | 948 (19.2) |  |  |
|  | 75-79 | 6290 (15.9) | 1674 (15.7) | 1340 (15.7) | 1305 (16.3) | 1118 (15.3) | 853 (17.3) |  |  |
|  | 80-84 | 5622 (14.3) | 1533 (14.4) | 1194 (14.0) | 1114 (13.9) | 1044 (14.3) | 737 (14.9) |  |  |
|  | 85-89 | 5029 (12.8) | 1385 (13.0) | 1080 (12.7) | 1027 (12.8) | 938 (12.8) | 599 (12.2) |  |  |
|  | 90-94 | 4263 (10.8) | 1241 (11.7) | 946 (11.1) | 796 ( 9.9) | 803 (11.0) | 477 ( 9.7) |  |  |
|  | 95+ | 4611 (11.7) | 1371 (12.9) | 1087 (12.7) | 850 (10.6) | 885 (12.1) | 418 ( 8.5) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 81.02 (10.52) | 81.66 (10.63) | 81.35 (10.72) | 80.45 (10.33) | 81.16 (10.67) | 79.83 (9.89) | \<0.001 |  |
| bene_sex_F (%) | M | 14356 (36.2) | 3792 (35.4) | 2676 (31.2) | 3103 (38.5) | 2700 (36.7) | 2085 (42.0) | \<0.001 |  |
|  | F | 25314 (63.8) | 6912 (64.6) | 5899 (68.8) | 4966 (61.5) | 4655 (63.3) | 2882 (58.0) |  |  |
| rti_race3 (%) | NH White | 29436 (74.2) | 7832 (73.2) | 5977 (69.7) | 6028 (74.7) | 5655 (76.9) | 3944 (79.4) | \<0.001 |  |
|  | Black | 7574 (19.1) | 2219 (20.7) | 1928 (22.5) | 1466 (18.2) | 1202 (16.3) | 759 (15.3) |  |  |
|  | Other | 2660 ( 6.7) | 653 ( 6.1) | 670 ( 7.8) | 575 ( 7.1) | 498 ( 6.8) | 264 ( 5.3) |  |  |
| marital (%) | Married | 28996 (73.1) | 7752 (72.4) | 6100 (71.1) | 6034 (74.8) | 5493 (74.7) | 3617 (72.8) | \<0.001 |  |
|  | Never | 1369 ( 3.5) | 435 ( 4.1) | 325 ( 3.8) | 231 ( 2.9) | 213 ( 2.9) | 165 ( 3.3) |  |  |
|  | Div/Wid | 9305 (23.5) | 2517 (23.5) | 2150 (25.1) | 1804 (22.4) | 1649 (22.4) | 1185 (23.9) |  |  |
| educyou (%) | HSch & below | 8542 (21.5) | 2164 (20.2) | 1925 (22.4) | 1710 (21.2) | 1559 (21.2) | 1184 (23.8) | \<0.001 |  |
|  | Some College | 15700 (39.6) | 4082 (38.1) | 3336 (38.9) | 3161 (39.2) | 2982 (40.5) | 2139 (43.1) |  |  |
|  | Bachelors + | 15428 (38.9) | 4458 (41.6) | 3314 (38.6) | 3198 (39.6) | 2814 (38.3) | 1644 (33.1) |  |  |
| vegstat (%) | Vegan | 3282 ( 8.3) | 3282 (30.7) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | \<0.001 |  |
|  | Lacto-ovo | 12803 (32.3) | 4227 (39.5) | 3290 (38.4) | 2435 (30.2) | 1892 (25.7) | 959 (19.3) |  |  |
|  | Semi | 2205 ( 5.6) | 391 ( 3.7) | 588 ( 6.9) | 569 ( 7.1) | 388 ( 5.3) | 269 ( 5.4) |  |  |
|  | Pesco | 3800 ( 9.6) | 1083 (10.1) | 925 (10.8) | 782 ( 9.7) | 683 ( 9.3) | 327 ( 6.6) |  |  |
|  | Non-veg | 17580 (44.3) | 1721 (16.1) | 3772 (44.0) | 4283 (53.1) | 4392 (59.7) | 3412 (68.7) |  |  |
| bmicat (%) | Normal | 15330 (38.6) | 5620 (52.5) | 3436 (40.1) | 2803 (34.7) | 2292 (31.2) | 1179 (23.7) | \<0.001 |  |
|  | Overweight | 14456 (36.4) | 3371 (31.5) | 3211 (37.4) | 3138 (38.9) | 2876 (39.1) | 1860 (37.4) |  |  |
|  | Obese | 9884 (24.9) | 1713 (16.0) | 1928 (22.5) | 2128 (26.4) | 2187 (29.7) | 1928 (38.8) |  |  |
| bmi (mean (SD)) |  | 27.21 (5.47) | 25.59 (4.97) | 26.95 (5.25) | 27.62 (5.40) | 28.02 (5.47) | 29.31 (5.89) | \<0.001 |  |
| exercise (%) | None | 8818 (22.2) | 2124 (19.8) | 1892 (22.1) | 1808 (22.4) | 1629 (22.1) | 1365 (27.5) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9609 (24.2) | 2218 (20.7) | 2001 (23.3) | 2140 (26.5) | 1920 (26.1) | 1330 (26.8) |  |  |
|  | 0.5\<-2 hrs/wk | 10487 (26.4) | 2867 (26.8) | 2284 (26.6) | 2130 (26.4) | 2004 (27.2) | 1202 (24.2) |  |  |
|  | \>2 hrs/wk | 10756 (27.1) | 3495 (32.7) | 2398 (28.0) | 1991 (24.7) | 1802 (24.5) | 1070 (21.5) |  |  |
| sleephrs (%) | \<= 5 hrs | 3887 ( 9.8) | 985 ( 9.2) | 907 (10.6) | 772 ( 9.6) | 707 ( 9.6) | 516 (10.4) | \<0.001 |  |
|  | 6 hrs | 8639 (21.8) | 2245 (21.0) | 1915 (22.3) | 1827 (22.6) | 1558 (21.2) | 1094 (22.0) |  |  |
|  | 7 hrs | 14340 (36.1) | 3916 (36.6) | 3034 (35.4) | 2949 (36.5) | 2686 (36.5) | 1755 (35.3) |  |  |
|  | 8 hrs | 10529 (26.5) | 2961 (27.7) | 2226 (26.0) | 2099 (26.0) | 1971 (26.8) | 1272 (25.6) |  |  |
|  | \>= 9 hrs | 2275 ( 5.7) | 597 ( 5.6) | 493 ( 5.7) | 422 ( 5.2) | 433 ( 5.9) | 330 ( 6.6) |  |  |
| smokecat6 (%) | A_Never | 31590 (79.6) | 8825 (82.4) | 7086 (82.6) | 6357 (78.8) | 5791 (78.7) | 3531 (71.1) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3406 ( 8.6) | 894 ( 8.4) | 626 ( 7.3) | 686 ( 8.5) | 650 ( 8.8) | 550 (11.1) |  |  |
|  | C_QuitYrs21To30 | 2024 ( 5.1) | 505 ( 4.7) | 385 ( 4.5) | 408 ( 5.1) | 399 ( 5.4) | 327 ( 6.6) |  |  |
|  | D_QuitYrs11To20 | 1368 ( 3.4) | 272 ( 2.5) | 253 ( 3.0) | 317 ( 3.9) | 264 ( 3.6) | 262 ( 5.3) |  |  |
|  | E_QuitYrs6To10 | 485 ( 1.2) | 98 ( 0.9) | 75 ( 0.9) | 116 ( 1.4) | 92 ( 1.3) | 104 ( 2.1) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 797 ( 2.0) | 110 ( 1.0) | 150 ( 1.7) | 185 ( 2.3) | 159 ( 2.2) | 193 ( 3.9) |  |  |
| alccat (%) | Never | 37737 (95.1) | 10502 (98.1) | 8236 (96.0) | 7599 (94.2) | 6877 (93.5) | 4523 (91.1) | \<0.001 |  |
|  | Current | 1933 ( 4.9) | 202 ( 1.9) | 339 ( 4.0) | 470 ( 5.8) | 478 ( 6.5) | 444 ( 8.9) |  |  |
| como_depress (%) | No | 38819 (97.9) | 10475 (97.9) | 8384 (97.8) | 7912 (98.1) | 7193 (97.8) | 4855 (97.7) | 0.698 |  |
|  | Yes | 851 ( 2.1) | 229 ( 2.1) | 191 ( 2.2) | 157 ( 1.9) | 162 ( 2.2) | 112 ( 2.3) |  |  |
| como_disab (%) | No | 33806 (85.2) | 8965 (83.8) | 7282 (84.9) | 6985 (86.6) | 6235 (84.8) | 4339 (87.4) | \<0.001 |  |
|  | Yes | 5864 (14.8) | 1739 (16.2) | 1293 (15.1) | 1084 (13.4) | 1120 (15.2) | 628 (12.6) |  |  |
| como_diabetes (%) | No | 38171 (96.2) | 10390 (97.1) | 8274 (96.5) | 7759 (96.2) | 7029 (95.6) | 4719 (95.0) | \<0.001 |  |
|  | Yes | 1499 ( 3.8) | 314 ( 2.9) | 301 ( 3.5) | 310 ( 3.8) | 326 ( 4.4) | 248 ( 5.0) |  |  |
| como_hypert (%) | No | 35367 (89.2) | 9630 (90.0) | 7617 (88.8) | 7216 (89.4) | 6467 (87.9) | 4437 (89.3) | \<0.001 |  |
|  | Yes | 4303 (10.8) | 1074 (10.0) | 958 (11.2) | 853 (10.6) | 888 (12.1) | 530 (10.7) |  |  |
| como_hyperl (%) | No | 36222 (91.3) | 9787 (91.4) | 7818 (91.2) | 7369 (91.3) | 6680 (90.8) | 4568 (92.0) | 0.256 |  |
|  | Yes | 3448 ( 8.7) | 917 ( 8.6) | 757 ( 8.8) | 700 ( 8.7) | 675 ( 9.2) | 399 ( 8.0) |  |  |
| como_resp (%) | No | 38620 (97.4) | 10447 (97.6) | 8327 (97.1) | 7885 (97.7) | 7140 (97.1) | 4821 (97.1) | 0.014 |  |
|  | Yes | 1050 ( 2.6) | 257 ( 2.4) | 248 ( 2.9) | 184 ( 2.3) | 215 ( 2.9) | 146 ( 2.9) |  |  |
| como_anemia (%) | No | 37267 (93.9) | 9989 (93.3) | 8043 (93.8) | 7631 (94.6) | 6902 (93.8) | 4702 (94.7) | 0.001 |  |
|  | Yes | 2403 ( 6.1) | 715 ( 6.7) | 532 ( 6.2) | 438 ( 5.4) | 453 ( 6.2) | 265 ( 5.3) |  |  |
| como_kidney (%) | No | 39288 (99.0) | 10615 (99.2) | 8506 (99.2) | 7995 (99.1) | 7269 (98.8) | 4903 (98.7) | 0.010 |  |
|  | Yes | 382 ( 1.0) | 89 ( 0.8) | 69 ( 0.8) | 74 ( 0.9) | 86 ( 1.2) | 64 ( 1.3) |  |  |
| como_hypoth (%) | No | 38143 (96.2) | 10279 (96.0) | 8214 (95.8) | 7776 (96.4) | 7052 (95.9) | 4822 (97.1) | 0.002 |  |
|  | Yes | 1527 ( 3.8) | 425 ( 4.0) | 361 ( 4.2) | 293 ( 3.6) | 303 ( 4.1) | 145 ( 2.9) |  |  |
| como_cancers (%) | No | 38781 (97.8) | 10450 (97.6) | 8371 (97.6) | 7916 (98.1) | 7176 (97.6) | 4868 (98.0) | 0.071 |  |
|  | Yes | 889 ( 2.2) | 254 ( 2.4) | 204 ( 2.4) | 153 ( 1.9) | 179 ( 2.4) | 99 ( 2.0) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.03 (16.01) | 0.00 (0.00) | 2.94 (0.71) | 6.38 (1.55) | 17.29 (3.64) | 39.07 (27.84) | \<0.001 |  |
| meat_gram_ea (mean (SD)) |  | 14.68 (26.04) | 4.45 (15.28) | 11.72 (21.16) | 16.82 (25.77) | 20.88 (29.04) | 29.16 (36.03) | \<0.001 |  |
| fish_gram_ea (mean (SD)) |  | 9.05 (16.29) | 4.54 (14.44) | 8.99 (16.51) | 10.34 (15.96) | 11.73 (16.27) | 12.83 (17.95) | \<0.001 |  |
| alldairy2_gram_ea (mean (SD)) |  | 149.26 (187.11) | 63.90 (139.34) | 151.70 (187.56) | 181.78 (194.50) | 202.09 (191.89) | 197.90 (192.78) | \<0.001 |  |
| totalveg_gram_ea (mean (SD)) |  | 302.40 (179.12) | 342.16 (209.53) | 302.76 (174.33) | 284.58 (160.70) | 285.00 (156.30) | 270.78 (160.30) | \<0.001 |  |
| fruits_gram_ea (mean (SD)) |  | 321.94 (221.62) | 397.09 (245.54) | 339.05 (228.10) | 295.77 (201.71) | 277.65 (186.67) | 238.55 (176.66) | \<0.001 |  |
| refgrains_gram_ea (mean (SD)) |  | 113.31 (116.50) | 97.89 (115.79) | 117.49 (119.61) | 118.51 (116.21) | 124.02 (115.85) | 115.06 (110.64) | \<0.001 |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.46 (188.66) | 329.65 (212.87) | 264.36 (188.94) | 229.65 (172.06) | 214.54 (150.48) | 190.73 (153.75) | \<0.001 |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.39 (20.26) | 28.25 (22.61) | 23.39 (20.36) | 21.57 (19.00) | 20.97 (17.91) | 19.45 (17.88) | \<0.001 |  |
| legumes_gram_ea (mean (SD)) |  | 77.28 (69.15) | 93.77 (82.45) | 79.14 (70.40) | 70.84 (59.07) | 69.09 (57.50) | 61.14 (58.34) | \<0.001 |  |

## Cox models

- To examine risk factors associated with incident acute MI, we employed
  the Cox proportional hazards model with attained age as the time scale
  - Age at entry was calculated based on the return date of AHS-2
    questionnaire
  - Those who died during the follow-up were censored at the date of
    death verified in Medicare data
  - Those who were diagnosed with acute MI after the study enrollment
    were identified as incident cases and their age at diagnosis was
    calculated.
    - The mean follow-up years was 16.8 years (median 18.5 years)
    - The total person-years of follow-up was 664,646 years
  - The main exposure variable of interest was energy-adjusted egg
    intake, gram/day. Subjects were classified into 4 egg intake groups
    as shown in the descriptive table, and egg intake was entered into
    the models as categorical
    - This is because there was a non-linear association between egg
      intake and acute MI when egg intake was entered as continuous (see
      below)
  - All other dietary variables were entered into the models as
    continuous. Their hazard ratios were estimated for an increment of
    100 gram/day

<img src="summary_ami_files/figure-gfm/mv_cox_models_results-1.png" alt="" width="1918" />

### Restricted cubic spline for egg intake

- In the output above, egg intake was entered into the models as
  categorical. In the following analysis, we used restricted cubic
  splines to model a nonlinear association between egg intake as
  continuous and acute MI.
  - The nonlinear terms of egg intake were significant (p = 0.0052)
  - To visualize this nonlinear association, we have plotted hazard
    ratio for egg intake (adjusting for all other covariates) with 95
    confidence intervals
  - The reference for egg intake was set to 0 gram/day to make
    comparisons easier with the table above

![](summary_ami_files/figure-gfm/cubic_spline_egg-1.png)<!-- -->

- Hazard ratios at selected points of egg intake and their 95 CI are
  shown below:

| Egg intake (g/d) |   HR | Lower | Upper |
|-----------------:|-----:|------:|------:|
|                5 | 0.88 |  0.76 |  1.00 |
|               10 | 0.85 |  0.75 |  0.97 |
|               15 | 0.85 |  0.74 |  0.97 |
|               20 | 0.85 |  0.74 |  0.98 |
|               30 | 0.88 |  0.76 |  1.02 |
|               50 | 0.99 |  0.84 |  1.16 |

### Interaction between egg and meat intake

- There were no significant interactions between egg and meat intake (p
  = 0.70)

### Interaction between egg and race

- There were no significant interactions between egg and RTI race (p =
  0.07)

### Hyperlipidemia as time-dependent

- To examine if the effect of egg intake may be dependent on
  hyperlipidemia, we have used hyperlipidemia as a time-dependent
  variable in the Cox model (after removing prevalent hyperlipidemia
  status from the model)
  - There were no significant interactions between egg intake and
    time-dependent hyperlipidemia status (p = 0.95, Model 3)
