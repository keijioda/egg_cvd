Egg CVD study (Afib as outcome)
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

- Prevalent cases of atrial fibrosis

  - If the first diagnosis was made on or before AHS-2 enrollment date,
    consider it as a prevalent case
  - n = 857 prevalent cases were exluded, resulting n = 38,970 subjects

## Outcome

- The outcome is atrial fibrosis
- Among n = 38,970 subjects, there were 6303 incident cases (16.2%) of
  atrial fibrosis
- Age at diagnosis was calculated using `ATRIAL_FIB_EVER` variable in
  the Chronic Condition Warehouse (CCW) data. This variable shows the
  date when the beneficiary first met the criteria after January 1,
  1999.
  - For 27 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/documents/10280/19139421/ccw-chronic-condition-algorithms.pdf)
  - For 30 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/web/guest/condition-categories-chronic)
- Among these incident atrial fibrosis cases, the mean (SD) age of
  diagnosis was 80.9 (8.0) years. The median age of diagnosis was 81.4
  years.

## Comorbidity

## Dietary variables

## Descriptive table

- The descriptive table by afib incidence:

|  | level | Overall | Non-case | Case | p | test |
|:---|:---|:---|:---|:---|:---|:---|
| n |  | 38970 | 32667 | 6303 |  |  |
| agecat (%) | 65-69 | 6680 (17.2) | 6397 (19.7) | 283 ( 4.5) | \<0.001 |  |
|  | 70-74 | 6946 (17.9) | 6401 (19.7) | 545 ( 8.7) |  |  |
|  | 75-79 | 6282 (16.2) | 5479 (16.9) | 803 (12.8) |  |  |
|  | 80-84 | 5601 (14.5) | 4619 (14.2) | 982 (15.6) |  |  |
|  | 85-89 | 4921 (12.7) | 3667 (11.3) | 1254 (19.9) |  |  |
|  | 90-94 | 4091 (10.6) | 2933 ( 9.0) | 1158 (18.4) |  |  |
|  | 95+ | 4220 (10.9) | 2948 ( 9.1) | 1272 (20.2) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.76 (10.39) | 79.62 (10.16) | 86.67 (9.50) | \<0.001 |  |
| bene_sex_F (%) | M | 14064 (36.1) | 11470 (35.1) | 2594 (41.2) | \<0.001 |  |
|  | F | 24906 (63.9) | 21197 (64.9) | 3709 (58.8) |  |  |
| rti_race3 (%) | NH White | 28778 (73.8) | 23337 (71.4) | 5441 (86.3) | \<0.001 |  |
|  | Black | 7540 (19.3) | 6910 (21.2) | 630 (10.0) |  |  |
|  | Other | 2652 ( 6.8) | 2420 ( 7.4) | 232 ( 3.7) |  |  |
| marital (%) | Married | 28528 (73.2) | 24004 (73.5) | 4524 (71.8) | \<0.001 |  |
|  | Never | 1355 ( 3.5) | 1175 ( 3.6) | 180 ( 2.9) |  |  |
|  | Div/Wid | 9087 (23.3) | 7488 (22.9) | 1599 (25.4) |  |  |
| educyou (%) | HSch & below | 8354 (21.4) | 6879 (21.1) | 1475 (23.4) | \<0.001 |  |
|  | Some College | 15437 (39.6) | 13032 (39.9) | 2405 (38.2) |  |  |
|  | Bachelors + | 15179 (39.0) | 12756 (39.0) | 2423 (38.4) |  |  |
| vegstat (%) | Vegan | 3226 ( 8.3) | 2684 ( 8.2) | 542 ( 8.6) | \<0.001 |  |
|  | Lacto-ovo | 12513 (32.1) | 10280 (31.5) | 2233 (35.4) |  |  |
|  | Semi | 2163 ( 5.6) | 1767 ( 5.4) | 396 ( 6.3) |  |  |
|  | Pesco | 3728 ( 9.6) | 3176 ( 9.7) | 552 ( 8.8) |  |  |
|  | Non-veg | 17340 (44.5) | 14760 (45.2) | 2580 (40.9) |  |  |
| bmicat (%) | Normal | 14987 (38.5) | 12722 (38.9) | 2265 (35.9) | \<0.001 |  |
|  | Overweight | 14260 (36.6) | 12018 (36.8) | 2242 (35.6) |  |  |
|  | Obese | 9723 (24.9) | 7927 (24.3) | 1796 (28.5) |  |  |
| bmi (mean (SD)) |  | 27.23 (5.46) | 27.13 (5.40) | 27.74 (5.75) | \<0.001 |  |
| exercise (%) | None | 8538 (21.9) | 6835 (20.9) | 1703 (27.0) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9498 (24.4) | 8091 (24.8) | 1407 (22.3) |  |  |
|  | 0.5\<-2 hrs/wk | 10321 (26.5) | 8790 (26.9) | 1531 (24.3) |  |  |
|  | \>2 hrs/wk | 10613 (27.2) | 8951 (27.4) | 1662 (26.4) |  |  |
| sleephrs (%) | \<= 5 hrs | 3835 ( 9.8) | 3304 (10.1) | 531 ( 8.4) | \<0.001 |  |
|  | 6 hrs | 8523 (21.9) | 7269 (22.3) | 1254 (19.9) |  |  |
|  | 7 hrs | 14113 (36.2) | 11912 (36.5) | 2201 (34.9) |  |  |
|  | 8 hrs | 10283 (26.4) | 8395 (25.7) | 1888 (30.0) |  |  |
|  | \>= 9 hrs | 2216 ( 5.7) | 1787 ( 5.5) | 429 ( 6.8) |  |  |
| smokecat6 (%) | A_Never | 31005 (79.6) | 26010 (79.6) | 4995 (79.2) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3319 ( 8.5) | 2659 ( 8.1) | 660 (10.5) |  |  |
|  | C_QuitYrs21To30 | 2008 ( 5.2) | 1705 ( 5.2) | 303 ( 4.8) |  |  |
|  | D_QuitYrs11To20 | 1365 ( 3.5) | 1169 ( 3.6) | 196 ( 3.1) |  |  |
|  | E_QuitYrs6To10 | 480 ( 1.2) | 414 ( 1.3) | 66 ( 1.0) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 793 ( 2.0) | 710 ( 2.2) | 83 ( 1.3) |  |  |
| alccat (%) | Never | 37052 (95.1) | 31003 (94.9) | 6049 (96.0) | \<0.001 |  |
|  | Current | 1918 ( 4.9) | 1664 ( 5.1) | 254 ( 4.0) |  |  |
| como_depress (%) | No | 38203 (98.0) | 32143 (98.4) | 6060 (96.1) | \<0.001 |  |
|  | Yes | 767 ( 2.0) | 524 ( 1.6) | 243 ( 3.9) |  |  |
| como_disab (%) | No | 33695 (86.5) | 29128 (89.2) | 4567 (72.5) | \<0.001 |  |
|  | Yes | 5275 (13.5) | 3539 (10.8) | 1736 (27.5) |  |  |
| como_diabetes (%) | No | 37629 (96.6) | 31728 (97.1) | 5901 (93.6) | \<0.001 |  |
|  | Yes | 1341 ( 3.4) | 939 ( 2.9) | 402 ( 6.4) |  |  |
| como_hypert (%) | No | 35157 (90.2) | 30154 (92.3) | 5003 (79.4) | \<0.001 |  |
|  | Yes | 3813 ( 9.8) | 2513 ( 7.7) | 1300 (20.6) |  |  |
| como_hyperl (%) | No | 35871 (92.0) | 30613 (93.7) | 5258 (83.4) | \<0.001 |  |
|  | Yes | 3099 ( 8.0) | 2054 ( 6.3) | 1045 (16.6) |  |  |
| como_resp (%) | No | 38073 (97.7) | 32062 (98.1) | 6011 (95.4) | \<0.001 |  |
|  | Yes | 897 ( 2.3) | 605 ( 1.9) | 292 ( 4.6) |  |  |
| como_anemia (%) | No | 36870 (94.6) | 31272 (95.7) | 5598 (88.8) | \<0.001 |  |
|  | Yes | 2100 ( 5.4) | 1395 ( 4.3) | 705 (11.2) |  |  |
| como_kidney (%) | No | 38629 (99.1) | 32431 (99.3) | 6198 (98.3) | \<0.001 |  |
|  | Yes | 341 ( 0.9) | 236 ( 0.7) | 105 ( 1.7) |  |  |
| como_hypoth (%) | No | 37635 (96.6) | 31772 (97.3) | 5863 (93.0) | \<0.001 |  |
|  | Yes | 1335 ( 3.4) | 895 ( 2.7) | 440 ( 7.0) |  |  |
| como_cancers (%) | No | 38187 (98.0) | 32134 (98.4) | 6053 (96.0) | \<0.001 |  |
|  | Yes | 783 ( 2.0) | 533 ( 1.6) | 250 ( 4.0) |  |  |
| eggs_gram_ea_5 (%) | None | 10505 (27.0) | 8739 (26.8) | 1766 (28.0) | 0.039 |  |
|  | \<4 g/d | 8407 (21.6) | 7073 (21.7) | 1334 (21.2) |  |  |
|  | 4-\<10 g/d | 7972 (20.5) | 6732 (20.6) | 1240 (19.7) |  |  |
|  | 10-\<23 g/d | 7209 (18.5) | 6078 (18.6) | 1131 (17.9) |  |  |
|  | 23+ g/d | 4877 (12.5) | 4045 (12.4) | 832 (13.2) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.02 (16.01) | 10.02 (16.12) | 10.03 (15.45) | 0.960 |  |
| meat_gram_ea (mean (SD)) |  | 14.76 (26.11) | 15.07 (26.28) | 13.19 (25.18) | \<0.001 |  |
| fish_gram_ea (mean (SD)) |  | 9.11 (16.36) | 9.41 (16.79) | 7.55 (13.80) | \<0.001 |  |
| alldairy2_gram_ea (mean (SD)) |  | 148.65 (186.52) | 147.76 (186.49) | 153.25 (186.61) | 0.032 |  |
| totalveg_gram_ea (mean (SD)) |  | 302.26 (179.26) | 302.21 (179.06) | 302.54 (180.29) | 0.893 |  |
| fruits_gram_ea (mean (SD)) |  | 321.25 (221.73) | 320.94 (223.62) | 322.85 (211.67) | 0.530 |  |
| refgrains_gram_ea (mean (SD)) |  | 113.52 (116.43) | 115.53 (117.27) | 103.12 (111.41) | \<0.001 |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.02 (188.80) | 253.54 (188.04) | 268.90 (192.16) | \<0.001 |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.31 (20.21) | 22.96 (20.14) | 25.14 (20.50) | \<0.001 |  |
| legumes_gram_ea (mean (SD)) |  | 77.26 (69.15) | 77.52 (69.72) | 75.89 (66.15) | 0.087 |  |

