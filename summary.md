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

- If we define CVD cases as any one of the 5 conditions:
  - There are 18,181 cases (45.1%) of CVDs
  - Among them, there are 5,315 prevalent cases and 12,866 incident
    cases
- \[Approach\] Start with all 5 conditions combined and then explore
  individual conditions as sensitivity analysis
