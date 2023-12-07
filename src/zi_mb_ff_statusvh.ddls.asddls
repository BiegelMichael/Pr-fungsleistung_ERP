@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Status'
@Search.searchable: true


define view entity ZI_MB_FF_STATUSVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZMBFF_STATUS')
{
    @UI.hidden: true
  key domain_name    as DomainName,
      @UI.hidden: true
  key value_position as ValuePosition,
      @UI.hidden: true
  key language       as Language,
      @EndUserText: { label: 'State', quickInfo: 'State' }
  key value_low      as Status,
      @EndUserText: { label: 'Description', quickInfo: 'Description' }
      @Search.defaultSearchElement: true
      text           as StatusDescription

}
where
  language = $session.system_language
