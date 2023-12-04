@EndUserText.label: 'VACATIONREQUEST'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MB_FF_VACATIONREQUEST
  as projection on ZR_MBFF_VACATIONREQUEST
{
  key VacationreqUuid,

      Applicant,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_APPROVERVH', element: 'EmployeeUuid' }}]
      Approver,
      StartDate,
      EndDate,
      CommentVreq,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_STATUSVH', element: 'Status' }}]
      Status,
      createdBy,
      createdAt,
      lastChangedBy,
      lastChangedAt,
      /* Associations */
      ApproverName,
      BeginDateCriticality,
      VacationDays,
      //StatusText,


      _Employee : redirected to parent ZC_MB_FF_EMPLOYEE,
      _Approver : redirected to ZC_MB_FF_EMPLOYEE
      
      
}
