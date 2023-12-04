@EndUserText.label: 'VACATIONREQUEST APPROVER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MB_FF_VACREQAPPROVER
  as projection on ZR_MBFF_VACATIONREQUEST
{
    key VacationreqUuid,
    Applicant,
    Approver,
    StartDate,
    EndDate,
    CommentVreq,
    Status,
    createdBy,
    createdAt,
    lastChangedBy,
    lastChangedAt,
    ApproverName,
    StatusText,
    BeginDateCriticality,
    /* Associations */
    _Approver : redirected to ZC_MB_FF_EMPLOYEEAPPROVER,
    _Employee : redirected to parent ZC_MB_FF_EMPLOYEEAPPROVER
}
