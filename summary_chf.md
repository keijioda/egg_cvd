Egg CVD study (CHF as outcome)
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

- Prevalent cases of CHF

  - If the first diagnosis was made on or before AHS-2 enrollment date,
    consider it as a prevalent case
  - n = 1,271 prevalent cases were excluded, resulting n = 39,766
    subjects

## Outcome

- The outcome is CHF
- Among n = 39,766 subjects, there were 7,651 incident cases (19.2%) of
  CHF
- Age at diagnosis was calculated using `CHF_EVER` variable in the
  Chronic Condition Warehouse (CCW) data. This variable shows the date
  when the beneficiary first met the criteria after January 1, 1999.
  - For 27 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/documents/10280/19139421/ccw-chronic-condition-algorithms.pdf)
  - For 30 CCW chronic conditions algorithms, see
    [here](https://www2.ccwdata.org/web/guest/condition-categories-chronic)
- Among these incident CHF cases, the mean (SD) age of diagnosis was
  81.0 (9.2) years. The median age of diagnosis was 82.0 years.

## Comorbidity

## Dietary variables

## Descriptive table

- The descriptive table by CHF incidence:

|  | level | Overall | Non-case | Case | p | test |
|:---|:---|:---|:---|:---|:---|:---|
| n |  | 38589 | 31133 | 7456 |  |  |
| agecat (%) | 65-69 | 6678 (17.4) | 6437 (20.8) | 241 ( 3.2) | \<0.001 |  |
|  | 70-74 | 6940 (18.1) | 6426 (20.8) | 514 ( 6.9) |  |  |
|  | 75-79 | 6264 (16.3) | 5503 (17.8) | 761 (10.2) |  |  |
|  | 80-84 | 5557 (14.5) | 4492 (14.5) | 1065 (14.3) |  |  |
|  | 85-89 | 4839 (12.6) | 3438 (11.1) | 1401 (18.8) |  |  |
|  | 90-94 | 4023 (10.5) | 2544 ( 8.2) | 1479 (19.9) |  |  |
|  | 95+ | 4059 (10.6) | 2081 ( 6.7) | 1978 (26.6) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.63 (10.33) | 78.79 (9.63) | 88.34 (9.54) | \<0.001 |  |
| bene_sex_F (%) | M | 13967 (36.2) | 11072 (35.6) | 2895 (38.8) | \<0.001 |  |
|  | F | 24622 (63.8) | 20061 (64.4) | 4561 (61.2) |  |  |
| rti_race3 (%) | NH White | 28578 (74.1) | 22514 (72.3) | 6064 (81.3) | \<0.001 |  |
|  | Black | 7374 (19.1) | 6291 (20.2) | 1083 (14.5) |  |  |
|  | Other | 2637 ( 6.8) | 2328 ( 7.5) | 309 ( 4.1) |  |  |
| marital (%) | Married | 28417 (73.6) | 23399 (75.2) | 5018 (67.3) | \<0.001 |  |
|  | Never | 1332 ( 3.5) | 1115 ( 3.6) | 217 ( 2.9) |  |  |
|  | Div/Wid | 8840 (22.9) | 6619 (21.3) | 2221 (29.8) |  |  |
| educyou (%) | HSch & below | 8127 (21.1) | 6144 (19.7) | 1983 (26.6) | \<0.001 |  |
|  | Some College | 15310 (39.7) | 12364 (39.7) | 2946 (39.5) |  |  |
|  | Bachelors + | 15152 (39.3) | 12625 (40.6) | 2527 (33.9) |  |  |
| vegstat (%) | Vegan | 3211 ( 8.3) | 2619 ( 8.4) | 592 ( 7.9) | 0.002 |  |
|  | Lacto-ovo | 12483 (32.3) | 10020 (32.2) | 2463 (33.0) |  |  |
|  | Semi | 2138 ( 5.5) | 1672 ( 5.4) | 466 ( 6.2) |  |  |
|  | Pesco | 3711 ( 9.6) | 3052 ( 9.8) | 659 ( 8.8) |  |  |
|  | Non-veg | 17046 (44.2) | 13770 (44.2) | 3276 (43.9) |  |  |
| bmicat (%) | Normal | 14960 (38.8) | 12425 (39.9) | 2535 (34.0) | \<0.001 |  |
|  | Overweight | 14105 (36.6) | 11417 (36.7) | 2688 (36.1) |  |  |
|  | Obese | 9524 (24.7) | 7291 (23.4) | 2233 (29.9) |  |  |
| bmi (mean (SD)) |  | 27.19 (5.45) | 27.01 (5.34) | 27.95 (5.82) | \<0.001 |  |
| exercise (%) | None | 8290 (21.5) | 6057 (19.5) | 2233 (29.9) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9425 (24.4) | 7784 (25.0) | 1641 (22.0) |  |  |
|  | 0.5\<-2 hrs/wk | 10287 (26.7) | 8568 (27.5) | 1719 (23.1) |  |  |
|  | \>2 hrs/wk | 10587 (27.4) | 8724 (28.0) | 1863 (25.0) |  |  |
| sleephrs (%) | \<= 5 hrs | 3754 ( 9.7) | 3001 ( 9.6) | 753 (10.1) | \<0.001 |  |
|  | 6 hrs | 8418 (21.8) | 6901 (22.2) | 1517 (20.3) |  |  |
|  | 7 hrs | 14041 (36.4) | 11629 (37.4) | 2412 (32.3) |  |  |
|  | 8 hrs | 10215 (26.5) | 8024 (25.8) | 2191 (29.4) |  |  |
|  | \>= 9 hrs | 2161 ( 5.6) | 1578 ( 5.1) | 583 ( 7.8) |  |  |
| smokecat6 (%) | A_Never | 30773 (79.7) | 24956 (80.2) | 5817 (78.0) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3254 ( 8.4) | 2465 ( 7.9) | 789 (10.6) |  |  |
|  | C_QuitYrs21To30 | 1979 ( 5.1) | 1637 ( 5.3) | 342 ( 4.6) |  |  |
|  | D_QuitYrs11To20 | 1335 ( 3.5) | 1075 ( 3.5) | 260 ( 3.5) |  |  |
|  | E_QuitYrs6To10 | 468 ( 1.2) | 370 ( 1.2) | 98 ( 1.3) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 780 ( 2.0) | 630 ( 2.0) | 150 ( 2.0) |  |  |
| alccat (%) | Never | 36687 (95.1) | 29512 (94.8) | 7175 (96.2) | \<0.001 |  |
|  | Current | 1902 ( 4.9) | 1621 ( 5.2) | 281 ( 3.8) |  |  |
| como_depress (%) | No | 37943 (98.3) | 30870 (99.2) | 7073 (94.9) | \<0.001 |  |
|  | Yes | 646 ( 1.7) | 263 ( 0.8) | 383 ( 5.1) |  |  |
| como_disab (%) | No | 33644 (87.2) | 28925 (92.9) | 4719 (63.3) | \<0.001 |  |
|  | Yes | 4945 (12.8) | 2208 ( 7.1) | 2737 (36.7) |  |  |
| como_diabetes (%) | No | 37466 (97.1) | 30734 (98.7) | 6732 (90.3) | \<0.001 |  |
|  | Yes | 1123 ( 2.9) | 399 ( 1.3) | 724 ( 9.7) |  |  |
| como_hypert (%) | No | 35171 (91.1) | 29775 (95.6) | 5396 (72.4) | \<0.001 |  |
|  | Yes | 3418 ( 8.9) | 1358 ( 4.4) | 2060 (27.6) |  |  |
| como_hyperl (%) | No | 35770 (92.7) | 29948 (96.2) | 5822 (78.1) | \<0.001 |  |
|  | Yes | 2819 ( 7.3) | 1185 ( 3.8) | 1634 (21.9) |  |  |
| como_resp (%) | No | 37864 (98.1) | 30849 (99.1) | 7015 (94.1) | \<0.001 |  |
|  | Yes | 725 ( 1.9) | 284 ( 0.9) | 441 ( 5.9) |  |  |
| como_anemia (%) | No | 36771 (95.3) | 30376 (97.6) | 6395 (85.8) | \<0.001 |  |
|  | Yes | 1818 ( 4.7) | 757 ( 2.4) | 1061 (14.2) |  |  |
| como_kidney (%) | No | 38351 (99.4) | 31044 (99.7) | 7307 (98.0) | \<0.001 |  |
|  | Yes | 238 ( 0.6) | 89 ( 0.3) | 149 ( 2.0) |  |  |
| como_hypoth (%) | No | 37368 (96.8) | 30615 (98.3) | 6753 (90.6) | \<0.001 |  |
|  | Yes | 1221 ( 3.2) | 518 ( 1.7) | 703 ( 9.4) |  |  |
| como_cancers (%) | No | 37872 (98.1) | 30802 (98.9) | 7070 (94.8) | \<0.001 |  |
|  | Yes | 717 ( 1.9) | 331 ( 1.1) | 386 ( 5.2) |  |  |
| eggs_gram_ea (mean (SD)) |  | 9.99 (15.93) | 9.90 (15.90) | 10.37 (16.05) | 0.024 |  |
| meat_gram_ea_4 (%) | None | 19399 (50.3) | 15689 (50.4) | 3710 (49.8) | 0.004 |  |
|  | \<11 g/d | 6411 (16.6) | 5088 (16.3) | 1323 (17.7) |  |  |
|  | 11-\<33 g/d | 6476 (16.8) | 5200 (16.7) | 1276 (17.1) |  |  |
|  | 33+ g/d | 6303 (16.3) | 5156 (16.6) | 1147 (15.4) |  |  |
| meat_gram_ea (mean (SD)) |  | 14.67 (26.07) | 14.78 (26.03) | 14.21 (26.24) | 0.093 |  |
| fish_gram_ea_4 (%) | None | 18870 (48.9) | 15132 (48.6) | 3738 (50.1) | \<0.001 |  |
|  | \<9 g/d | 6950 (18.0) | 5506 (17.7) | 1444 (19.4) |  |  |
|  | 9-\<18 g/d | 6621 (17.2) | 5353 (17.2) | 1268 (17.0) |  |  |
|  | 18+ g/d | 6148 (15.9) | 5142 (16.5) | 1006 (13.5) |  |  |
| fish_gram_ea (mean (SD)) |  | 9.05 (16.29) | 9.28 (16.72) | 8.05 (14.31) | \<0.001 |  |
| alldairy2_gram_ea_4 (%) | None | 4416 (11.4) | 3615 (11.6) | 801 (10.7) | \<0.001 |  |
|  | \<50 g/d | 11214 (29.1) | 9106 (29.2) | 2108 (28.3) |  |  |
|  | 50-\<180 g/d | 11464 (29.7) | 9295 (29.9) | 2169 (29.1) |  |  |
|  | 180+ g/d | 11495 (29.8) | 9117 (29.3) | 2378 (31.9) |  |  |
| alldairy2_gram_ea (mean (SD)) |  | 148.09 (185.79) | 146.13 (184.56) | 156.24 (190.63) | \<0.001 |  |
| totalveg_gram_ea_4 (%) | \<185 g/d | 9767 (25.3) | 7852 (25.2) | 1915 (25.7) | 0.496 |  |
|  | 185-\<270 g/d | 9550 (24.7) | 7754 (24.9) | 1796 (24.1) |  |  |
|  | 270-\<380 g/d | 9676 (25.1) | 7787 (25.0) | 1889 (25.3) |  |  |
|  | 380+ g/d | 9596 (24.9) | 7740 (24.9) | 1856 (24.9) |  |  |
| totalveg_gram_ea (mean (SD)) |  | 302.25 (178.90) | 302.40 (179.61) | 301.62 (175.88) | 0.733 |  |
| fruits_gram_ea_4 (%) | \<170 g/d | 9716 (25.2) | 7937 (25.5) | 1779 (23.9) | 0.005 |  |
|  | 170-\<280 g/d | 9557 (24.8) | 7715 (24.8) | 1842 (24.7) |  |  |
|  | 280-\<420 g/d | 9682 (25.1) | 7807 (25.1) | 1875 (25.1) |  |  |
|  | 420+ g/d | 9634 (25.0) | 7674 (24.6) | 1960 (26.3) |  |  |
| fruits_gram_ea (mean (SD)) |  | 321.78 (221.39) | 320.65 (222.70) | 326.48 (215.80) | 0.041 |  |
| refgrains_gram_ea_4 (%) | \<40 g/d | 10057 (26.1) | 7784 (25.0) | 2273 (30.5) | \<0.001 |  |
|  | 40-\<83 g/d | 9750 (25.3) | 7862 (25.3) | 1888 (25.3) |  |  |
|  | 83-\<150 g/d | 9543 (24.7) | 7856 (25.2) | 1687 (22.6) |  |  |
|  | 150+ g/d | 9239 (23.9) | 7631 (24.5) | 1608 (21.6) |  |  |
| refgrains_gram_ea (mean (SD)) |  | 113.35 (116.24) | 115.01 (116.15) | 106.43 (116.40) | \<0.001 |  |
| whole_mixed_grains_gram_ea_4 (%) | \<120 g/d | 10037 (26.0) | 8207 (26.4) | 1830 (24.5) | 0.009 |  |
|  | 120-\<210 g/d | 9345 (24.2) | 7537 (24.2) | 1808 (24.2) |  |  |
|  | 219-\<350 g/d | 9514 (24.7) | 7621 (24.5) | 1893 (25.4) |  |  |
|  | 350+ g/d | 9693 (25.1) | 7768 (25.0) | 1925 (25.8) |  |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.34 (188.60) | 255.00 (188.15) | 261.94 (190.36) | 0.004 |  |
| nutsseeds_gram_ea_4 (%) | \<9 g/d | 9744 (25.3) | 7869 (25.3) | 1875 (25.1) | 0.005 |  |
|  | 9-\<18 g/d | 9207 (23.9) | 7496 (24.1) | 1711 (22.9) |  |  |
|  | 18-\<32 g/d | 9925 (25.7) | 8047 (25.8) | 1878 (25.2) |  |  |
|  | 32+ g/d | 9713 (25.2) | 7721 (24.8) | 1992 (26.7) |  |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.43 (20.29) | 23.25 (20.04) | 24.16 (21.25) | 0.001 |  |
| legumes_gram_ea_4 (%) | \<33 g/d | 9501 (24.6) | 7527 (24.2) | 1974 (26.5) | \<0.001 |  |
|  | 33-\<60 g/d | 9359 (24.3) | 7469 (24.0) | 1890 (25.3) |  |  |
|  | 60-\<100 g/d | 10183 (26.4) | 8304 (26.7) | 1879 (25.2) |  |  |
|  | 100+ g/d | 9546 (24.7) | 7833 (25.2) | 1713 (23.0) |  |  |
| legumes_gram_ea (mean (SD)) |  | 77.43 (68.93) | 78.31 (69.66) | 73.77 (65.66) | \<0.001 |  |

- The descriptive table by egg intake (4 groups):

|  | level | Overall | None | \<4.5 g/d | 4.5-\<16.5 g/d | 16.5+ g/d | p | test |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| n |  | 38589 | 10428 | 9515 | 9399 | 9247 |  |  |
| CHF_YN (%) | No | 31133 (80.7) | 8419 (80.7) | 7656 (80.5) | 7679 (81.7) | 7379 (79.8) | 0.011 |  |
|  | Yes | 7456 (19.3) | 2009 (19.3) | 1859 (19.5) | 1720 (18.3) | 1868 (20.2) |  |  |
| agecat (%) | 65-69 | 6678 (17.4) | 1644 (15.9) | 1651 (17.4) | 1722 (18.4) | 1661 (18.1) | \<0.001 |  |
|  | 70-74 | 6940 (18.1) | 1797 (17.3) | 1717 (18.1) | 1740 (18.6) | 1686 (18.4) |  |  |
|  | 75-79 | 6264 (16.3) | 1665 (16.1) | 1544 (16.3) | 1514 (16.2) | 1541 (16.8) |  |  |
|  | 80-84 | 5557 (14.5) | 1523 (14.7) | 1341 (14.2) | 1323 (14.2) | 1370 (14.9) |  |  |
|  | 85-89 | 4839 (12.6) | 1337 (12.9) | 1184 (12.5) | 1187 (12.7) | 1131 (12.3) |  |  |
|  | 90-94 | 4023 (10.5) | 1173 (11.3) | 1003 (10.6) | 929 ( 9.9) | 918 (10.0) |  |  |
|  | 95+ | 4059 (10.6) | 1232 (11.9) | 1026 (10.8) | 923 ( 9.9) | 878 ( 9.6) |  |  |
| bene_age_at_end_2020 (mean (SD)) |  | 80.63 (10.33) | 81.31 (10.47) | 80.68 (10.37) | 80.25 (10.26) | 80.21 (10.14) | \<0.001 |  |
| bene_sex_F (%) | M | 13967 (36.2) | 3707 (35.5) | 3026 (31.8) | 3716 (39.5) | 3518 (38.0) | \<0.001 |  |
|  | F | 24622 (63.8) | 6721 (64.5) | 6489 (68.2) | 5683 (60.5) | 5729 (62.0) |  |  |
| rti_race3 (%) | NH White | 28578 (74.1) | 7607 (72.9) | 6565 (69.0) | 7115 (75.7) | 7291 (78.8) | \<0.001 |  |
|  | Black | 7374 (19.1) | 2174 (20.8) | 2196 (23.1) | 1607 (17.1) | 1397 (15.1) |  |  |
|  | Other | 2637 ( 6.8) | 647 ( 6.2) | 754 ( 7.9) | 677 ( 7.2) | 559 ( 6.0) |  |  |
| marital (%) | Married | 28417 (73.6) | 7599 (72.9) | 6799 (71.5) | 7178 (76.4) | 6841 (74.0) | \<0.001 |  |
|  | Never | 1332 ( 3.5) | 422 ( 4.0) | 374 ( 3.9) | 245 ( 2.6) | 291 ( 3.1) |  |  |
|  | Div/Wid | 8840 (22.9) | 2407 (23.1) | 2342 (24.6) | 1976 (21.0) | 2115 (22.9) |  |  |
| educyou (%) | HSch & below | 8127 (21.1) | 2062 (19.8) | 2129 (22.4) | 1913 (20.4) | 2023 (21.9) | \<0.001 |  |
|  | Some College | 15310 (39.7) | 3980 (38.2) | 3735 (39.3) | 3701 (39.4) | 3894 (42.1) |  |  |
|  | Bachelors + | 15152 (39.3) | 4386 (42.1) | 3651 (38.4) | 3785 (40.3) | 3330 (36.0) |  |  |
| vegstat (%) | Vegan | 3211 ( 8.3) | 3211 (30.8) | 0 ( 0.0) | 0 ( 0.0) | 0 ( 0.0) | \<0.001 |  |
|  | Lacto-ovo | 12483 (32.3) | 4110 (39.4) | 3539 (37.2) | 2722 (29.0) | 2112 (22.8) |  |  |
|  | Semi | 2138 ( 5.5) | 381 ( 3.7) | 679 ( 7.1) | 578 ( 6.1) | 500 ( 5.4) |  |  |
|  | Pesco | 3711 ( 9.6) | 1060 (10.2) | 1024 (10.8) | 904 ( 9.6) | 723 ( 7.8) |  |  |
|  | Non-veg | 17046 (44.2) | 1666 (16.0) | 4273 (44.9) | 5195 (55.3) | 5912 (63.9) |  |  |
| bmicat (%) | Normal | 14960 (38.8) | 5487 (52.6) | 3736 (39.3) | 3145 (33.5) | 2592 (28.0) | \<0.001 |  |
|  | Overweight | 14105 (36.6) | 3291 (31.6) | 3592 (37.8) | 3701 (39.4) | 3521 (38.1) |  |  |
|  | Obese | 9524 (24.7) | 1650 (15.8) | 2187 (23.0) | 2553 (27.2) | 3134 (33.9) |  |  |
| bmi (mean (SD)) |  | 27.19 (5.45) | 25.57 (4.94) | 27.04 (5.27) | 27.72 (5.38) | 28.62 (5.74) | \<0.001 |  |
| exercise (%) | None | 8290 (21.5) | 2003 (19.2) | 2088 (21.9) | 1955 (20.8) | 2244 (24.3) | \<0.001 |  |
|  | ≤0.5 hrs/wk | 9425 (24.4) | 2174 (20.8) | 2305 (24.2) | 2466 (26.2) | 2480 (26.8) |  |  |
|  | 0.5\<-2 hrs/wk | 10287 (26.7) | 2810 (26.9) | 2515 (26.4) | 2557 (27.2) | 2405 (26.0) |  |  |
|  | \>2 hrs/wk | 10587 (27.4) | 3441 (33.0) | 2607 (27.4) | 2421 (25.8) | 2118 (22.9) |  |  |
| sleephrs (%) | \<= 5 hrs | 3754 ( 9.7) | 952 ( 9.1) | 1033 (10.9) | 867 ( 9.2) | 902 ( 9.8) | \<0.001 |  |
|  | 6 hrs | 8418 (21.8) | 2186 (21.0) | 2158 (22.7) | 2097 (22.3) | 1977 (21.4) |  |  |
|  | 7 hrs | 14041 (36.4) | 3840 (36.8) | 3363 (35.3) | 3484 (37.1) | 3354 (36.3) |  |  |
|  | 8 hrs | 10215 (26.5) | 2881 (27.6) | 2439 (25.6) | 2452 (26.1) | 2443 (26.4) |  |  |
|  | \>= 9 hrs | 2161 ( 5.6) | 569 ( 5.5) | 522 ( 5.5) | 499 ( 5.3) | 571 ( 6.2) |  |  |
| smokecat6 (%) | A_Never | 30773 (79.7) | 8598 (82.5) | 7771 (81.7) | 7435 (79.1) | 6969 (75.4) | \<0.001 |  |
|  | B_QuitYrs30Plus | 3254 ( 8.4) | 863 ( 8.3) | 700 ( 7.4) | 796 ( 8.5) | 895 ( 9.7) |  |  |
|  | C_QuitYrs21To30 | 1979 ( 5.1) | 499 ( 4.8) | 444 ( 4.7) | 502 ( 5.3) | 534 ( 5.8) |  |  |
|  | D_QuitYrs11To20 | 1335 ( 3.5) | 266 ( 2.6) | 315 ( 3.3) | 337 ( 3.6) | 417 ( 4.5) |  |  |
|  | E_QuitYrs6To10 | 468 ( 1.2) | 95 ( 0.9) | 99 ( 1.0) | 120 ( 1.3) | 154 ( 1.7) |  |  |
|  | F_QuitYrsLesOneTo5YearsNcur | 780 ( 2.0) | 107 ( 1.0) | 186 ( 2.0) | 209 ( 2.2) | 278 ( 3.0) |  |  |
| alccat (%) | Never | 36687 (95.1) | 10229 (98.1) | 9122 (95.9) | 8801 (93.6) | 8535 (92.3) | \<0.001 |  |
|  | Current | 1902 ( 4.9) | 199 ( 1.9) | 393 ( 4.1) | 598 ( 6.4) | 712 ( 7.7) |  |  |
| como_depress (%) | No | 37943 (98.3) | 10257 (98.4) | 9354 (98.3) | 9252 (98.4) | 9080 (98.2) | 0.623 |  |
|  | Yes | 646 ( 1.7) | 171 ( 1.6) | 161 ( 1.7) | 147 ( 1.6) | 167 ( 1.8) |  |  |
| como_disab (%) | No | 33644 (87.2) | 8928 (85.6) | 8304 (87.3) | 8289 (88.2) | 8123 (87.8) | \<0.001 |  |
|  | Yes | 4945 (12.8) | 1500 (14.4) | 1211 (12.7) | 1110 (11.8) | 1124 (12.2) |  |  |
| como_diabetes (%) | No | 37466 (97.1) | 10197 (97.8) | 9247 (97.2) | 9107 (96.9) | 8915 (96.4) | \<0.001 |  |
|  | Yes | 1123 ( 2.9) | 231 ( 2.2) | 268 ( 2.8) | 292 ( 3.1) | 332 ( 3.6) |  |  |
| como_hypert (%) | No | 35171 (91.1) | 9570 (91.8) | 8653 (90.9) | 8542 (90.9) | 8406 (90.9) | 0.071 |  |
|  | Yes | 3418 ( 8.9) | 858 ( 8.2) | 862 ( 9.1) | 857 ( 9.1) | 841 ( 9.1) |  |  |
| como_hyperl (%) | No | 35770 (92.7) | 9668 (92.7) | 8809 (92.6) | 8687 (92.4) | 8606 (93.1) | 0.376 |  |
|  | Yes | 2819 ( 7.3) | 760 ( 7.3) | 706 ( 7.4) | 712 ( 7.6) | 641 ( 6.9) |  |  |
| como_resp (%) | No | 37864 (98.1) | 10244 (98.2) | 9339 (98.2) | 9229 (98.2) | 9052 (97.9) | 0.297 |  |
|  | Yes | 725 ( 1.9) | 184 ( 1.8) | 176 ( 1.8) | 170 ( 1.8) | 195 ( 2.1) |  |  |
| como_anemia (%) | No | 36771 (95.3) | 9878 (94.7) | 9067 (95.3) | 8990 (95.6) | 8836 (95.6) | 0.009 |  |
|  | Yes | 1818 ( 4.7) | 550 ( 5.3) | 448 ( 4.7) | 409 ( 4.4) | 411 ( 4.4) |  |  |
| como_kidney (%) | No | 38351 (99.4) | 10377 (99.5) | 9459 (99.4) | 9343 (99.4) | 9172 (99.2) | 0.034 |  |
|  | Yes | 238 ( 0.6) | 51 ( 0.5) | 56 ( 0.6) | 56 ( 0.6) | 75 ( 0.8) |  |  |
| como_hypoth (%) | No | 37368 (96.8) | 10078 (96.6) | 9207 (96.8) | 9099 (96.8) | 8984 (97.2) | 0.209 |  |
|  | Yes | 1221 ( 3.2) | 350 ( 3.4) | 308 ( 3.2) | 300 ( 3.2) | 263 ( 2.8) |  |  |
| como_cancers (%) | No | 37872 (98.1) | 10227 (98.1) | 9323 (98.0) | 9250 (98.4) | 9072 (98.1) | 0.138 |  |
|  | Yes | 717 ( 1.9) | 201 ( 1.9) | 192 ( 2.0) | 149 ( 1.6) | 175 ( 1.9) |  |  |
| eggs_gram_ea (mean (SD)) |  | 9.99 (15.93) | 0.00 (0.00) | 3.10 (0.79) | 8.64 (3.36) | 29.73 (22.22) | \<0.001 |  |
| meat_gram_ea_4 (%) | None | 19399 (50.3) | 8380 (80.4) | 4560 (47.9) | 3626 (38.6) | 2833 (30.6) | \<0.001 |  |
|  | \<11 g/d | 6411 (16.6) | 976 ( 9.4) | 2005 (21.1) | 1867 (19.9) | 1563 (16.9) |  |  |
|  | 11-\<33 g/d | 6476 (16.8) | 611 ( 5.9) | 1743 (18.3) | 1997 (21.2) | 2125 (23.0) |  |  |
|  | 33+ g/d | 6303 (16.3) | 461 ( 4.4) | 1207 (12.7) | 1909 (20.3) | 2726 (29.5) |  |  |
| meat_gram_ea (mean (SD)) |  | 14.67 (26.07) | 4.43 (15.31) | 12.21 (21.55) | 18.17 (27.48) | 25.20 (32.85) | \<0.001 |  |
| fish_gram_ea_4 (%) | None | 18870 (48.9) | 7836 (75.1) | 4416 (46.4) | 3574 (38.0) | 3044 (32.9) | \<0.001 |  |
|  | \<9 g/d | 6950 (18.0) | 1055 (10.1) | 1943 (20.4) | 1923 (20.5) | 2029 (21.9) |  |  |
|  | 9-\<18 g/d | 6621 (17.2) | 781 ( 7.5) | 1701 (17.9) | 1968 (20.9) | 2171 (23.5) |  |  |
|  | 18+ g/d | 6148 (15.9) | 756 ( 7.2) | 1455 (15.3) | 1934 (20.6) | 2003 (21.7) |  |  |
| fish_gram_ea (mean (SD)) |  | 9.05 (16.29) | 4.51 (14.40) | 9.05 (16.20) | 11.11 (16.50) | 12.06 (17.05) | \<0.001 |  |
| alldairy2_gram_ea_4 (%) | None | 4416 (11.4) | 3651 (35.0) | 400 ( 4.2) | 208 ( 2.2) | 157 ( 1.7) | \<0.001 |  |
|  | \<50 g/d | 11214 (29.1) | 4029 (38.6) | 3270 (34.4) | 2137 (22.7) | 1778 (19.2) |  |  |
|  | 50-\<180 g/d | 11464 (29.7) | 1619 (15.5) | 3092 (32.5) | 3438 (36.6) | 3315 (35.8) |  |  |
|  | 180+ g/d | 11495 (29.8) | 1129 (10.8) | 2753 (28.9) | 3616 (38.5) | 3997 (43.2) |  |  |
| alldairy2_gram_ea (mean (SD)) |  | 148.09 (185.79) | 63.24 (138.60) | 149.21 (182.93) | 187.69 (193.01) | 202.35 (193.47) | \<0.001 |  |
| totalveg_gram_ea_4 (%) | \<185 g/d | 9767 (25.3) | 2041 (19.6) | 2521 (26.5) | 2545 (27.1) | 2660 (28.8) | \<0.001 |  |
|  | 185-\<270 g/d | 9550 (24.7) | 2331 (22.4) | 2308 (24.3) | 2484 (26.4) | 2427 (26.2) |  |  |
|  | 270-\<380 g/d | 9676 (25.1) | 2643 (25.3) | 2378 (25.0) | 2367 (25.2) | 2288 (24.7) |  |  |
|  | 380+ g/d | 9596 (24.9) | 3413 (32.7) | 2308 (24.3) | 2003 (21.3) | 1872 (20.2) |  |  |
| totalveg_gram_ea (mean (SD)) |  | 302.25 (178.90) | 341.75 (208.53) | 297.66 (175.31) | 284.79 (155.60) | 280.17 (160.36) | \<0.001 |  |
| fruits_gram_ea_4 (%) | \<170 g/d | 9716 (25.2) | 1544 (14.8) | 2275 (23.9) | 2696 (28.7) | 3201 (34.6) | \<0.001 |  |
|  | 170-\<280 g/d | 9557 (24.8) | 2053 (19.7) | 2312 (24.3) | 2576 (27.4) | 2616 (28.3) |  |  |
|  | 280-\<420 g/d | 9682 (25.1) | 2889 (27.7) | 2436 (25.6) | 2307 (24.5) | 2050 (22.2) |  |  |
|  | 420+ g/d | 9634 (25.0) | 3942 (37.8) | 2492 (26.2) | 1820 (19.4) | 1380 (14.9) |  |  |
| fruits_gram_ea (mean (SD)) |  | 321.78 (221.39) | 397.14 (245.15) | 330.17 (225.57) | 290.55 (196.97) | 259.89 (183.55) | \<0.001 |  |
| refgrains_gram_ea_4 (%) | \<40 g/d | 10057 (26.1) | 3854 (37.0) | 2320 (24.4) | 1898 (20.2) | 1985 (21.5) | \<0.001 |  |
|  | 40-\<83 g/d | 9750 (25.3) | 2432 (23.3) | 2432 (25.6) | 2491 (26.5) | 2395 (25.9) |  |  |
|  | 83-\<150 g/d | 9543 (24.7) | 2070 (19.9) | 2430 (25.5) | 2565 (27.3) | 2478 (26.8) |  |  |
|  | 150+ g/d | 9239 (23.9) | 2072 (19.9) | 2333 (24.5) | 2445 (26.0) | 2389 (25.8) |  |  |
| refgrains_gram_ea (mean (SD)) |  | 113.35 (116.24) | 98.16 (115.88) | 116.42 (118.45) | 120.57 (113.68) | 119.98 (115.36) | \<0.001 |  |
| whole_mixed_grains_gram_ea_4 (%) | \<120 g/d | 10037 (26.0) | 1572 (15.1) | 2466 (25.9) | 2801 (29.8) | 3198 (34.6) | \<0.001 |  |
|  | 120-\<210 g/d | 9345 (24.2) | 1901 (18.2) | 2352 (24.7) | 2588 (27.5) | 2504 (27.1) |  |  |
|  | 219-\<350 g/d | 9514 (24.7) | 2888 (27.7) | 2284 (24.0) | 2255 (24.0) | 2087 (22.6) |  |  |
|  | 350+ g/d | 9693 (25.1) | 4067 (39.0) | 2413 (25.4) | 1755 (18.7) | 1458 (15.8) |  |  |
| whole_mixed_grains_gram_ea (mean (SD)) |  | 256.34 (188.60) | 329.57 (212.83) | 256.41 (187.53) | 224.29 (164.03) | 206.27 (155.66) | \<0.001 |  |
| nutsseeds_gram_ea_4 (%) | \<9 g/d | 9744 (25.3) | 1995 (19.1) | 2543 (26.7) | 2487 (26.5) | 2719 (29.4) | \<0.001 |  |
|  | 9-\<18 g/d | 9207 (23.9) | 1996 (19.1) | 2350 (24.7) | 2429 (25.8) | 2432 (26.3) |  |  |
|  | 18-\<32 g/d | 9925 (25.7) | 2770 (26.6) | 2348 (24.7) | 2502 (26.6) | 2305 (24.9) |  |  |
|  | 32+ g/d | 9713 (25.2) | 3667 (35.2) | 2274 (23.9) | 1981 (21.1) | 1791 (19.4) |  |  |
| nutsseeds_gram_ea (mean (SD)) |  | 23.43 (20.29) | 28.24 (22.63) | 22.81 (20.18) | 21.62 (18.73) | 20.48 (18.04) | \<0.001 |  |
| legumes_gram_ea_4 (%) | \<33 g/d | 9501 (24.6) | 1871 (17.9) | 2313 (24.3) | 2452 (26.1) | 2865 (31.0) | \<0.001 |  |
|  | 33-\<60 g/d | 9359 (24.3) | 2186 (21.0) | 2379 (25.0) | 2372 (25.2) | 2422 (26.2) |  |  |
|  | 60-\<100 g/d | 10183 (26.4) | 2906 (27.9) | 2484 (26.1) | 2520 (26.8) | 2273 (24.6) |  |  |
|  | 100+ g/d | 9546 (24.7) | 3465 (33.2) | 2339 (24.6) | 2055 (21.9) | 1687 (18.2) |  |  |
| legumes_gram_ea (mean (SD)) |  | 77.43 (68.93) | 93.90 (81.86) | 77.52 (69.32) | 71.47 (59.06) | 64.83 (57.28) | \<0.001 |  |

## Cox models

- To examine risk factors associated with incident CHF, we employed the
  Cox proportional hazards model with attained age as the time scale
  - Age at entry was calculated based on the return date of AHS-2
    questionnaire
  - Those who died during the follow-up were censored at the date of
    death verified in Medicare data
  - Those who were diagnosed with CHF after the study enrollment were
    identified as incident cases and their age at diagnosis was
    calculated.
    - The mean follow-up years was 16.3 years (median 18.4 years)
    - The total person-years of follow-up was 646,213 years
  - The main exposure variable of interest was energy-adjusted egg
    intake, gram/day. Subjects were classified into 4 egg intake groups
    as shown in the descriptive table, and egg intake was entered into
    the models as categorical
    - This is because there was a non-linear association between egg
      intake and CHF when egg intake was entered as continuous (see
      below)
  - All other dietary variables were entered into the models as
    continuous. Their hazard ratios were estimated for an increment of
    100 gram/day

![](summary_chf_files/figure-gfm/mv_cox_models_results-1.png)<!-- -->

### Restricted cubic spline for dietary intake

- In the output above, egg intake was entered into the models as
  categorical. In the following analysis, we used restricted cubic
  splines to model a nonlinear association between egg intake as
  continuous and CHF.
  - The nonlinear terms of egg intake were significant (p = 0.0094)
  - To visualize this nonlinear association, we have plotted hazard
    ratio for egg intake (adjusting for all other covariates) with 95
    confidence intervals
  - The reference for egg intake was set to 0 gram/day to make
    comparisons easier with the table above

![](summary_chf_files/figure-gfm/cubic_spline_egg-1.png)<!-- -->

- Hazard ratios at selected points of egg intake and their 95 CI are
  shown below:

| Egg intake (g/d) |   HR | Lower | Upper |
|-----------------:|-----:|------:|------:|
|                5 | 0.93 |  0.87 |  0.99 |
|               10 | 0.92 |  0.86 |  0.98 |
|               15 | 0.91 |  0.86 |  0.97 |
|               20 | 0.91 |  0.85 |  0.98 |
|               30 | 0.92 |  0.85 |  0.98 |
|               50 | 0.93 |  0.86 |  1.01 |

- When examined for non-linearity, nuts/seed intake also showed a
  significant non-linear association with IHD. The plot of adjusted HRs
  is shown below.

![](summary_chf_files/figure-gfm/cubic_spline_nuts-1.png)<!-- -->

| Nuts/seeds intake (g/d) |   HR | Lower | Upper |
|------------------------:|-----:|------:|------:|
|                      10 | 0.85 |  0.78 |  0.92 |
|                      20 | 0.79 |  0.72 |  0.87 |
|                      30 | 0.79 |  0.72 |  0.86 |
|                      40 | 0.79 |  0.73 |  0.86 |
|                      50 | 0.80 |  0.73 |  0.87 |

### Interaction between egg and meat intake

- There were no significant interactions between egg and meat intake (p
  = 0.38)

### Hyperlipidemia as time-dependent

- To examine if the effect of egg intake may be dependent on
  hyperlipidemia, we have used hyperlipidemia as a time-dependent
  variable in the Cox model (after removing prevalent hyperlipidemia
  status from the model)
  - There were no significant interactions between egg intake and
    time-dependent hyperlipidemia status (p = 0.76, Model 3)
