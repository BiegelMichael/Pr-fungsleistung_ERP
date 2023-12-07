@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Approver'
@Search.searchable: true


define view entity ZI_MB_FF_APPROVERVH
  as select from zmbff_employee
  association [1..1] to ZI_MB_FF_APPROVERTEXT as _ApproverTX  on $projection.EmployeeUuid = _ApproverTX.EmployeeUuid
{
      @UI.hidden: true
  key employee_uuid as EmployeeUuid,
      @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee' }
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_APPROVERTEXT', element: 'EmployeeId' } }]
      employee_id   as EmployeeId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.selectionField: [{ position: 20 }]
      @Semantics.name.givenName: true
      surname       as Surname,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.selectionField: [{ position: 30 }]
      @Semantics.name.familyName: true
      first_name    as FirstName, 
      @UI.hidden: true
      @Semantics.name.fullName: true
      _ApproverTX.ApproverName

}
