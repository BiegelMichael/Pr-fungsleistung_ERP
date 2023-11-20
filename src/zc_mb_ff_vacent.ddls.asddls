@EndUserText.label: 'ZC_VACATIONENTITLEMENT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MB_FF_VACENT
  as projection on ZR_MB_FF_VACENT
{
  key VacationUuid,
      VacYear,
      VacationDays,
      Employee,
      createdAt,
      createdBy,
      lastChangedBy,
      lastChangedAt,
      /* Associations */
      _Employee : redirected to parent ZC_MB_FF_EMPLOYEE

}
