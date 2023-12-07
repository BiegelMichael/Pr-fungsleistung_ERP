@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee UUID Value Help'
@Search.searchable: true
@UI.presentationVariant: [{sortOrder: [{ by: 'EmployeeId', direction: #ASC }]}]
define view entity ZI_MB_FF_EMPLOYEEUUIDVH
  as select from zmbff_employee
{
      @UI.hidden: true
  key employee_uuid as EmployeeUuid,
      @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee' }
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_EMPLOYEEIDVH', element: 'EmployeeId' } }]
      employee_id   as EmployeeId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      first_name    as FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      surname       as Surname

}
