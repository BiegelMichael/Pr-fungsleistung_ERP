
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Available VacationDays'

define view entity ZI_MB_FF_AVAILABLEVACATIONDAYS as select from zmbff_vacent
  association [1..1] to ZI_MB_FF_CONSUMEDVACATIONDAYS as _ConsumedVD on $projection.EmployeeUuid = _ConsumedVD.EmployeeUuid
  association [1..1] to ZI_MB_FF_PLANNEDVACATIONDAYS  as _PlannedVD  on $projection.EmployeeUuid = _PlannedVD.EmployeeUuid
{
      /* Fields */
  key employee                                                                                                  as EmployeeUuid,
      coalesce(sum(vacation_days) - coalesce(_ConsumedVD.ConsumedVacationDays, 0) - coalesce(_PlannedVD.PlannedVacationDays, 0), sum(vacation_days)) as AvailableVacationDays

}
//where entitlement_year = left($session.system_date, 4);
group by
  employee,
  _ConsumedVD.ConsumedVacationDays,
  _PlannedVD.PlannedVacationDays;
