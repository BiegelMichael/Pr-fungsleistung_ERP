@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VACATIONREQUEST'
define view entity ZR_MBFF_VACATIONREQUEST
  as select from zmbff_vacationrq
  association        to parent ZR_MB_FF_EMPLOYEE as _Employee     on $projection.Applicant = _Employee.EmployeeUuid
  association [1..1] to ZR_MB_FF_EMPLOYEE        as _Approver     on $projection.Approver = _Approver.EmployeeUuid
  association [1..1] to ZI_MB_FF_APPROVERTEXT    as _ApproverText on $projection.Approver = _ApproverText.EmployeeUuid
  association [0..*] to ZI_MB_FF_STATUSTEXT      as _StatusText   on $projection.Status = _StatusText.StatusText
{
      @EndUserText: { label: 'VacationRequest Uuid', quickInfo: 'VacationRequest Uuid'}
  key vacationreq_uuid       as VacationreqUuid,
      @EndUserText: { label: 'Applicant Uuid', quickInfo: 'Applicant Uuid'}
      applicant              as Applicant,
      @EndUserText: { label : 'Approver', quickInfo: 'Approver'}
      @ObjectModel.text.element: [ 'ApproverName' ]
      approver               as Approver,
      @EndUserText: { label: 'Start Date', quickInfo: 'Start Date'}
      start_date             as StartDate,
      @EndUserText: { label: 'End Date', quickInfo: 'End Date'}
      end_date               as EndDate,
      @EndUserText: { label: 'Comment', quickInfo: 'Comment'}
      comment_vreq           as CommentVreq,
      @EndUserText: { label: 'Status', quickInfo: 'Status'}
      // @ObjectModel.text.element: ['StatusText']
      status                 as Status,
      vacation_days as VacationDays,

      /*ADMIN DATA*/
      @EndUserText: { label: 'createdBy', quickInfo: 'Created By'}
      created_by             as createdBy,
      @EndUserText: { label: 'createdAt', quickInfo: 'Created At'}
      created_at             as createdAt,
      @EndUserText: { label: 'lastChangedBy', quickInfo: 'Last Changed By'}
      last_changed_by        as lastChangedBy,
      @EndUserText: { label: 'lastChangedAt', quickInfo: 'Last Changed At'}
      last_changed_at        as lastChangedAt,

      /*ASSOCIATION*/
      _Employee, // Make association public
      _Approver,
      _ApproverText.ApproverName,
      _StatusText.StatusText as StatusText,

      case
      when status = 'A' then 3
      when status = 'D' then 3
      when dats_days_between($session.user_date, start_date) >= 14 then 3
      when dats_days_between($session.user_date, start_date) >= 7 then 2
      when dats_days_between($session.user_date, start_date) >= 0 then 1
      else 0
      end                    as BeginDateCriticality
}
