CLASS zcm_mbff_vacrequest DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF vacreq_decline,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacreq_decline.

    CONSTANTS:
      BEGIN OF vacrequest_already_declined,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'COMMENT',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_already_declined.

    CONSTANTS:
      BEGIN OF vacrequest_approve,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_approve.

    CONSTANTS:
      BEGIN OF vacrequest_already_approved,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_already_approved.

    CONSTANTS:
      BEGIN OF vacrequest_endbeforestartdate,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_endbeforestartdate.

    CONSTANTS:
      BEGIN OF vacrequest_startdateinthepast,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_startdateinthepast.

    CONSTANTS:
      BEGIN OF vacrequest_insufficientvacdays,
        msgid TYPE symsgid VALUE 'ZMBFF_VREQUEST',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_insufficientvacdays.

    DATA comment TYPE zmbff_comment.


    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        severity TYPE if_abap_behv_message=>t_severity
        !previous LIKE previous OPTIONAL
        comment TYPE zmbff_comment OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_mbff_vacrequest IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->comment = comment.
  ENDMETHOD.

ENDCLASS.
