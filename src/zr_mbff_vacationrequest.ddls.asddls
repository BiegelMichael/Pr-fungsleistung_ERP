@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VACATIONREQUEST'
define view entity ZR_MBFF_VACATIONREQUEST
  as select from zmbff_vacationrq
  association to parent ZR_MB_FF_EMPLOYEE as _Employee 
  on $projection.Applicant = _Employee.EmployeeUuid 
{
      @EndUserText: { label: 'VacationRequest Uuid', quickInfo: 'VacationRequest Uuid'}
  key vacationreq_uuid as VacationreqUuid,
  @EndUserText: { label: 'Applicant Uuid', quickInfo: 'Applicant Uuid'}
      applicant        as Applicant,
      approver         as Approver,
      @EndUserText: { label: 'Start Date', quickInfo: 'Start Date'}
      start_date       as StartDate,
      @EndUserText: { label: 'End Date', quickInfo: 'End Date'}
      end_date         as EndDate,
      @EndUserText: { label: 'Comment', quickInfo: 'Comment'}
      comment_vreq     as CommentVreq,
      @EndUserText: { label: 'Status', quickInfo: 'Status'}
      status           as Status,

      /*ADMIN DATA*/
      @EndUserText: { label: 'createdBy', quickInfo: 'Created By'}
      created_by       as createdBy,
      @EndUserText: { label: 'createdAt', quickInfo: 'Created At'}
      created_at       as createdAt,
      @EndUserText: { label: 'lastChangedBy', quickInfo: 'Last Changed By'}
      last_changed_by  as lastChangedBy,
      @EndUserText: { label: 'lastChangedAt', quickInfo: 'Last Changed At'}
      last_changed_at  as lastChangedAt,

      /*ASSOCIATION*/
      _Employee // Make association public
}
