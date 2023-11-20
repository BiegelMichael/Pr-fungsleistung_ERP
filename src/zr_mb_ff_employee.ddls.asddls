@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EMPLOYEE'
define root view entity ZR_MB_FF_EMPLOYEE
  as select from zmbff_employee
  composition [0..*] of ZR_MBFF_VACATIONREQUEST as _VacationRequests 
  composition [0..*] of ZR_MB_FF_VACENT         as _VacEnt
{
      @EndUserText: { label: 'Employee UUID', quickInfo: 'EmployeeUUID'}
  key employee_uuid   as EmployeeUuid,
      employee_id     as EmployeeId,
      first_name      as FirstName,
      surname         as Surname,
      entry_date      as EntryDate,

      created_by      as createdBy,
      created_at      as createdAt,
      last_changed_by as lastChanged,
      last_changed_at as lastChangedAt,
      _VacationRequests,
      _VacEnt
}
