@EndUserText.label: 'EMPLOYEE APPROVER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_MB_FF_EMPLOYEEAPPROVER
  provider contract transactional_query 
  as projection on ZR_MB_FF_EMPLOYEE
{
    key EmployeeUuid,
    EmployeeId,
    FirstName,
    Surname,
    EntryDate,
    createdBy,
    createdAt,
    lastChanged,
    lastChangedAt,
    /* Associations */
    _VacationRequests : redirected to composition child ZC_MB_FF_VACREQAPPROVER
}
