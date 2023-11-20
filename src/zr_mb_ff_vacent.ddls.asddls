@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VACATIONENTITLEMENT'
define view entity ZR_MB_FF_VACENT
  as select from zmbff_vacent
  association to parent ZR_MB_FF_EMPLOYEE as _Employee
  on $projection.Employee = _Employee.EmployeeUuid
{
  key vacation_uuid as VacationUuid,
      vac_year      as VacYear,
      vacation_days as VacationDays,
      employee      as Employee,
      created_at as createdAt,
      created_by as createdBy,
      last_changed_at as lastChangedBy,
      last_changed_by as lastChangedAt,
      
      /*Associations*/
      _Employee // Make association public
}
