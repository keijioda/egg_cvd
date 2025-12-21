Egg CVD study (stroke/TIA as outcome)
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

- Prevalent cases of stroke/TIA

  - If the first diagnosis was made on or before AHS-2 enrollment date,
    consider it as a prevalent case
  - n = 670 prevalent cases were exluded, resulting n = 39,157 subjects

## Outcome

- The outcome is stroke/TIA
- Among n = 39,157 subjects, there were 6042 incident cases (15.4%) of
  stroke/TIA
- Age at diagnosis was calculated using `STOKE_TIA_EVER` variable in the
  Chronic Condition Warehouse (CCW) data. This variable shows the date
  when the beneficiary first met the criteria after January 1, 1999.
  - For 27 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/documents/10280/19139421/ccw-chronic-condition-algorithms.pdf)
  - For 30 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/web/guest/condition-categories-chronic)
- Among these incident stoke/TIA cases, the mean (SD) age of diagnosis
  was 80.8 (8.2) years. The median age of diagnosis was 81.1 years.

## Comorbidity

## Dietary variables

## Descriptive table

- The descriptive table by stroke incidence:

|  | level | Overall | Non-case | Case | p | test |
|:---|:---|:---|:---|:---|:---|:---|
| n |  | 39157 | 33115 | 6042 |  |  |
| agecat (%) | 65-69 | 6677 (17.2) | 6385 (19.4) | 292 ( 4.9) | \<0.001 |  |
|  | 70-74 | 6944 (17.8) | 6382 (19.4) | 562 ( 9.3) |  |  |
|  | 75-79 | 6286 (16.1) | 5487 (16.7) | 799 (13.3) |  |  |
|  | 80-84 | 5595 (14.4) | 4666 (14.2) | 929 (15.4) |  |  |
|  | 85-89 | 4945 (12.7) | 3796 (11.5) | 1149 (19.1) |  |  |
|  | 90-94 | 4142 (10.6) | 3054 ( 9.3) | 1088 (18.1) |  |  |
|  | 95+ | 4339 (11.1) | 3138 ( 9.5) | 1201 (20.0) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.84 (10.43) | 79.83 (10.24) | 86.35 (9.70) | \<0.001 |  |
| bene_sex_F (%) | M | 14168 (36.2) | 11975 (36.2) | 2193 (36.3) | 0.853 |  |
|  | F | 24989 (63.8) | 21140 (63.8) | 3849 (63.7) |  |  |
| rti_race3 (%) | NH White | 29024 (74.1) | 24262 (73.3) | 4762 (78.8) | \<0.001 |  |
|  | Black | 7483 (19.1) | 6476 (19.6) | 1007 (16.7) |  |  |
|  | Other | 2650 ( 6.8) | 2377 ( 7.2) | 273 ( 4.5) |  |  |
| marital (%) | Married | 28697 (73.3) | 24472 (73.9) | 4225 (69.9) | \<0.001 |  |
|  | Never | 1356 ( 3.5) | 1178 ( 3.6) | 178 ( 2.9) |  |  |
|  | Div/Wid | 9104 (23.2) | 7465 (22.5) | 1639 (27.1) |  |  |
| educyou (%) | HSch & below | 8387 (21.4) | 6903 (20.8) | 1484 (24.6) | \<0.001 |  |
|  | Some College | 15514 (39.6) | 13187 (39.8) | 2327 (38.5) |  |  |
|  | Bachelors + | 15256 (39.0) | 13025 (39.3) | 2231 (36.9) |  |  |
| vegstat (%) | Vegan | 3248 ( 8.3) | 2717 ( 8.2) | 531 ( 8.8) | \<0.001 |  |
|  | Lacto-ovo | 12611 (32.2) | 10537 (31.8) | 2074 (34.3) |  |  |
|  | Semi | 2180 ( 5.6) | 1826 ( 5.5) | 354 ( 5.9) |  |  |
|  | Pesco | 3742 ( 9.6) | 3182 ( 9.6) | 560 ( 9.3) |  |  |
|  | Non-veg | 17376 (44.4) | 14853 (44.9) | 2523 (41.8) |  |  |
| bmicat (%) | Normal | 15115 (38.6) | 12847 (38.8) | 2268 (37.5) | 0.138 |  |
|  | Overweight | 14254 (36.4) | 12037 (36.3) | 2217 (36.7) |  |  |
|  | Obese | 9788 (25.0) | 8231 (24.9) | 1557 (25.8) |  |  |
| bmi (mean (SD)) |  | 27.22 (5.47) | 27.21 (5.48) | 27.31 (5.45) | 0.164 |  |
| exercise (%) | None | 8603 (22.0) | 6937 (20.9) | 1666 (27.6) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9528 (24.3) | 8252 (24.9) | 1276 (21.1) |  |  |
|  | 0.5\<-2 hrs/wk | 10375 (26.5) | 8863 (26.8) | 1512 (25.0) |  |  |
|  | \>2 hrs/wk | 10651 (27.2) | 9063 (27.4) | 1588 (26.3) |  |  |
| sleephrs (%) | \<= 5 hrs | 3842 ( 9.8) | 3209 ( 9.7) | 633 (10.5) | \<0.001 |  |
|  | 6 hrs | 8550 (21.8) | 7288 (22.0) | 1262 (20.9) |  |  |
|  | 7 hrs | 14185 (36.2) | 12203 (36.9) | 1982 (32.8) |  |  |
|  | 8 hrs | 10367 (26.5) | 8625 (26.0) | 1742 (28.8) |  |  |
|  | \>= 9 hrs | 2213 ( 5.7) | 1790 ( 5.4) | 423 ( 7.0) |  |  |
| smokecat6 (%) | A_Never | 31195 (79.7) | 26335 (79.5) | 4860 (80.4) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3331 ( 8.5) | 2733 ( 8.3) | 598 ( 9.9) |  |  |
|  | C_QuitYrs21To30 | 2003 ( 5.1) | 1757 ( 5.3) | 246 ( 4.1) |  |  |
|  | D_QuitYrs11To20 | 1354 ( 3.5) | 1166 ( 3.5) | 188 ( 3.1) |  |  |
|  | E_QuitYrs6To10 | 481 ( 1.2) | 426 ( 1.3) | 55 ( 0.9) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 793 ( 2.0) | 698 ( 2.1) | 95 ( 1.6) |  |  |
| alccat (%) | Never | 37237 (95.1) | 31436 (94.9) | 5801 (96.0) | \<0.001 |  |
|  | Current | 1920 ( 4.9) | 1679 ( 5.1) | 241 ( 4.0) |  |  |
| como_depress (%) | No | 38417 (98.1) | 32619 (98.5) | 5798 (96.0) | \<0.001 |  |
|  | Yes | 740 ( 1.9) | 496 ( 1.5) | 244 ( 4.0) |  |  |
| como_disab (%) | No | 33751 (86.2) | 29468 (89.0) | 4283 (70.9) | \<0.001 |  |
|  | Yes | 5406 (13.8) | 3647 (11.0) | 1759 (29.1) |  |  |
| como_diabetes (%) | No | 37796 (96.5) | 32220 (97.3) | 5576 (92.3) | \<0.001 |  |
|  | Yes | 1361 ( 3.5) | 895 ( 2.7) | 466 ( 7.7) |  |  |
| como_hypert (%) | No | 35248 (90.0) | 30552 (92.3) | 4696 (77.7) | \<0.001 |  |
|  | Yes | 3909 (10.0) | 2563 ( 7.7) | 1346 (22.3) |  |  |
| como_hyperl (%) | No | 35992 (91.9) | 30992 (93.6) | 5000 (82.8) | \<0.001 |  |
|  | Yes | 3165 ( 8.1) | 2123 ( 6.4) | 1042 (17.2) |  |  |
| como_resp (%) | No | 38205 (97.6) | 32440 (98.0) | 5765 (95.4) | \<0.001 |  |
|  | Yes | 952 ( 2.4) | 675 ( 2.0) | 277 ( 4.6) |  |  |
| como_anemia (%) | No | 36986 (94.5) | 31649 (95.6) | 5337 (88.3) | \<0.001 |  |
|  | Yes | 2171 ( 5.5) | 1466 ( 4.4) | 705 (11.7) |  |  |
| como_kidney (%) | No | 38808 (99.1) | 32880 (99.3) | 5928 (98.1) | \<0.001 |  |
|  | Yes | 349 ( 0.9) | 235 ( 0.7) | 114 ( 1.9) |  |  |
| como_hypoth (%) | No | 37754 (96.4) | 32178 (97.2) | 5576 (92.3) | \<0.001 |  |
|  | Yes | 1403 ( 3.6) | 937 ( 2.8) | 466 ( 7.7) |  |  |
| como_cancers (%) | No | 38325 (97.9) | 32528 (98.2) | 5797 (95.9) | \<0.001 |  |
|  | Yes | 832 ( 2.1) | 587 ( 1.8) | 245 ( 4.1) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.03 (16.00) | 10.13 (16.07) | 9.45 (15.60) | 0.002 |  |
| meat_gram_ea_4 (%) | None | 19595 (50.0) | 16430 (49.6) | 3165 (52.4) | \<0.001 |  |
|  | \<11 g/d | 6523 (16.7) | 5481 (16.6) | 1042 (17.2) |  |  |
|  | 11-\<33 g/d | 6640 (17.0) | 5662 (17.1) | 978 (16.2) |  |  |
|  | 33+ g/d | 6399 (16.3) | 5542 (16.7) | 857 (14.2) |  |  |
| meat_gram_ea (mean (SD)) |  | 14.73 (26.12) | 15.01 (26.32) | 13.15 (24.92) | \<0.001 |  |
| fish_gram_ea_4 (%) | None | 19110 (48.8) | 15986 (48.3) | 3124 (51.7) | \<0.001 |  |
|  | \<9 g/d | 7082 (18.1) | 5974 (18.0) | 1108 (18.3) |  |  |
|  | 9-\<18 g/d | 6709 (17.1) | 5718 (17.3) | 991 (16.4) |  |  |
|  | 18+ g/d | 6256 (16.0) | 5437 (16.4) | 819 (13.6) |  |  |
| fish_gram_ea (mean (SD)) |  | 9.07 (16.32) | 9.25 (16.58) | 8.11 (14.75) | \<0.001 |  |
| alldairy2_gram_ea_4 (%) | None | 4468 (11.4) | 3755 (11.3) | 713 (11.8) | 0.074 |  |
|  | \<50 g/d | 11336 (29.0) | 9536 (28.8) | 1800 (29.8) |  |  |
|  | 50-\<180 g/d | 11599 (29.6) | 9889 (29.9) | 1710 (28.3) |  |  |
|  | 180+ g/d | 11754 (30.0) | 9935 (30.0) | 1819 (30.1) |  |  |
| alldairy2_gram_ea (mean (SD)) |  | 149.12 (187.03) | 149.51 (187.67) | 147.00 (183.52) | 0.337 |  |
| totalveg_gram_ea_4 (%) | \<185 g/d | 9925 (25.3) | 8439 (25.5) | 1486 (24.6) | 0.457 |  |
|  | 185-\<270 g/d | 9692 (24.8) | 8201 (24.8) | 1491 (24.7) |  |  |
|  | 270-\<380 g/d | 9839 (25.1) | 8293 (25.0) | 1546 (25.6) |  |  |
|  | 380+ g/d | 9701 (24.8) | 8182 (24.7) | 1519 (25.1) |  |  |
| totalveg_gram_ea (mean (SD)) |  | 302.12 (178.90) | 301.70 (179.13) | 304.42 (177.64) | 0.277 |  |
| fruits_gram_ea_4 (%) | \<170 g/d | 9855 (25.2) | 8493 (25.6) | 1362 (22.5) | \<0.001 |  |
|  | 170-\<280 g/d | 9732 (24.9) | 8295 (25.0) | 1437 (23.8) |  |  |
|  | 280-\<420 g/d | 9817 (25.1) | 8212 (24.8) | 1605 (26.6) |  |  |
|  | 420+ g/d | 9753 (24.9) | 8115 (24.5) | 1638 (27.1) |  |  |
| fruits_gram_ea (mean (SD)) |  | 321.51 (221.37) | 319.16 (221.15) | 334.37 (222.19) | \<0.001 |  |
| refgrains_gram_ea_4 (%) | \<40 g/d | 10238 (26.1) | 8475 (25.6) | 1763 (29.2) | \<0.001 |  |
|  | 40-\<83 g/d | 9884 (25.2) | 8310 (25.1) | 1574 (26.1) |  |  |
|  | 83-\<150 g/d | 9661 (24.7) | 8264 (25.0) | 1397 (23.1) |  |  |
|  | 150+ g/d | 9374 (23.9) | 8066 (24.4) | 1308 (21.6) |  |  |
| refgrains_gram_ea (mean (SD)) |  | 113.44 (116.62) | 114.24 (115.74) | 109.09 (121.24) | 0.002 |  |
| whole_mixed_grains_gram_ea_4 (%) | \<120 g/d | 10209 (26.1) | 8796 (26.6) | 1413 (23.4) | \<0.001 |  |
|  | 120-\<210 g/d | 9490 (24.2) | 8090 (24.4) | 1400 (23.2) |  |  |
|  | 219-\<350 g/d | 9645 (24.6) | 8094 (24.4) | 1551 (25.7) |  |  |
|  | 350+ g/d | 9813 (25.1) | 8135 (24.6) | 1678 (27.8) |  |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.10 (188.62) | 253.75 (188.27) | 268.98 (190.04) | \<0.001 |  |
| nutsseeds_gram_ea_4 (%) | \<9 g/d | 9935 (25.4) | 8542 (25.8) | 1393 (23.1) | \<0.001 |  |
|  | 9-\<18 g/d | 9327 (23.8) | 7994 (24.1) | 1333 (22.1) |  |  |
|  | 18-\<32 g/d | 10079 (25.7) | 8466 (25.6) | 1613 (26.7) |  |  |
|  | 32+ g/d | 9816 (25.1) | 8113 (24.5) | 1703 (28.2) |  |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.37 (20.26) | 23.13 (20.22) | 24.74 (20.39) | \<0.001 |  |
| legumes_gram_ea_4 (%) | \<33 g/d | 9696 (24.8) | 8209 (24.8) | 1487 (24.6) | 0.379 |  |
|  | 33-\<60 g/d | 9528 (24.3) | 8010 (24.2) | 1518 (25.1) |  |  |
|  | 60-\<100 g/d | 10293 (26.3) | 8705 (26.3) | 1588 (26.3) |  |  |
|  | 100+ g/d | 9640 (24.6) | 8191 (24.7) | 1449 (24.0) |  |  |
| legumes_gram_ea (mean (SD)) |  | 77.24 (69.11) | 77.30 (69.35) | 76.90 (67.77) | 0.680 |  |

