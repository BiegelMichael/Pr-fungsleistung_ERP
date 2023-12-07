CLASS lhc_vacationrequest DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.


    METHODS ApproveLeaveRequest FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~ApproveLeaveRequest RESULT result.

    METHODS DeclineVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~DeclineVacationRequest RESULT result.

    METHODS DetermineState FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineState.

    METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineVacationDays.

    METHODS ValidateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR VacationRequest~ValidateDates.

    METHODS ValidateSufficientVacationDays FOR VALIDATE ON SAVE
      IMPORTING keys FOR VacationRequest~ValidateSufficientVacationDays.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR VacationRequest RESULT result.

ENDCLASS.

CLASS lhc_vacationrequest IMPLEMENTATION.



  METHOD approveleaverequest.

   DATA message TYPE REF TO zcm_mbff_vacrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        FIELDS ( Status CommentVreq )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacationrequests).

        LOOP AT vacationrequests REFERENCE INTO DATA(vacationrequest). " foreach quasi

      " Validate State and Create Error Message
      IF vacationrequest->Status = 'D'.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            comment  = vacationrequest->CommentVreq
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
        DELETE vacationrequests INDEX sy-tabix.
      ENDIF.

      IF vacationrequest->Status = 'A'.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_already_declined
            severity = if_abap_behv_message=>severity-error
            comment  = vacationrequest->CommentVreq
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
        DELETE vacationrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

       " Set Status on Cancelled und Create Sucess Message
      vacationrequest->Status = 'A'.
      message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_approve
            severity = if_abap_behv_message=>severity-success
            comment = vacationrequest->CommentVreq
        ).
      APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
    ENDLOOP.

     " Modify Leave Request
    MODIFY ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky Status = vr-Status ) ).

    " Set Result
    result = VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky %param = vr ) ).





  ENDMETHOD.

  METHOD declinevacationrequest.

   DATA message TYPE REF TO zcm_mbff_vacrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        FIELDS ( Status CommentVreq )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacationrequests).

    " Process Leave Request
    LOOP AT vacationrequests REFERENCE INTO DATA(vacationrequest). " foreach quasi

      " Validate State and Create Error Message
      IF vacationrequest->Status = 'D'.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_already_declined
            severity = if_abap_behv_message=>severity-error
            comment  = vacationrequest->CommentVreq
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
        DELETE vacationrequests INDEX sy-tabix.
      ENDIF.

      IF vacationrequest->Status = 'A'.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            comment  = vacationrequest->CommentVreq
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
        DELETE vacationrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to D und Create Success Message
      vacationrequest->Status = 'D'.
      message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacreq_decline
            severity = if_abap_behv_message=>severity-success
            comment = vacationrequest->CommentVreq
        ).
      APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
    ENDLOOP.

    " Modify Leave Request
    MODIFY ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky Status = vr-Status ) ).

    " Set Result
    result = VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky %param = vr ) ).


  ENDMETHOD.





  METHOD determinestate.

   " Read LeaveRequests
    READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacationrequests).

    " Modify LeaveRequests
    MODIFY ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky Status = 'R' ) ).


  ENDMETHOD.

  METHOD determinevacationdays.

   READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
         FIELDS ( StartDate EndDate VacationDays )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacationrequests).

    " Process Leave Request
    LOOP AT vacationrequests REFERENCE INTO DATA(vacationrequest).
    DATA working_days TYPE int1.
    working_days = 0.
      TRY.
          DATA: start_date_extended TYPE d.
          start_date_extended = vacationrequest->StartDate - 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          working_days = calendar->calc_workingdays_between_dates( iv_start = start_date_extended iv_end = vacationrequest->EndDate ).
          vacationrequest->VacationDays = working_days.
        CATCH cx_fhc_runtime INTO DATA(exc).
      ENDTRY.
    ENDLOOP.

    " Modify Leave Requests
    MODIFY ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        UPDATE FIELDS ( VacationDays )
        WITH VALUE #( FOR vr IN vacationrequests ( %tky = vr-%tky VacationDays = vr-VacationDays ) ).
  ENDMETHOD.





  METHOD validatedates.

    DATA message TYPE REF TO zcm_mbff_vacrequest.
    DATA current_date TYPE d.
    current_date = cl_abap_context_info=>get_system_date(  ).

    " Read Leave Request
    READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        FIELDS ( StartDate EndDate CreatedAt )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacationrequests).

    " Process Leave Request
    LOOP AT vacationrequests REFERENCE INTO DATA(vacationrequest).
      " Validate Dates and Create Error Message
      IF vacationrequest->StartDate > vacationrequest->EndDate.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_endbeforestartdate
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky  %element = VALUE #( EndDate = if_abap_behv=>mk-on ) %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
      ENDIF.

      IF vacationrequest->StartDate < current_date.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_startdateinthepast
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %element = VALUE #( StartDate = if_abap_behv=>mk-on ) %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validatesufficientvacationdays.

  DATA message TYPE REF TO zcm_mbff_vacrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE zr_mbff_vacationrequest
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacationrequests).

    " Process Leave Request
    LOOP AT vacationrequests REFERENCE INTO DATA(vacationrequest).
    DATA working_days TYPE int1.
    working_days = 0.
      " Validate AvailableVacationDays and Create Error Message
      TRY.
          DATA: start_date_extended TYPE d.
          start_date_extended = vacationrequest->StartDate - 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          working_days = calendar->calc_workingdays_between_dates( iv_start = start_date_extended iv_end = vacationrequest->EndDate ).
        CATCH cx_fhc_runtime INTO DATA(exc).
      ENDTRY.
      SELECT FROM zi_mb_ff_availablevacationdays FIELDS AvailableVacationDays WHERE EmployeeUuid = @vacationrequest->Applicant INTO @DATA(availablevacationdays). ENDSELECT.
      IF availablevacationdays IS INITIAL.
        availablevacationdays = 0.
      ENDIF.
      IF availablevacationdays < working_days.
        message = NEW zcm_mbff_vacrequest(
            textid = zcm_mbff_vacrequest=>vacrequest_insufficientvacdays
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = vacationrequest->%tky %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = vacationrequest->%tky ) TO failed-vacationrequest.
        CONTINUE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_MB_FF_EMPLOYEE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.
    METHODS refresh FOR MODIFY
      IMPORTING keys FOR ACTION employee~refresh RESULT result.
    METHODS determineemployeenumber FOR DETERMINE ON MODIFY
      IMPORTING keys FOR employee~determineemployeenumber.

ENDCLASS.

CLASS lhc_ZR_MB_FF_EMPLOYEE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Refresh.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE zr_mb_ff_employee
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(employees).

    " Set Result only for refresh
    result = VALUE #( FOR e IN employees ( %tky = e-%tky %param = e ) ).

  ENDMETHOD.

  METHOD DetermineEmployeeNumber.

   " Read Employee
    READ ENTITY IN LOCAL MODE zr_mb_ff_employee
         FIELDS ( EmployeeId )
         WITH CORRESPONDING #( keys )
         RESULT DATA(employees).

    " Process Employee
    LOOP AT employees REFERENCE INTO DATA(employee).

      " Set Employee Number
      SELECT FROM zmbff_employee FIELDS MAX( employee_id ) INTO @DATA(max_employee_number).
      employee->EmployeeId = max_employee_number + 1.

    ENDLOOP.

    " Modify Employee
    MODIFY ENTITY IN LOCAL MODE zr_mb_ff_employee
           UPDATE FIELDS ( EmployeeId )
           WITH VALUE #( FOR e IN employees
                         ( %tky     = employee->%tky
                           EmployeeId = employee->EmployeeId ) ).
  ENDMETHOD.

ENDCLASS.
