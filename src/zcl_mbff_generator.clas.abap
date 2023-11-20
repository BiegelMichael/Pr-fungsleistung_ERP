CLASS zcl_mbff_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    DATA: Hans_uuid TYPE sysuuid_x16.
    DATA: Max_uuid TYPE sysuuid_x16.


  PROTECTED SECTION.
  PRIVATE SECTION.



ENDCLASS.


CLASS zcl_mbff_generator IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    DATA Employees TYPE TABLE OF zmbff_employee.
    DATA Employee TYPE zmbff_employee.

    DATA VacationRequests TYPE TABLE OF zmbff_vacationrq.
    DATA VacationRequest TYPE zmbff_vacationrq.

    DATA VacationEntitlements TYPE TABLE OF zmbff_vacent.
    DATA VacationEntitlement TYPE zmbff_vacent.





    "Daten löschen:"

    DELETE FROM zmbff_employee.
    out->write( 'Anlegen gestartet' ).
    out->write( sy-dbcnt ).
    DELETE FROM zmbff_vacationrq.
    DELETE FROM zmbff_vacent.


    "Mitarbeiter anlegen:

    "Mitarbeiter Hans anlegen:
    employee-client = sy-mandt.
*    employee-employee_uuid = cl_system_uuid=>create_uuid_x16_static( ).
*    employee-employee_uuid = hans_uuid.
    Hans_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_uuid = Hans_uuid.
    employee-employee_id = '1'.
    employee-first_name = 'Hans'.
    employee-surname = 'Müller'.
    employee-entry_date = '20220101'.
    employee-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.
    employee-last_changed_by = 'GENERATOR'.

    APPEND employee TO employees.

*Urlaubsantrag Pegg anlegen
    vacationrequest-client = sy-mandt.
    vacationrequest-vacationreq_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    vacationrequest-approver = Hans_uuid.
    vacationrequest-start_date = '20231212'.
    vacationrequest-end_date = '20240101'.
    vacationrequest-comment_vreq = '1.Hans Gregory'.
    vacationrequest-status = 'B'.
    GET TIME STAMP FIELD vacationrequest-created_at.
    vacationrequest-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD vacationrequest-last_changed_at.
    vacationrequest-last_changed_by = 'GENERATOR'.
    vacationrequest-applicant = employee-employee_uuid.
    APPEND VacationRequest TO VacationRequests.

*vacationrequest-client = sy-mandt.
*vacationrequest-vacationreq_uuid = cl_system_uuid=>create_uuid_x16_static( ).
*"vacationrequest-applicant = '1'.
*vacationrequest-approver = '3'.
*vacationrequest-start_date = '20240202'.
*vacationrequest-end_date = '20240303'.
*vacationrequest-comment_vreq = '2.Antrag Gregory'.
*vacationrequest-status = 'B'.
*GET TIME STAMP FIELD vacationrequest-created_at.
*vacationrequest-created_by = 'GENERATOR'.
*GET TIME STAMP FIELD vacationrequest-last_changed_at.
*vacationrequest-last_changed_by = 'GENERATOR'.
*vacationrequest-applicant = employee-employee_uuid.
*APPEND VacationRequest TO vacationRequests.

*"Anspruch Pegg anlegen
*
    vacationentitlement-client = sy-mandt.
    vacationentitlement-vacation_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    vacationentitlement-employee = employee-employee_uuid.
    vacationentitlement-vacation_days = '30'.
    vacationentitlement-vac_year = '2024'.
    GET TIME STAMP FIELD vacationentitlement-created_at.
    vacationentitlement-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD vacationentitlement-last_changed_at.
    vacationentitlement-last_changed_by = 'GENERATOR'.

    APPEND VacationEntitlement TO VacationEntitlements.
**


    "Anlegen Hans

    employee-client = sy-mandt.
    Max_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_uuid = Max_uuid.
    employee-employee_id = '2'.
    employee-first_name = 'Max'.
    employee-surname = 'Mustermann'.
    employee-entry_date = '20201010'.
    employee-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.
    employee-last_changed_by = 'GENERATOR'.

    APPEND employee TO employees.
    out->write( sy-dbcnt ).



    vacationrequest-client = sy-mandt.
    vacationrequest-vacationreq_uuid = cl_system_uuid=>create_uuid_x16_static( ).
    vacationrequest-approver = Hans_uuid.
    vacationrequest-start_date = '20240204'.
    vacationrequest-end_date = '20240505'.
    vacationrequest-comment_vreq = '1.Antrag Max'.
    vacationrequest-status = 'B'.
    GET TIME STAMP FIELD vacationrequest-created_at.
    vacationrequest-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD vacationrequest-last_changed_at.
    vacationrequest-last_changed_by = 'GENERATOR'.
    vacationrequest-applicant = employee-employee_uuid.
    APPEND VacationRequest TO vacationRequests.
    out->write( sy-dbcnt ).
    out->write( 'Anlegen beendet' ).

    INSERT zmbff_employee FROM TABLE @Employees.
    INSERT zmbff_vacationrq FROM TABLE @VacationRequests.
    INSERT zmbff_vacent FROM TABLE @VacationEntitlements.


  ENDMETHOD.


ENDCLASS.