- The descriptive table by egg intake (4 groups):

|  | level | Overall | None | \<4.5 g/d | 4.5-\<16.5 g/d | 16.5+ g/d | p | test |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| n |  | 39157 | 10557 | 9664 | 9518 | 9418 |  |  |
| STRK_YN (%) | No | 33115 (84.6) | 8805 (83.4) | 8097 (83.8) | 8157 (85.7) | 8056 (85.5) | \<0.001 |  |
|  | Yes | 6042 (15.4) | 1752 (16.6) | 1567 (16.2) | 1361 (14.3) | 1362 (14.5) |  |  |
| agecat (%) | 65-69 | 6677 (17.2) | 1644 (15.7) | 1650 (17.2) | 1724 (18.2) | 1659 (17.7) | \<0.001 |  |
|  | 70-74 | 6944 (17.8) | 1799 (17.1) | 1717 (17.9) | 1739 (18.4) | 1689 (18.1) |  |  |
|  | 75-79 | 6286 (16.1) | 1673 (15.9) | 1547 (16.1) | 1517 (16.0) | 1549 (16.6) |  |  |
|  | 80-84 | 5595 (14.4) | 1528 (14.6) | 1345 (14.0) | 1337 (14.1) | 1385 (14.8) |  |  |
|  | 85-89 | 4945 (12.7) | 1365 (13.0) | 1199 (12.5) | 1216 (12.9) | 1165 (12.5) |  |  |
|  | 90-94 | 4142 (10.6) | 1205 (11.5) | 1038 (10.8) | 949 (10.0) | 950 (10.2) |  |  |
|  | 95+ | 4339 (11.1) | 1286 (12.2) | 1119 (11.6) | 975 (10.3) | 959 (10.3) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.84 (10.43) | 81.45 (10.53) | 80.94 (10.54) | 80.41 (10.34) | 80.47 (10.27) | \<0.001 |  |
| bene_sex_F (%) | M | 14168 (36.2) | 3744 (35.5) | 3069 (31.8) | 3742 (39.3) | 3613 (38.4) | \<0.001 |  |
|  | F | 24989 (63.8) | 6813 (64.5) | 6595 (68.2) | 5776 (60.7) | 5805 (61.6) |  |  |
| rti_race3 (%) | NH White | 29024 (74.1) | 7703 (73.0) | 6688 (69.2) | 7189 (75.5) | 7444 (79.0) | \<0.001 |  |
|  | Black | 7483 (19.1) | 2201 (20.8) | 2222 (23.0) | 1645 (17.3) | 1415 (15.0) |  |  |
|  | Other | 2650 ( 6.8) | 653 ( 6.2) | 754 ( 7.8) | 684 ( 7.2) | 559 ( 5.9) |  |  |
| marital (%) | Married | 28697 (73.3) | 7655 (72.5) | 6877 (71.2) | 7223 (75.9) | 6942 (73.7) | \<0.001 |  |
|  | Never | 1356 ( 3.5) | 428 ( 4.1) | 377 ( 3.9) | 251 ( 2.6) | 300 ( 3.2) |  |  |
|  | Div/Wid | 9104 (23.2) | 2474 (23.4) | 2410 (24.9) | 2044 (21.5) | 2176 (23.1) |  |  |
| educyou (%) | HSch & below | 8387 (21.4) | 2118 (20.1) | 2195 (22.7) | 1977 (20.8) | 2097 (22.3) | \<0.001 |  |
|  | Some College | 15514 (39.6) | 4025 (38.1) | 3779 (39.1) | 3745 (39.3) | 3965 (42.1) |  |  |
|  | Bachelors + | 15256 (39.0) | 4414 (41.8) | 3690 (38.2) | 3796 (39.9) | 3356 (35.6) |  |  |
| vegstat (%) | Vegan | 3248 ( 8.3) | 3248 (30.8) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | \<0.001 |  |
|  | Lacto-ovo | 12611 (32.2) | 4150 (39.3) | 3585 (37.1) | 2742 (28.8) | 2134 (22.7) |  |  |
|  | Semi | 2180 ( 5.6) | 385 ( 3.6) | 694 ( 7.2) | 589 ( 6.2) | 512 ( 5.4) |  |  |
|  | Pesco | 3742 ( 9.6) | 1068 (10.1) | 1035 (10.7) | 914 ( 9.6) | 725 ( 7.7) |  |  |
|  | Non-veg | 17376 (44.4) | 1706 (16.2) | 4350 (45.0) | 5273 (55.4) | 6047 (64.2) |  |  |
| bmicat (%) | Normal | 15115 (38.6) | 5540 (52.5) | 3783 (39.1) | 3174 (33.3) | 2618 (27.8) | \<0.001 |  |
|  | Overweight | 14254 (36.4) | 3322 (31.5) | 3630 (37.6) | 3731 (39.2) | 3571 (37.9) |  |  |
|  | Obese | 9788 (25.0) | 1695 (16.1) | 2251 (23.3) | 2613 (27.5) | 3229 (34.3) |  |  |
| bmi (mean (SD)) |  | 27.22 (5.47) | 25.59 (4.98) | 27.08 (5.29) | 27.76 (5.41) | 28.66 (5.75) | \<0.001 |  |
| exercise (%) | None | 8603 (22.0) | 2066 (19.6) | 2170 (22.5) | 2022 (21.2) | 2345 (24.9) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9528 (24.3) | 2198 (20.8) | 2324 (24.0) | 2492 (26.2) | 2514 (26.7) |  |  |
|  | 0.5\<-2 hrs/wk | 10375 (26.5) | 2838 (26.9) | 2537 (26.3) | 2577 (27.1) | 2423 (25.7) |  |  |
|  | \>2 hrs/wk | 10651 (27.2) | 3455 (32.7) | 2633 (27.2) | 2427 (25.5) | 2136 (22.7) |  |  |
| sleephrs (%) | \<= 5 hrs | 3842 ( 9.8) | 976 ( 9.2) | 1052 (10.9) | 894 ( 9.4) | 920 ( 9.8) | \<0.001 |  |
|  | 6 hrs | 8550 (21.8) | 2219 (21.0) | 2180 (22.6) | 2137 (22.5) | 2014 (21.4) |  |  |
|  | 7 hrs | 14185 (36.2) | 3876 (36.7) | 3401 (35.2) | 3502 (36.8) | 3406 (36.2) |  |  |
|  | 8 hrs | 10367 (26.5) | 2907 (27.5) | 2487 (25.7) | 2482 (26.1) | 2491 (26.4) |  |  |
|  | \>= 9 hrs | 2213 ( 5.7) | 579 ( 5.5) | 544 ( 5.6) | 503 ( 5.3) | 587 ( 6.2) |  |  |
| smokecat6 (%) | A_Never | 31195 (79.7) | 8690 (82.3) | 7899 (81.7) | 7525 (79.1) | 7081 (75.2) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3331 ( 8.5) | 883 ( 8.4) | 718 ( 7.4) | 800 ( 8.4) | 930 ( 9.9) |  |  |
|  | C_QuitYrs21To30 | 2003 ( 5.1) | 505 ( 4.8) | 445 ( 4.6) | 509 ( 5.3) | 544 ( 5.8) |  |  |
|  | D_QuitYrs11To20 | 1354 ( 3.5) | 271 ( 2.6) | 316 ( 3.3) | 341 ( 3.6) | 426 ( 4.5) |  |  |
|  | E_QuitYrs6To10 | 481 ( 1.2) | 98 ( 0.9) | 99 ( 1.0) | 126 ( 1.3) | 158 ( 1.7) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 793 ( 2.0) | 110 ( 1.0) | 187 ( 1.9) | 217 ( 2.3) | 279 ( 3.0) |  |  |
| alccat (%) | Never | 37237 (95.1) | 10356 (98.1) | 9266 (95.9) | 8915 (93.7) | 8700 (92.4) | \<0.001 |  |
|  | Current | 1920 ( 4.9) | 201 ( 1.9) | 398 ( 4.1) | 603 ( 6.3) | 718 ( 7.6) |  |  |
| como_depress (%) | No | 38417 (98.1) | 10354 (98.1) | 9486 (98.2) | 9352 (98.3) | 9225 (98.0) | 0.464 |  |
|  | Yes | 740 ( 1.9) | 203 ( 1.9) | 178 ( 1.8) | 166 ( 1.7) | 193 ( 2.0) |  |  |
| como_disab (%) | No | 33751 (86.2) | 8944 (84.7) | 8327 (86.2) | 8308 (87.3) | 8172 (86.8) | \<0.001 |  |
|  | Yes | 5406 (13.8) | 1613 (15.3) | 1337 (13.8) | 1210 (12.7) | 1246 (13.2) |  |  |
| como_diabetes (%) | No | 37796 (96.5) | 10276 (97.3) | 9342 (96.7) | 9171 (96.4) | 9007 (95.6) | \<0.001 |  |
|  | Yes | 1361 ( 3.5) | 281 ( 2.7) | 322 ( 3.3) | 347 ( 3.6) | 411 ( 4.4) |  |  |
| como_hypert (%) | No | 35248 (90.0) | 9590 (90.8) | 8673 (89.7) | 8555 (89.9) | 8430 (89.5) | 0.009 |  |
|  | Yes | 3909 (10.0) | 967 ( 9.2) | 991 (10.3) | 963 (10.1) | 988 (10.5) |  |  |
| como_hyperl (%) | No | 35992 (91.9) | 9717 (92.0) | 8859 (91.7) | 8743 (91.9) | 8673 (92.1) | 0.696 |  |
|  | Yes | 3165 ( 8.1) | 840 ( 8.0) | 805 ( 8.3) | 775 ( 8.1) | 745 ( 7.9) |  |  |
| como_resp (%) | No | 38205 (97.6) | 10322 (97.8) | 9421 (97.5) | 9304 (97.8) | 9158 (97.2) | 0.050 |  |
|  | Yes | 952 ( 2.4) | 235 ( 2.2) | 243 ( 2.5) | 214 ( 2.2) | 260 ( 2.8) |  |  |
| como_anemia (%) | No | 36986 (94.5) | 9911 (93.9) | 9129 (94.5) | 9028 (94.9) | 8918 (94.7) | 0.015 |  |
|  | Yes | 2171 ( 5.5) | 646 ( 6.1) | 535 ( 5.5) | 490 ( 5.1) | 500 ( 5.3) |  |  |
| como_kidney (%) | No | 38808 (99.1) | 10476 (99.2) | 9581 (99.1) | 9443 (99.2) | 9308 (98.8) | 0.010 |  |
|  | Yes | 349 ( 0.9) | 81 ( 0.8) | 83 ( 0.9) | 75 ( 0.8) | 110 ( 1.2) |  |  |
| como_hypoth (%) | No | 37754 (96.4) | 10164 (96.3) | 9306 (96.3) | 9189 (96.5) | 9095 (96.6) | 0.554 |  |
|  | Yes | 1403 ( 3.6) | 393 ( 3.7) | 358 ( 3.7) | 329 ( 3.5) | 323 ( 3.4) |  |  |
| como_cancers (%) | No | 38325 (97.9) | 10325 (97.8) | 9451 (97.8) | 9340 (98.1) | 9209 (97.8) | 0.269 |  |
|  | Yes | 832 ( 2.1) | 232 ( 2.2) | 213 ( 2.2) | 178 ( 1.9) | 209 ( 2.2) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.03 (16.00) | 0.00 (0.00) | 3.10 (0.78) | 8.64 (3.36) | 29.79 (22.32) | \<0.001 |  |
| meat_gram_ea_4 (%) | None | 19595 (50.0) | 8465 (80.2) | 4617 (47.8) | 3656 (38.4) | 2857 (30.3) | \<0.001 |  |
|  | \<11 g/d | 6523 (16.7) | 992 ( 9.4) | 2041 (21.1) | 1894 (19.9) | 1596 (16.9) |  |  |
|  | 11-\<33 g/d | 6640 (17.0) | 626 ( 5.9) | 1778 (18.4) | 2050 (21.5) | 2186 (23.2) |  |  |
|  | 33+ g/d | 6399 (16.3) | 474 ( 4.5) | 1228 (12.7) | 1918 (20.2) | 2779 (29.5) |  |  |
| meat_gram_ea (mean (SD)) |  | 14.73 (26.12) | 4.47 (15.35) | 12.25 (21.63) | 18.17 (27.49) | 25.29 (32.88) | \<0.001 |  |
| fish_gram_ea_4 (%) | None | 19110 (48.8) | 7920 (75.0) | 4478 (46.3) | 3612 (37.9) | 3100 (32.9) | \<0.001 |  |
|  | \<9 g/d | 7082 (18.1) | 1076 (10.2) | 1969 (20.4) | 1954 (20.5) | 2083 (22.1) |  |  |
|  | 9-\<18 g/d | 6709 (17.1) | 785 ( 7.4) | 1745 (18.1) | 1992 (20.9) | 2187 (23.2) |  |  |
|  | 18+ g/d | 6256 (16.0) | 776 ( 7.4) | 1472 (15.2) | 1960 (20.6) | 2048 (21.7) |  |  |
| fish_gram_ea (mean (SD)) |  | 9.07 (16.32) | 4.56 (14.48) | 9.06 (16.23) | 11.12 (16.50) | 12.06 (17.05) | \<0.001 |  |
| alldairy2_gram_ea_4 (%) | None | 4468 (11.4) | 3694 (35.0) | 403 ( 4.2) | 209 ( 2.2) | 162 ( 1.7) | \<0.001 |  |
|  | \<50 g/d | 11336 (29.0) | 4066 (38.5) | 3309 (34.2) | 2161 (22.7) | 1800 (19.1) |  |  |
|  | 50-\<180 g/d | 11599 (29.6) | 1635 (15.5) | 3131 (32.4) | 3476 (36.5) | 3357 (35.6) |  |  |
|  | 180+ g/d | 11754 (30.0) | 1162 (11.0) | 2821 (29.2) | 3672 (38.6) | 4099 (43.5) |  |  |
| alldairy2_gram_ea (mean (SD)) |  | 149.12 (187.03) | 63.66 (138.49) | 150.65 (185.26) | 188.55 (194.59) | 203.51 (194.29) | \<0.001 |  |
| totalveg_gram_ea_4 (%) | \<185 g/d | 9925 (25.3) | 2072 (19.6) | 2563 (26.5) | 2577 (27.1) | 2713 (28.8) | \<0.001 |  |
|  | 185-\<270 g/d | 9692 (24.8) | 2363 (22.4) | 2341 (24.2) | 2518 (26.5) | 2470 (26.2) |  |  |
|  | 270-\<380 g/d | 9839 (25.1) | 2680 (25.4) | 2429 (25.1) | 2389 (25.1) | 2341 (24.9) |  |  |
|  | 380+ g/d | 9701 (24.8) | 3442 (32.6) | 2331 (24.1) | 2034 (21.4) | 1894 (20.1) |  |  |
| totalveg_gram_ea (mean (SD)) |  | 302.12 (178.90) | 341.89 (209.20) | 297.33 (174.62) | 284.84 (155.88) | 279.91 (159.94) | \<0.001 |  |
| fruits_gram_ea_4 (%) | \<170 g/d | 9855 (25.2) | 1570 (14.9) | 2311 (23.9) | 2724 (28.6) | 3250 (34.5) | \<0.001 |  |
|  | 170-\<280 g/d | 9732 (24.9) | 2085 (19.7) | 2347 (24.3) | 2622 (27.5) | 2678 (28.4) |  |  |
|  | 280-\<420 g/d | 9817 (25.1) | 2919 (27.6) | 2476 (25.6) | 2331 (24.5) | 2091 (22.2) |  |  |
|  | 420+ g/d | 9753 (24.9) | 3983 (37.7) | 2530 (26.2) | 1841 (19.3) | 1399 (14.9) |  |  |
| fruits_gram_ea (mean (SD)) |  | 321.51 (221.37) | 396.75 (245.77) | 329.91 (224.98) | 291.05 (198.68) | 259.31 (181.66) | \<0.001 |  |
| refgrains_gram_ea_4 (%) | \<40 g/d | 10238 (26.1) | 3924 (37.2) | 2368 (24.5) | 1923 (20.2) | 2023 (21.5) | \<0.001 |  |
|  | 40-\<83 g/d | 9884 (25.2) | 2449 (23.2) | 2466 (25.5) | 2532 (26.6) | 2437 (25.9) |  |  |
|  | 83-\<150 g/d | 9661 (24.7) | 2088 (19.8) | 2468 (25.5) | 2582 (27.1) | 2523 (26.8) |  |  |
|  | 150+ g/d | 9374 (23.9) | 2096 (19.9) | 2362 (24.4) | 2481 (26.1) | 2435 (25.9) |  |  |
| refgrains_gram_ea (mean (SD)) |  | 113.44 (116.62) | 98.00 (115.95) | 116.36 (118.78) | 120.82 (114.26) | 120.30 (115.89) | \<0.001 |  |
| whole_mixed_grains_gram_ea_4 (%) | \<120 g/d | 10209 (26.1) | 1588 (15.0) | 2501 (25.9) | 2857 (30.0) | 3263 (34.6) | \<0.001 |  |
|  | 120-\<210 g/d | 9490 (24.2) | 1935 (18.3) | 2394 (24.8) | 2614 (27.5) | 2547 (27.0) |  |  |
|  | 219-\<350 g/d | 9645 (24.6) | 2915 (27.6) | 2319 (24.0) | 2278 (23.9) | 2133 (22.6) |  |  |
|  | 350+ g/d | 9813 (25.1) | 4119 (39.0) | 2450 (25.4) | 1769 (18.6) | 1475 (15.7) |  |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.10 (188.62) | 329.72 (213.16) | 256.38 (187.58) | 223.84 (164.11) | 205.88 (155.00) | \<0.001 |  |
| nutsseeds_gram_ea_4 (%) | \<9 g/d | 9935 (25.4) | 2028 (19.2) | 2595 (26.9) | 2544 (26.7) | 2768 (29.4) | \<0.001 |  |
|  | 9-\<18 g/d | 9327 (23.8) | 2009 (19.0) | 2368 (24.5) | 2460 (25.8) | 2490 (26.4) |  |  |
|  | 18-\<32 g/d | 10079 (25.7) | 2821 (26.7) | 2398 (24.8) | 2520 (26.5) | 2340 (24.8) |  |  |
|  | 32+ g/d | 9816 (25.1) | 3699 (35.0) | 2303 (23.8) | 1994 (20.9) | 1820 (19.3) |  |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.37 (20.26) | 28.20 (22.60) | 22.76 (20.10) | 21.55 (18.75) | 20.44 (18.03) | \<0.001 |  |
| legumes_gram_ea_4 (%) | \<33 g/d | 9696 (24.8) | 1901 (18.0) | 2365 (24.5) | 2495 (26.2) | 2935 (31.2) | \<0.001 |  |
|  | 33-\<60 g/d | 9528 (24.3) | 2214 (21.0) | 2424 (25.1) | 2414 (25.4) | 2476 (26.3) |  |  |
|  | 60-\<100 g/d | 10293 (26.3) | 2941 (27.9) | 2517 (26.0) | 2539 (26.7) | 2296 (24.4) |  |  |
|  | 100+ g/d | 9640 (24.6) | 3501 (33.2) | 2358 (24.4) | 2070 (21.7) | 1711 (18.2) |  |  |
| legumes_gram_ea (mean (SD)) |  | 77.24 (69.11) | 93.81 (82.52) | 77.20 (69.05) | 71.35 (59.23) | 64.65 (57.34) | \<0.001 |  |

