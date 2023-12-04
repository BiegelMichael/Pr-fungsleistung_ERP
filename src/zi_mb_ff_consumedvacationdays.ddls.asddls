@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumed VacationDays'

define view entity ZI_MB_FF_CONSUMEDVACATIONDAYS
  as select from zmbff_vacationrq
{
      /* Fields */
  key applicant          as EmployeeUuid,
      sum(vacation_days) as ConsumedVacationDays
}
where
      status   = 'A'
  and end_date < $session.user_date
group by
  applicant;
