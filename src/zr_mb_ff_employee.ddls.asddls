@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EMPLOYEE'
define root view entity ZR_MB_FF_EMPLOYEE
  as select from zmbff_employee
  composition [0..*] of ZR_MBFF_VACATIONREQUEST        as _VacationRequests
  composition [0..*] of ZR_MB_FF_VACENT                as _VacEnt
  association [1..1] to ZI_MB_FF_AVAILABLEVACATIONDAYS as _AvailableVD on $projection.EmployeeUuid = _AvailableVD.EmployeeUuid
  association [1..1] to ZI_MB_FF_PLANNEDVACATIONDAYS   as _PlannedVD   on $projection.EmployeeUuid = _PlannedVD.EmployeeUuid
  association [1..1] to ZI_MB_FF_CONSUMEDVACATIONDAYS  as _ConsumedVD  on $projection.EmployeeUuid = _ConsumedVD.EmployeeUuid


{
      @Semantics.uuid: true
  key employee_uuid                      as EmployeeUuid,
      employee_id                        as EmployeeId,
      first_name                         as FirstName,
      surname                            as Surname,
      @Semantics.dateTime: true
      entry_date                         as EntryDate,

      @Semantics.user.createdBy: true
      created_by                         as createdBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                         as createdAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                    as lastChanged,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                    as lastChangedAt,
      
      //Associations
      _VacationRequests,
      _VacEnt,

      // Transient Data
      _AvailableVD.AvailableVacationDays as AvailableVacationDays,
      _ConsumedVD.ConsumedVacationDays   as ConsumedVacationDays,
      _PlannedVD.PlannedVacationDays     as PlannedVacationDays,
 
      '3'                                as AvailableVDaysCriticality,
      '2'                                as PlannedVDaysCriticality,
      '1'                                as ConsumedVDaysCriticality
}