## Cox models

- To examine risk factors associated with incident stroke/TIA, we
  employed the Cox proportional hazards model with attained age as the
  time scale
  - Age at entry was calculated based on the return date of AHS-2
    questionnaire
  - Those who died during the follow-up were censored at the date of
    death verified in Medicare data
  - Those who were diagnosed with stroke/TIA after the study enrollment
    were identified as incident cases and their age at diagnosis was
    calculated.
    - The mean follow-up years was 16.4 years (median 18.3 years)
    - The total person-years of follow-up was 640,424 years
  - The main exposure variable of interest was energy-adjusted egg
    intake, gram/day. Subjects were classified into 4 egg intake groups
    as shown in the descriptive table, and egg intake was entered into
    the models as categorical
    - This is because there was a non-linear association between egg
      intake and stoke/TIA when egg intake was entered as continuous
      (see below)
  - All other dietary variables were entered into the models as
    continuous. Their hazard ratios were estimated for an increment of
    100 gram/day

![](summary_stroke_files/figure-gfm/mv_cox_models_results-1.png)<!-- -->

### Restricted cubic spline for egg intake

- In the output above, egg intake was entered into the models as
  categorical. In the following analysis, we used restricted cubic
  splines to model a nonlinear association between egg intake as
  continuous and stroke/TIA.
  - The nonlinear terms of egg intake were highly significant (p =
    0.0003)
  - To visualize this nonlinear association, we have plotted hazard
    ratio for egg intake (adjusting for all other covariates) with 95
    confidence intervals
  - The reference for egg intake was set to 0 gram/day to make
    comparisons easier with the table above

![](summary_stroke_files/figure-gfm/cubic_spline_egg-1.png)<!-- -->

- Hazard ratios at selected points of egg intake and their 95 CI are
  shown below:

| Egg intake (g/d) |   HR | Lower | Upper |
|-----------------:|-----:|------:|------:|
|                5 | 0.94 |  0.87 |  1.01 |
|               10 | 0.89 |  0.83 |  0.95 |
|               15 | 0.86 |  0.80 |  0.93 |
|               20 | 0.85 |  0.78 |  0.91 |
|               30 | 0.84 |  0.78 |  0.91 |
|               50 | 0.87 |  0.79 |  0.95 |

### Interaction between egg and meat intake

- There were no significant interactions between egg and meat intake (p
  = 0.28)

### Hyperlipidemia as time-dependent

- To examine if the effect of egg intake may be dependent on
  hyperlipidemia, we have used hyperlipidemia as a time-dependent
  variable in the Cox model (after removing prevalent hyperlipidemia
  status from the model)
  - There were no significant interactions between egg intake and
    time-dependent hyperlipidemia status (p = 0.67, Model 3)
