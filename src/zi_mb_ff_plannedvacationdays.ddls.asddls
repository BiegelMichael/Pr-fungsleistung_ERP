
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planned VacationDays'
define view entity ZI_MB_FF_PLANNEDVACATIONDAYS
  as select from zmbff_vacationrq
{
      /* Fields */
  key applicant          as EmployeeUuid,
      sum(vacation_days) as PlannedVacationDays
}
where
      status   <> 'D'
  and end_date >= $session.system_date
group by
  applicant;
