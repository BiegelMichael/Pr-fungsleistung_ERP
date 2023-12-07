@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VACATIONREQUEST'
define view entity ZR_MBFF_VACATIONREQUEST
  as select from zmbff_vacationrq
  association        to parent ZR_MB_FF_EMPLOYEE as _Employee on $projection.Applicant = _Employee.EmployeeUuid
  association [1..1] to ZR_MB_FF_EMPLOYEE        as _Approver on $projection.Approver = _Approver.EmployeeUuid
  association [1..1] to ZI_MB_FF_STATUSVH        as _StateVH on $projection.Status = _StateVH.Status and _StateVH.Language = $session.system_language
{
      @EndUserText: { label: 'VacationRequest Uuid', quickInfo: 'VacationRequest Uuid'}
  key vacationreq_uuid       as VacationreqUuid,
      @Semantics.uuid: true
      @ObjectModel.text.element: [ 'ApplicantFullName' ]
      applicant              as Applicant,
      @EndUserText: { label : 'Approver', quickInfo: 'Approver'}
      @ObjectModel.text.element: [ 'ApproverFullName' ]
      approver               as Approver,
      @Semantics.dateTime: true
      start_date             as StartDate,
      @Semantics.dateTime: true
      end_date               as EndDate,
      @EndUserText: { label: 'Comment', quickInfo: 'Comment'}
      comment_vreq           as CommentVreq,
      @EndUserText: { label: 'Status', quickInfo: 'Status'}
      status                 as Status,
      vacation_days          as VacationDays,

      /*ADMIN DATA*/
      @EndUserText: { label: 'createdBy', quickInfo: 'Created By'}
      created_by             as createdBy,
      @EndUserText: { label: 'createdAt', quickInfo: 'Created At'}
      created_at             as createdAt,
      @EndUserText: { label: 'lastChangedBy', quickInfo: 'Last Changed By'}
      last_changed_by        as lastChangedBy,
      @EndUserText: { label: 'lastChangedAt', quickInfo: 'Last Changed At'}
      last_changed_at        as lastChangedAt,



      /* Transient Data */
      _Employee.ApproverName as ApplicantFullName, // Make association public
      _Approver.ApproverName as ApproverFullName,
      _StateVH.StatusDescription as StatusDescription,


      /*ASSOCIATION*/
      _Employee,
      _Approver,




      case
      when status = 'A' then 3
      when status = 'D' then 3
      when dats_days_between($session.user_date, start_date) >= 14 then 3
      when dats_days_between($session.user_date, start_date) >= 7 then 2
      when dats_days_between($session.user_date, start_date) >= 0 then 1
      else 0
      end                    as BeginDateCriticality,

      case status when 'A' then 3
                 when 'R' then 2
                 when 'D' then 1
                 else 0
      end                    as StatusCriticality
}