- The descriptive table by egg intake (5 groups):

|  | level | Overall | None | \<4 g/d | 4-\<10 g/d | 10-\<23 g/d | 23+ g/d | p | test |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| n |  | 38970 | 10505 | 8407 | 7972 | 7209 | 4877 |  |  |
| AFIB_YN (%) | No | 32667 (83.8) | 8739 (83.2) | 7073 (84.1) | 6732 (84.4) | 6078 (84.3) | 4045 (82.9) | 0.039 |  |
|  | Yes | 6303 (16.2) | 1766 (16.8) | 1334 (15.9) | 1240 (15.6) | 1131 (15.7) | 832 (17.1) |  |  |
| agecat (%) | 65-69 | 6680 (17.2) | 1644 (15.7) | 1432 (17.1) | 1440 (18.2) | 1266 (17.7) | 898 (18.6) | \<0.001 |  |
|  | 70-74 | 6946 (17.9) | 1798 (17.2) | 1454 (17.4) | 1485 (18.8) | 1262 (17.6) | 947 (19.6) |  |  |
|  | 75-79 | 6282 (16.2) | 1672 (16.0) | 1340 (16.0) | 1304 (16.5) | 1117 (15.6) | 849 (17.5) |  |  |
|  | 80-84 | 5601 (14.5) | 1529 (14.6) | 1192 (14.2) | 1113 (14.1) | 1038 (14.5) | 729 (15.1) |  |  |
|  | 85-89 | 4921 (12.7) | 1352 (12.9) | 1066 (12.7) | 1003 (12.7) | 920 (12.8) | 580 (12.0) |  |  |
|  | 90-94 | 4091 (10.6) | 1193 (11.4) | 900 (10.8) | 774 ( 9.8) | 765 (10.7) | 459 ( 9.5) |  |  |
|  | 95+ | 4220 (10.9) | 1260 (12.1) | 983 (11.7) | 797 (10.1) | 802 (11.2) | 378 ( 7.8) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.76 (10.39) | 81.39 (10.51) | 81.04 (10.56) | 80.25 (10.22) | 80.86 (10.52) | 79.59 (9.77) | \<0.001 |  |
| bene_sex_F (%) | M | 14064 (36.1) | 3723 (35.4) | 2615 (31.1) | 3052 (38.3) | 2634 (36.5) | 2040 (41.8) | \<0.001 |  |
|  | F | 24906 (63.9) | 6782 (64.6) | 5792 (68.9) | 4920 (61.7) | 4575 (63.5) | 2837 (58.2) |  |  |
| rti_race3 (%) | NH White | 28778 (73.8) | 7643 (72.8) | 5827 (69.3) | 5931 (74.4) | 5518 (76.5) | 3859 (79.1) | \<0.001 |  |
|  | Black | 7540 (19.3) | 2209 (21.0) | 1916 (22.8) | 1464 (18.4) | 1197 (16.6) | 754 (15.5) |  |  |
|  | Other | 2652 ( 6.8) | 653 ( 6.2) | 664 ( 7.9) | 577 ( 7.2) | 494 ( 6.9) | 264 ( 5.4) |  |  |
| marital (%) | Married | 28528 (73.2) | 7625 (72.6) | 5991 (71.3) | 5971 (74.9) | 5384 (74.7) | 3557 (72.9) | \<0.001 |  |
|  | Never | 1355 ( 3.5) | 427 ( 4.1) | 321 ( 3.8) | 230 ( 2.9) | 213 ( 3.0) | 164 ( 3.4) |  |  |
|  | Div/Wid | 9087 (23.3) | 2453 (23.4) | 2095 (24.9) | 1771 (22.2) | 1612 (22.4) | 1156 (23.7) |  |  |
| educyou (%) | HSch & below | 8354 (21.4) | 2112 (20.1) | 1882 (22.4) | 1681 (21.1) | 1522 (21.1) | 1157 (23.7) | \<0.001 |  |
|  | Some College | 15437 (39.6) | 4001 (38.1) | 3284 (39.1) | 3129 (39.2) | 2918 (40.5) | 2105 (43.2) |  |  |
|  | Bachelors + | 15179 (39.0) | 4392 (41.8) | 3241 (38.6) | 3162 (39.7) | 2769 (38.4) | 1615 (33.1) |  |  |
| vegstat (%) | Vegan | 3226 ( 8.3) | 3226 (30.7) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | \<0.001 |  |
|  | Lacto-ovo | 12513 (32.1) | 4113 (39.2) | 3209 (38.2) | 2401 (30.1) | 1849 (25.6) | 941 (19.3) |  |  |
|  | Semi | 2163 ( 5.6) | 387 ( 3.7) | 576 ( 6.9) | 558 ( 7.0) | 377 ( 5.2) | 265 ( 5.4) |  |  |
|  | Pesco | 3728 ( 9.6) | 1070 (10.2) | 911 (10.8) | 763 ( 9.6) | 668 ( 9.3) | 316 ( 6.5) |  |  |
|  | Non-veg | 17340 (44.5) | 1709 (16.3) | 3711 (44.1) | 4250 (53.3) | 4315 (59.9) | 3355 (68.8) |  |  |
| bmicat (%) | Normal | 14987 (38.5) | 5488 (52.2) | 3342 (39.8) | 2770 (34.7) | 2232 (31.0) | 1155 (23.7) | \<0.001 |  |
|  | Overweight | 14260 (36.6) | 3331 (31.7) | 3162 (37.6) | 3104 (38.9) | 2829 (39.2) | 1834 (37.6) |  |  |
|  | Obese | 9723 (24.9) | 1686 (16.0) | 1903 (22.6) | 2098 (26.3) | 2148 (29.8) | 1888 (38.7) |  |  |
| bmi (mean (SD)) |  | 27.23 (5.46) | 25.61 (4.97) | 26.99 (5.26) | 27.61 (5.39) | 28.05 (5.48) | 29.30 (5.88) | \<0.001 |  |
| exercise (%) | None | 8538 (21.9) | 2052 (19.5) | 1825 (21.7) | 1766 (22.2) | 1573 (21.8) | 1322 (27.1) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9498 (24.4) | 2188 (20.8) | 1983 (23.6) | 2129 (26.7) | 1883 (26.1) | 1315 (27.0) |  |  |
|  | 0.5\<-2 hrs/wk | 10321 (26.5) | 2816 (26.8) | 2238 (26.6) | 2107 (26.4) | 1976 (27.4) | 1184 (24.3) |  |  |
|  | \>2 hrs/wk | 10613 (27.2) | 3449 (32.8) | 2361 (28.1) | 1970 (24.7) | 1777 (24.6) | 1056 (21.7) |  |  |
| sleephrs (%) | \<= 5 hrs | 3835 ( 9.8) | 977 ( 9.3) | 889 (10.6) | 765 ( 9.6) | 692 ( 9.6) | 512 (10.5) | 0.001 |  |
|  | 6 hrs | 8523 (21.9) | 2209 (21.0) | 1892 (22.5) | 1813 (22.7) | 1535 (21.3) | 1074 (22.0) |  |  |
|  | 7 hrs | 14113 (36.2) | 3849 (36.6) | 2982 (35.5) | 2914 (36.6) | 2640 (36.6) | 1728 (35.4) |  |  |
|  | 8 hrs | 10283 (26.4) | 2890 (27.5) | 2166 (25.8) | 2060 (25.8) | 1923 (26.7) | 1244 (25.5) |  |  |
|  | \>= 9 hrs | 2216 ( 5.7) | 580 ( 5.5) | 478 ( 5.7) | 420 ( 5.3) | 419 ( 5.8) | 319 ( 6.5) |  |  |
| smokecat6 (%) | A_Never | 31005 (79.6) | 8646 (82.3) | 6937 (82.5) | 6278 (78.8) | 5679 (78.8) | 3465 (71.0) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3319 ( 8.5) | 874 ( 8.3) | 610 ( 7.3) | 677 ( 8.5) | 625 ( 8.7) | 533 (10.9) |  |  |
|  | C_QuitYrs21To30 | 2008 ( 5.2) | 507 ( 4.8) | 382 ( 4.5) | 401 ( 5.0) | 393 ( 5.5) | 325 ( 6.7) |  |  |
|  | D_QuitYrs11To20 | 1365 ( 3.5) | 272 ( 2.6) | 253 ( 3.0) | 316 ( 4.0) | 262 ( 3.6) | 262 ( 5.4) |  |  |
|  | E_QuitYrs6To10 | 480 ( 1.2) | 98 ( 0.9) | 75 ( 0.9) | 114 ( 1.4) | 92 ( 1.3) | 101 ( 2.1) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 793 ( 2.0) | 108 ( 1.0) | 150 ( 1.8) | 186 ( 2.3) | 158 ( 2.2) | 191 ( 3.9) |  |  |
| alccat (%) | Never | 37052 (95.1) | 10302 (98.1) | 8071 (96.0) | 7506 (94.2) | 6736 (93.4) | 4437 (91.0) | \<0.001 |  |
|  | Current | 1918 ( 4.9) | 203 ( 1.9) | 336 ( 4.0) | 466 ( 5.8) | 473 ( 6.6) | 440 ( 9.0) |  |  |
| como_depress (%) | No | 38203 (98.0) | 10301 (98.1) | 8232 (97.9) | 7823 (98.1) | 7067 (98.0) | 4780 (98.0) | 0.908 |  |
|  | Yes | 767 ( 2.0) | 204 ( 1.9) | 175 ( 2.1) | 149 ( 1.9) | 142 ( 2.0) | 97 ( 2.0) |  |  |
| como_disab (%) | No | 33695 (86.5) | 8935 (85.1) | 7257 (86.3) | 6972 (87.5) | 6208 (86.1) | 4323 (88.6) | \<0.001 |  |
|  | Yes | 5275 (13.5) | 1570 (14.9) | 1150 (13.7) | 1000 (12.5) | 1001 (13.9) | 554 (11.4) |  |  |
| como_diabetes (%) | No | 37629 (96.6) | 10221 (97.3) | 8146 (96.9) | 7686 (96.4) | 6919 (96.0) | 4657 (95.5) | \<0.001 |  |
|  | Yes | 1341 ( 3.4) | 284 ( 2.7) | 261 ( 3.1) | 286 ( 3.6) | 290 ( 4.0) | 220 ( 4.5) |  |  |
| como_hypert (%) | No | 35157 (90.2) | 9557 (91.0) | 7572 (90.1) | 7185 (90.1) | 6430 (89.2) | 4413 (90.5) | 0.003 |  |
|  | Yes | 3813 ( 9.8) | 948 ( 9.0) | 835 ( 9.9) | 787 ( 9.9) | 779 (10.8) | 464 ( 9.5) |  |  |
| como_hyperl (%) | No | 35871 (92.0) | 9682 (92.2) | 7728 (91.9) | 7321 (91.8) | 6610 (91.7) | 4530 (92.9) | 0.147 |  |
|  | Yes | 3099 ( 8.0) | 823 ( 7.8) | 679 ( 8.1) | 651 ( 8.2) | 599 ( 8.3) | 347 ( 7.1) |  |  |
| como_resp (%) | No | 38073 (97.7) | 10281 (97.9) | 8202 (97.6) | 7807 (97.9) | 7022 (97.4) | 4761 (97.6) | 0.146 |  |
|  | Yes | 897 ( 2.3) | 224 ( 2.1) | 205 ( 2.4) | 165 ( 2.1) | 187 ( 2.6) | 116 ( 2.4) |  |  |
| como_anemia (%) | No | 36870 (94.6) | 9883 (94.1) | 7949 (94.6) | 7564 (94.9) | 6821 (94.6) | 4653 (95.4) | 0.011 |  |
|  | Yes | 2100 ( 5.4) | 622 ( 5.9) | 458 ( 5.4) | 408 ( 5.1) | 388 ( 5.4) | 224 ( 4.6) |  |  |
| como_kidney (%) | No | 38629 (99.1) | 10428 (99.3) | 8344 (99.3) | 7899 (99.1) | 7133 (98.9) | 4825 (98.9) | 0.065 |  |
|  | Yes | 341 ( 0.9) | 77 ( 0.7) | 63 ( 0.7) | 73 ( 0.9) | 76 ( 1.1) | 52 ( 1.1) |  |  |
| como_hypoth (%) | No | 37635 (96.6) | 10136 (96.5) | 8088 (96.2) | 7706 (96.7) | 6948 (96.4) | 4757 (97.5) | 0.001 |  |
|  | Yes | 1335 ( 3.4) | 369 ( 3.5) | 319 ( 3.8) | 266 ( 3.3) | 261 ( 3.6) | 120 ( 2.5) |  |  |
| como_cancers (%) | No | 38187 (98.0) | 10282 (97.9) | 8232 (97.9) | 7827 (98.2) | 7056 (97.9) | 4790 (98.2) | 0.392 |  |
|  | Yes | 783 ( 2.0) | 223 ( 2.1) | 175 ( 2.1) | 145 ( 1.8) | 153 ( 2.1) | 87 ( 1.8) |  |  |
| eggs_gram_ea (mean (SD)) |  | 10.02 (16.01) | 0.00 (0.00) | 2.94 (0.71) | 6.37 (1.55) | 17.26 (3.64) | 39.09 (27.89) | \<0.001 |  |
| meat_gram_ea (mean (SD)) |  | 14.76 (26.11) | 4.50 (15.38) | 11.79 (21.24) | 16.92 (25.83) | 21.01 (29.12) | 29.25 (36.07) | \<0.001 |  |
| fish_gram_ea (mean (SD)) |  | 9.11 (16.36) | 4.58 (14.54) | 9.04 (16.53) | 10.41 (16.04) | 11.82 (16.37) | 12.84 (18.00) | \<0.001 |  |
| alldairy2_gram_ea (mean (SD)) |  | 148.65 (186.52) | 63.84 (139.20) | 150.79 (186.50) | 181.36 (194.20) | 201.11 (191.07) | 196.62 (192.59) | \<0.001 |  |
| totalveg_gram_ea (mean (SD)) |  | 302.26 (179.26) | 342.06 (209.59) | 302.65 (174.66) | 284.28 (160.83) | 284.82 (156.51) | 271.02 (160.36) | \<0.001 |  |
| fruits_gram_ea (mean (SD)) |  | 321.25 (221.73) | 396.44 (245.81) | 338.23 (228.58) | 294.50 (200.67) | 277.47 (187.23) | 238.42 (177.44) | \<0.001 |  |
| refgrains_gram_ea (mean (SD)) |  | 113.52 (116.43) | 98.16 (115.94) | 117.45 (119.08) | 118.89 (116.62) | 124.05 (115.66) | 115.52 (110.39) | \<0.001 |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.02 (188.80) | 329.17 (213.28) | 264.13 (189.12) | 229.22 (171.99) | 213.90 (150.57) | 190.56 (153.65) | \<0.001 |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.31 (20.21) | 28.10 (22.52) | 23.35 (20.40) | 21.54 (18.99) | 20.89 (17.77) | 19.42 (17.89) | \<0.001 |  |
| legumes_gram_ea (mean (SD)) |  | 77.26 (69.15) | 93.71 (82.36) | 79.43 (70.75) | 70.68 (59.13) | 69.04 (57.45) | 60.95 (57.93) | \<0.001 |  |

