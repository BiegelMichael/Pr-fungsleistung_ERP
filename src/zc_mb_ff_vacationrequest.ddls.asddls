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
      Status,
      ApplicantFullName,
      ApproverFullName,
      createdBy,
      createdAt,
      lastChangedBy,
      lastChangedAt,
      VacationDays,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_STATUSVH', element: 'StatusDescription' }}]
      StatusDescription,
      
      
      BeginDateCriticality,
      StatusCriticality,
      


      _Employee : redirected to parent ZC_MB_FF_EMPLOYEE,
      _Approver : redirected to ZC_MB_FF_EMPLOYEE
      
      
}
