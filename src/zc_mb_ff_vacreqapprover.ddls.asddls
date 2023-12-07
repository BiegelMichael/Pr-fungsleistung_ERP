@EndUserText.label: 'VACATIONREQUEST APPROVER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZC_MB_FF_VACREQAPPROVER
  as projection on ZR_MBFF_VACATIONREQUEST
{
  key VacationreqUuid,
      Applicant,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_EMPLOYEEUUIDVH', element: 'EmployeeUuid' }}]
      Approver,
      StartDate,
      EndDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      CommentVreq,
      Status,
      ApplicantFullName,
      ApproverFullName,
      createdBy,
      createdAt,
      lastChangedBy,
      lastChangedAt,
      VacationDays,
      StatusCriticality,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MB_FF_STATUSVH', element: 'StatusDescription' }}]
      StatusDescription,
      


     
      BeginDateCriticality,
      /* Associations */
      _Approver : redirected to ZC_MB_FF_EMPLOYEEAPPROVER,
      _Employee : redirected to parent ZC_MB_FF_EMPLOYEEAPPROVER
}
