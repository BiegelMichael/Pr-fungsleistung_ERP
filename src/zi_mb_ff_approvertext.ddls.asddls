
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Approver'

define view entity ZI_MB_FF_APPROVERTEXT as select from zmbff_employee
{
  // @UI.hidden: true
   key employee_uuid as EmployeeUuid,
   first_name as FirstName,
   surname as Surname,
   concat_with_space(first_name, surname,1) as ApproverName
   
 
}