## Cox models

- To examine risk factors associated with incident atrial fibrosis, we
  employed the Cox proportional hazards model with attained age as the
  time scale
  - Age at entry was calculated based on the return date of AHS-2
    questionnaire
  - Those who died during the follow-up were censored at the date of
    death verified in Medicare data
  - Those who were diagnosed with atrial fibrosis after the study
    enrollment were identified as incident cases and their age at
    diagnosis was calculated.
    - The mean follow-up years was 16.3 years (median 18.2 years)
    - The total person-years of follow-up was 635,549 years
  - The main exposure variable of interest was energy-adjusted egg
    intake, gram/day. Subjects were classified into 4 egg intake groups
    as shown in the descriptive table, and egg intake was entered into
    the models as categorical
    - This is because there was a non-linear association between egg
      intake and afib when egg intake was entered as continuous (see
      below)
  - All other dietary variables were entered into the models as
    continuous. Their hazard ratios were estimated for an increment of
    100 gram/day

<img src="summary_afib_files/figure-gfm/mv_cox_models_results-1.png" alt="" width="1918" />

### Restricted cubic spline for egg intake

- In the output above, egg intake was entered into the models as
  categorical. In the following analysis, we used restricted cubic
  splines to model a nonlinear association between egg intake as
  continuous and atrial fibrosis.
  - The nonlinear terms of egg intake were significant (p = 0.0192)
  - To visualize this nonlinear association, we have plotted hazard
    ratio for egg intake (adjusting for all other covariates) with 95
    confidence intervals
  - The reference for egg intake was set to 0 gram/day to make
    comparisons easier with the table above

![](summary_afib_files/figure-gfm/cubic_spline_egg-1.png)<!-- -->

- Hazard ratios at selected points of egg intake and their 95 CI are
  shown below:

| Egg intake (g/d) |   HR | Lower | Upper |
|-----------------:|-----:|------:|------:|
|                5 | 0.92 |  0.86 |  0.99 |
|               10 | 0.90 |  0.85 |  0.97 |
|               15 | 0.89 |  0.83 |  0.96 |
|               20 | 0.89 |  0.82 |  0.96 |
|               30 | 0.88 |  0.82 |  0.96 |
|               50 | 0.89 |  0.81 |  0.98 |

### Interaction between egg and meat intake

- There were no significant interactions between egg and meat intake (p
  = 0.89)

### Interaction between egg and race

- There were no significant interactions between egg and RTI race (p =
  0.28)

### Hyperlipidemia as time-dependent

- To examine if the effect of egg intake may be dependent on
  hyperlipidemia, we have used hyperlipidemia as a time-dependent
  variable in the Cox model (after removing prevalent hyperlipidemia
  status from the model)
  - There were no significant interactions between egg intake and
    time-dependent hyperlipidemia status (p = 0.77, Model 3)
