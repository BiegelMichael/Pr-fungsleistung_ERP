@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Status'

define view entity ZI_MB_FF_STATUSTEXT
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZMBFF_STATUS')
{

      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
      @EndUserText: { label: 'Status', quickInfo: 'Status' }
      value_low as Status,
      @EndUserText: { label: 'Status Text', quickInfo: 'Status Text' }
      text      as StatusText,
      concat_with_space(text, '-',1) as StatusText2

}

where
  language = $session.system_language
