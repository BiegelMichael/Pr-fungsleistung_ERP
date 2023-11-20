@EndUserText.label: 'VACATIONREQUEST'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MB_FF_VACATIONREQUEST 
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
    /* Associations */
    _Employee : redirected to parent ZC_MB_FF_EMPLOYEE
}
