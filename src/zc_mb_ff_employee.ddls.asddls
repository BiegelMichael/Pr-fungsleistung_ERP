@EndUserText.label: 'EMPLOYEE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_MB_FF_EMPLOYEE
  provider contract transactional_query as projection on ZR_MB_FF_EMPLOYEE
{
    key EmployeeUuid,
    EmployeeId,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    FirstName,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Surname,
    EntryDate,
    createdBy,
    createdAt, 
    lastChanged, 
    lastChangedAt,
    _VacationRequests : redirected to composition child ZC_MB_FF_VACATIONREQUEST,
    _VacEnt : redirected to composition child ZC_MB_FF_VACENT
    
   
}
