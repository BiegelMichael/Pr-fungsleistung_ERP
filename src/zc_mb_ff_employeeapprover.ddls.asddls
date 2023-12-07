@EndUserText.label: 'EMPLOYEE APPROVER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true


define root view entity ZC_MB_FF_EMPLOYEEAPPROVER
  provider contract transactional_query 
  as projection on ZR_MB_FF_EMPLOYEE
{
    key EmployeeUuid,
    EmployeeId,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    FirstName,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Surname,
    ApproverName,
    EntryDate,
    createdBy,
    createdAt,
    lastChanged,
    lastChangedAt,
    /* Associations */
    _VacationRequests : redirected to composition child ZC_MB_FF_VACREQAPPROVER
}
