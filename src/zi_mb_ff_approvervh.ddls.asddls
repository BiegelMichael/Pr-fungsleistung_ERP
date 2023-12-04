@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Approver'


define view entity ZI_MB_FF_APPROVERVH
  as select from zmbff_employee
{
      @UI.hidden: true
      @EndUserText: { label: 'Please select:', quickInfo: 'Bitte auswählen'}

  key employee_uuid as EmployeeUuid,
      surname       as Surname,
      first_name    as FirstName

}
