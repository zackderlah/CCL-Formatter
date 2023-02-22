/*************************************************************************
*                                                                        *
*  Copyright Notice:  (c) 1983 Laboratory Information Systems &          *
*                              Technology, Inc.                          *
*       Revision      (c) 1984-2019 Cerner Corporation                   *
*                                                                        *
*  Cerner (R) Proprietary Rights Notice:  All rights reserved.           *
*  This material contains the valuable properties and trade secrets of   *
*  Cerner Corporation of Kansas City, Missouri, United States of         *
*  America (Cerner), embodying substantial creative efforts and          *
*  confidential information, ideas and expressions, no part of which     *
*  may be reproduced or transmitted in any form or by any means, or      *
*  retained in any storage or retrieval system without the express       *
*  written permission of Cerner.                                         *
*                                                                        *
*  Cerner is a registered mark of Cerner Corporation.                    *
*                                                                        *
**************************************************************************

    Source file name:   sswedw_ext_pdc.prg
    Object name:        sswedw_ext_pdc
    Request #:
    Solution:           Australian Custom Development
    Program purpose:

**************************************************************************
            GENERATED MODIFICATION CONTROL LOG                 *
**************************************************************************
 Mod Date     Engineer     Feature Comment
--- -------- ------------ ------- ---------------------------------------
	21/05/19 Dave Hunt			  First Version
*************************************************************************/
drop program sswedw_ext_pdc:dba go
create program sswedw_ext_pdc:dba

prompt
	"Output to File/Printer/MINE" = "MINE"
	, "Extract Start Date:" = "CURDATE"
	, "Extract Stop Date:" = "CURDATE"
	, "Options File Name" = "CCLUSERDIR:nswedw_options.txt"

with OUTDEV, START_DATE, STOP_DATE, options_filename

/**************************************************************
; INCLUDE FILES
**************************************************************/
%i cclsource:sswedw_load_options.inc
%i cclsource:sswedw_ftp.inc
%i cclsource:sswedw_code_constants.inc
%i cclsource:sswedw_utilities.inc
%i cclsource:sswedw_ext_header.inc
;%i ccluserdir:sswedw_load_options.inc
;%i ccluserdir:sswedw_ftp.inc
;%i ccluserdir:sswedw_code_constants.inc
;%i ccluserdir:sswedw_utilities.inc
;%i ccluserdir:sswedw_ext_header.inc
/**************************************************************
; DVDev DECLARED SUBROUTINES
**************************************************************/
declare GetQualifyingMothers(null) = null
declare GetQualifyingBabies(null) = null
declare GetQualifyingDeleteData(null) = null
declare GetMotherObject(null) = null
declare GetPreviousCaesarianDetails(null) = null
declare GetHypertensionDetails(null) = null
declare GetPreviousPregnancyCount(null) = null
declare GetBabyObject(null) = null
declare GetBabyNameAddrDetails(null) = null
declare GetBabyRecordDetails(null) = null
declare GetHepBDoseFlag(null) = null
declare WriteObjToFile(null) = null
declare GetBloodLossValuesofMother(null) = null
/**************************************************************
; DVDev DECLARED VARIABLES
**************************************************************/
record mother(
	1 cnt = i4
	1 details[*]
		2 pregnancy_id = f8
		2 person_id = f8
		2 encntr_id = f8
		2 create_dt_tm = vc
		2 modified_dt_tm = vc
		2 action_type = vc
		2 perinatal_preg_record_id = vc
		2 notified_osp_id = vc
		2 previous_preg_indicator = vc
		2 previous_preg_count = vc
		2 last_birth_cs_indicator = vc
		2 previous_cs_count = vc
		2 height = vc
		2 weight = vc
		2 antenatal_est_dob = vc
		2 antenatal_care_rec_indicator = vc
		2 first_ass_preg_dur_week_cnt = vc
		2 antenatal_ser_contact_cnt = vc
		2 test_for_hiv_flag = vc
		2 pertussis_immun_flag = vc
		2 influenza_immun_flag = vc
		2 diabetes_mell_type_code = vc
		2 hypertension_chron_flag = vc
		2 hypertension_gest_flag = vc
		2 hypertension_preeclamp_flag = vc
		2 hypertension_eclamp_flag = vc
		2 hbv_surf_ant_pos_flag = vc
		2 smoke_first_half_preg_flag = vc
		2 first_half_preg_cig_count = vc
		2 smoke_second_half_preg_flag = vc
		2 second_half_preg_cig_count = vc
		2 quit_smoke_in_preg_flag = vc
		2 quit_smoke_gest_week_cnt = vc
		2 birth_plural_code = vc
		2 legal_give_name = vc
		2 legal_middle_names = vc
		2 legal_family_name = vc
		2 res_orig_address = vc
		2 res_orig_suburb_local = vc
		2 res_orig_postcode = vc
		2 res_orig_state = vc
		2 res_orig_country = vc
		2 dob = vc
		2 country_of_birth = vc
		2 indigenous_status_code = vc
		2 client_id_issuing_auth = vc
		2 client_id = vc
		2 service_encntr_rec_id = vc
		2 service_event_rec_id = vc
		2 formal_discharge_mode_code = vc
		2 formal_discharge_dt_tm = vc
		2 transfer_to_osp_id = vc
)

record babies(
	1 cnt = i4
	1 details[*]
		2 person_id = f8
		2 pregnancy_id = f8
		2 encntr_id = f8
		2 ced_dynamic_label_id = f8
		2 action_type = vc
		2 neonate_outcome_txt = vc
		2 birth_order = i4
		2 birth_record_id = vc
		2 perinatal_preg_record_id = vc
		2 create_dt_tm = vc
		2 modified_dt_tm = vc
		2 labour_onset_type_code = vc
		2 labour_ind_oxy_flag = vc
		2 labour_ind_arm_flag = vc
		2 labour_ind_pros_flag = vc
		2 labour_ind_oth_flag = vc
		2 labour_ind_main_code = vc
		2 labour_aug_oxy_flag = vc
		2 labour_aug_arm_flag = vc
		2 presentation_at_birth_code = vc
		2 labour_analg_none_flag = vc
		2 labour_analg_nito_flag = vc
		2 labour_analg_syso_flag = vc
		2 labour_analg_spin_flag = vc
		2 labour_analg_epidc_flag = vc
		2 labour_analg_cse_flag = vc
		2 labour_analg_oth_flag = vc
		2 newborn_birth_type_code = vc
		2 main_ind_csect_code = vc
		2 del_anaes_none_flag = vc
		2 del_anaes_locp_flag = vc
		2 del_anaes_pud_flag = vc
		2 del_anaes_spin_flag = vc
		2 del_anaes_epidc_flag = vc
		2 del_anaes_combse_flag = vc
		2 del_anaes_gen_flag = vc
		2 del_anaes_oth_flag = vc
		2 perineal_status_code = vc
		2 perineal_epis_ind = vc
		2 perineal_surg_rep_ind = vc
		2 perineal_third_stmt_code = vc
		2 main_mat_moc_ant_code = vc
		2 main_mat_moc_birth_code = vc
		2 postp_haem_flag = vc
		2 blood_tran_pph_flag = vc
		2 blood_loss_vol_ext_code = vc
		2 given_name = vc
		2 middle_names = vc
		2 family_name = vc
		2 gender = vc
		2 dob = vc
		2 ind_stat_code = vc
		2 birth_stat_code = vc
		2 birth_ord_code = vc
		2 birth_weight = vc
		2 est_gest_age_week_cnt = vc
		2 apgar_onemin_score = vc
		2 apgar_fivemin_score = vc
		2 resus_type_code = vc
		2 place_of_birth = vc
		2 disch_feed_breast_flag = vc
		2 disch_feed_exp_breast_milk_flag = vc
		2 disch_feed_inf_form_flag = vc
		2 disch_feed_not_app_flag = vc
		2 cong_cond_flag = vc
		2 cong_cond_desc_1 = vc
		2 cong_cond_desc_2 = vc
		2 cong_cond_desc_3 = vc
		2 cong_cond_desc_4 = vc
		2 cong_cond_desc_5 = vc
		2 cong_cond_desc_6 = vc
		2 cong_cond_desc_7 = vc
		2 cong_cond_desc_8 = vc
		2 hepb_birth_dose_flag = vc
		2 client_id_issue_auth = vc
		2 client_id = vc
		2 service_encntr_rec_id = vc
		2 service_event_rec_id = vc
		2 formal_discharge_mode_code = vc
		2 formal_discharge_dt_tm = vc
		2 transfer_to_osp_id = vc
		2 birthdttm_event = dq8
)

record cbc (
  1 begin_dt_tm = dq8
  1 end_dt_tm = dq8
  1 ds_cnt = i4
  1 ds [*]
    2 ds_type_cd = f8
    2 data_cnt = i4
    2 data [*]
      3 parent_entity_id = f8
      3 parent_entity_name = vc
      3 activity_dt_tm = dq8
      3 update_del_flag = i2
      3 cds_batch_content_id = f8
      3 person_id = f8
)

;Mothers Event Codes
declare HEIGHT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!9516")), protect
declare WEIGHT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!10108")), protect
declare ANTCAREREC_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_ANTENATAL_CARE_RECEIVED_PDC")), protect
declare DURPREG1STVISIT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_DURATION_OF_PREGNANCY_AT_FIRST_VISIT")), protect
declare NUMOFANTVISITS_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_NUMBER_OF_ANTENATAL_VISITS")), protect
declare HIVFLAG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_HIV_TEST")), protect
declare BOOTADMIN_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_BOOSTRIX_ADMIN")), protect
declare FLUVAXADMIN_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_FLU_ADMIN")), protect
declare MATDIABTYPE_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_MATERNITY_DIABETES_TYPE")), protect
declare SMOKINGDURPREG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_SMOKING_DURING_PREGNANCY")), protect
declare CIGCOUNT1STHFPREG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_CIGARETTES_SMOKED_IN_FIRST_HALF_PREG")), protect
declare SMOKINGDUR2NDHFPREG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_SMOKING_DURING_PREGNANCY_2ND_HALF")), protect
declare CIGCOUNT2NDHFPREG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_CIGARETTES_SMOKED_IN_SECOND_HALF_PREG")), protect
declare QUITSMOKEDURPREG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_MOTHER_QUIT_SMOKING_DURING_PREGNANCY")), protect
declare GESTWEEKQUITSMOKE_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72,"GESTATIONWEEKMOTHERQUITSMOKING")), protect
declare PLURALITY_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_PLURALITY")), protect
declare ANTPROBPDC16_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!8096")), protect
declare EXTRHPBRES_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_EXT_HEPATITIS_B_RESULT")), protect
declare HEPBSURFANT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_HEPB")), protect
declare LIVEBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!12610722")), protect
declare NEONDEATH_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!12610724")), protect
declare FETALDEMSTILL_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!12610723")), protect
declare CANCELLED_PROB_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!3468")), protect

;Babies Event Codes
declare ONSETOFLAB_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_ONSET_OF_LABOUR")), protect
declare ONSETOFLABMETH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_INDUCTION_OF_LABOUR_METHOD")), protect
declare MAININDFORDINDUCT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_MAIN_IND_FOR_INDUCTION")), protect
declare AUGMENTMETH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_AUGMENTATION_METHOD")), protect
declare PRESENTATDEL_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_PRESENTATION_AT_DELIVERY")), protect
declare ANALGINLAB_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_ANALGESIA_IN_LABOUR")), protect
declare MAININDCSECTION_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_MAIN_INDICATION_FOR_CAESAREAN_SECTION")), protect
declare ANAEDURBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_ANAESTHESIA_DURING_BIRTH")), protect
declare PERSTATUSPCM_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_GEN_TRACT_TRAUMA")), protect
declare REPPERINORVAG_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_REPAIR_OF_THE_PERINEUM_OR_VAGINA")), protect
declare PLACDELMETH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_PLACENTA_DELIVERY_METHOD")), protect
declare MAINMODOFANTCARE_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_WOMANS_MODEL_OF_CARE")), protect
declare MAINMODOFCAREBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_MOC_AT_BIRTH")), protect
declare POSTHAEMTYPE_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_POSTPARTUM_HAEMORRHAGETYPE")), protect
declare BLOODTRANSADMIN_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_BLOOD_TRANSFUSION_ADMINISTERED")), protect
declare NEONATEOUT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_NEONATE_OUTCOME")), protect
declare BIRTHORD_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72, "BIRTHORDER")), protect
declare BIRTHWEIGHT_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_BIRTH_WEIGHT")), protect
declare APGARSC1MIN_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72, "APGARSCORE1MINUTE")), protect
declare APGARSC5MIN_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72, "APGARSCORE5MINUTE")), protect
declare RESUSATBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_RESUSCITATION_AT_BIRTH")), protect
declare PLACEOFDEL_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_PLACE_OF_DELIVERY")), protect
declare FEEDATDISCH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_NEONATAL_FEEDING_AT_DISCHARGE")), protect
declare CONGENABNOR_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_CONGENITAL_ABNORMALITY")), protect
declare HEPBVACGIVEN_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_HEP_B_IMMUNIZ_GIVEN_BABY")), protect
declare BIRTHDTTM_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_BIRTHDATETIME")), protect
declare BIRTHINGEBL_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72, "BIRTHINGEBL")), protect
declare POSTNATALEBL_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_POSTNATAL_EBL")), protect
declare BABYBIRTHDTTM_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_BIRTH_DATE_TIME")), protect
declare EGAATBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!9500")), protect
declare BABYBIRTHORD_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 72, "WCBIRTHORDER")), protect
declare MODEOFBIRTH_CD = f8 with constant(uar_get_code_by_cki("CKI.EC!AU_DELIVERY_TYPE")), protect
declare NUMEVT_CLASS_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!2694")), protect

declare IVOXYTOCIN_TXT = vc with constant("IV OXYTOCIN"), protect
declare ARTRUPTMEM_TXT = vc with constant("ARTIFICIAL RUPTURE OF MEMBRANES"), protect
declare VAGPROST_TXT = vc with constant("VAGINAL PROSTAGLANDIN"), protect
declare CERVRIPENDEV_TXT = vc with constant("CERVICAL RIPENING DEVICE"), protect
declare OTHER_TXT = vc with constant("OTHER"), protect
declare NONE_TXT = vc with constant("NONE"), protect
declare NITOXID_TXT = vc with constant("NITROUS OXIDE"), protect
declare SYSOPI_TXT = vc with constant("SYSTEMIC OPIOIDS"), protect
declare SPINAL_TXT = vc with constant("SPINAL"), protect
declare EPIDURAL_TXT = vc with constant("EPIDURAL"), protect
declare CAUDAL_TXT = vc with constant("CAUDAL"), protect
declare COMBSPEPD_TXT = vc with constant("COMBINED SPINAL/EPIDURAL"), protect
declare LOCANAESTOPER_TXT = vc  with constant("LOCAL ANAESTHETIC TO PERINEUM"), protect
declare PUDENDAL_TXT = vc  with constant("PUDENDAL"), protect
declare GENERAL_TXT = vc  with constant("GENERAL"), protect
declare EPISIOTOMY_TXT = vc with constant("EPISIOTOMY"), protect
declare HEPBPAEDVAC_TXT = vc with constant("HEPATITIS B PAEDIATRIC VACCINE"), protect
declare HDPCHRONHYP_TXT = vc with constant("HDP-CHRONIC HYPERTENSION"), protect
declare HDPGESTHYP_TXT = vc with constant("HDP-GESTATIONAL HYPERTENSION"), protect
declare HDPPREECLHYP_TXT = vc with constant("HDP-PRE-ECLAMPSIA"), protect
declare HDPECLHYP_TXT = vc with constant("HDP-ECLAMPSIA"), protect
declare BFONLY_TXT = vc with constant("BREASTFEEDING ONLY"), protect
declare BFEXPBM_TXT = vc with constant("BREASTFEEDING AND EXPRESSED BREASTMILK"), protect
declare BFEXPBMFM_TXT = vc with constant("BREASTFEEDING AND EXPRESSED BREASTMILK AND FORMULA"), protect
declare BFFORM_TXT = vc with constant("BREASTFEEDING AND FORMULA"), protect
declare EXPBM_TXT = vc with constant("EXPRESSED BREASTMILK"), protect
declare EXPBMFORM_TXT = vc with constant("EXPRESSED BREASTMILK AND FORMULA"), protect
declare HUMDNMK_TXT = vc with constant("HUMAN DONOR MILK"), protect
declare FORMONLY_TXT = vc with constant("FORMULA ONLY"), protect
declare NIL_TXT = vc with constant("NIL"), protect
declare NOTKNOWN_TXT = vc with constant("NOT KNOWN"), protect
declare NOTAPP_TXT = vc with constant("NOT APPLICABLE"), protect
declare PRIMARY_TXT = vc with constant("PRIMARY"), protect
declare STILLBORN_TXT = vc with constant("STILLBIRTH"), protect
declare NEONATEDEATH_TXT = vc with constant("NEONATAL DEATH"), protect

declare CSECTION_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!12610746")), protect
declare CSECTION_CLASS_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!12610763")), protect
declare CSECTIONJ_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!4100275822")), protect
declare CSECTION_LOWTRANS_CD = f8 with constant(uar_get_code_by("DISPLAYKEY", 4002119, "CAESAREANSECTIONLOWTRANSVERSE")), protect
declare CSECTION_OTH_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!4100275826")), protect
declare UNKNOWN_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!4101286982")), protect
declare INERROR_CD = f8 with protect,constant(uar_get_code_by("MEANING",8,"IN ERROR"))
declare INERROR2_CD = f8 with protect,constant(uar_get_code_by("MEANING",8,"INERRNOMUT"))
declare INERROR3_CD = f8 with protect,constant(uar_get_code_by("MEANING",8,"INERRNOVIEW"))
declare INERROR4_CD = f8 with protect,constant(uar_get_code_by("MEANING",8,"INERROR"))
declare NOT_DONE_CD = f8 with protect,constant(uar_get_code_by("MEANING",8,"NOT DONE"))

declare EAMRN_CD = f8 with constant(uar_get_code_by("MEANING",319,"MRN")),protect
declare VISITID_CD = f8 with constant(uar_get_code_by("MEANING", 319, "VISITID")), protect
declare NSWEDW_SV = f8 with constant(uar_get_code_by("DISPLAYKEY", 400, "NSWEDWPDC")), protect
declare RELTNCHILD_CD = f8 with constant(uar_get_code_by("DISPLAY_KEY",40,"CHILD")), protect
declare PDC_CONTAINER = f8 with constant(uar_get_code_by("MEANING", 4001896, "NSWEDW36")), protect
declare HOMEADDR_CD = f8 with constant(uar_get_code_by_cki("CKI.CODEVALUE!4018")), protect
declare HOSPTRANSFERTO_CD = f8 with constant(uar_get_code_by("MEANING", 356,"REF_TO_FACIL")), protect

declare ext_filename = vc with protect
declare extract_start_dt_tm = dq8 with protect
declare extract_end_dt_tm = dq8 with protect
declare start_updtchk_dt_tm = dq8 with protect
declare num = i4 with protect
declare num2 = i4 with protect
declare stat = i4 with protect
declare batch_seq = vc with protect
/**************************************************************
; DVDev Start Coding
**************************************************************/
set extract_start_dt_tm = cnvtdatetime(build2($start_date, '00:00'))
set extract_end_dt_tm = cnvtdatetime(build2($stop_date, '23:59:59'))
set bulk_load_flag = 1
set cbc->begin_dt_tm = cnvtdatetime(extract_start_dt_tm)
set cbc->end_dt_tm = cnvtdatetime(extract_end_dt_tm)

call GetQualifyingMothers(null)
call GetQualifyingBabies(null)
call GetQualifyingDeleteData(null)
call initialise_header(null)
call GetMotherObject(null)
call GetPreviousCaesarianDetails(null)
call GetHypertensionDetails(null)
call GetPreviousPregnancyCount(null)

call GetBabyObject(null)
call GetBabyNameAddrDetails(null)
call GetBabyRecordDetails(null)
call GetBloodLossValuesofMother(null)
call GetHepBDoseFlag(null)
call WriteObjToFile(null)

;call echoxml(babies, '1_dh_babytest.xml')

;//"name": "keyword.other.DML.ccl"

/**************************************************************
; DVDev DEFINED SUBROUTINES
**************************************************************/
/**************************************************************
Name:		GetQualifyingMothers
params: 	n/a
Returns:
Purpose:	Find out which mothers qualify for the extract
**************************************************************/
subroutine GetQualifyingMothers(null)
	select into "nl:"
	from pregnancy_instance pi
		,clinical_event ce
		,ce_date_result cdr
		,encntr_alias ea
	plan pi where pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
	join ce where ce.person_id = pi.person_id
			and ce.event_cd = BIRTHDTTM_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join cdr where cdr.event_id = ce.event_id
			 and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
			 and cdr.result_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
	join ea where ea.encntr_id = ce.encntr_id
			and ea.active_ind = 1
			and ea.encntr_alias_type_cd = EAMRN_CD
	order by pi.pregnancy_id
	head report
		cnt = 0
		stat = alterlist(mother->details, cnt + 100)
	head pi.pregnancy_id
		if(cdr.result_dt_tm > pi.preg_start_dt_tm and cdr.result_dt_tm < pi.preg_end_dt_tm)
			cnt = cnt + 1
			if(mod(cnt, 100) = 1)
				stat = alterlist(mother->details, cnt + 99)
			endif
			mother->details[cnt].pregnancy_id = pi.pregnancy_id
			mother->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
			mother->details[cnt].client_id = trim(ea.alias, 3)
			mother->details[cnt].action_type = "I"
		endif
	foot report
		mother->cnt = cnt
		stat = alterlist(mother->details, cnt)
	with nocounter

	select into "nl:"
	from pregnancy_instance pi
		,encounter e
		,clinical_event ce
		,encntr_alias ea
	plan pi where not expand(num, 1, mother->cnt, pi.pregnancy_id, mother->details[num].pregnancy_id)
			and pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
			and exists (select 1
						from clinical_event ce1
                			,ce_date_result cdr
						where ce1.event_cd = BIRTHDTTM_CD
						and ce1.person_id = pi.person_id
						and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
            			and cdr.event_id = ce1.event_id
    			  		and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
    			  		and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm)
	join e where e.person_id = pi.person_id
			and nullval(e.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e.encntr_id
			and ce.event_cd in (HEIGHT_CD, WEIGHT_CD, ANTCAREREC_CD, DURPREG1STVISIT_CD,
								NUMOFANTVISITS_CD, HIVFLAG_CD, BOOTADMIN_CD, FLUVAXADMIN_CD, MATDIABTYPE_CD,
								SMOKINGDURPREG_CD, CIGCOUNT1STHFPREG_CD, SMOKINGDUR2NDHFPREG_CD, CIGCOUNT2NDHFPREG_CD,
								QUITSMOKEDURPREG_CD, GESTWEEKQUITSMOKE_CD, PLURALITY_CD, ANTPROBPDC16_CD)
			and ce.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ea where ea.encntr_id = ce.encntr_id
			and ea.active_ind = 1
			and ea.encntr_alias_type_cd = EAMRN_CD
	order by pi.pregnancy_id
	head report
		cnt = mother->cnt
		stat = alterlist(mother->details, cnt + 100)
	head pi.pregnancy_id
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(mother->details, cnt + 99)
		endif
		mother->details[cnt].pregnancy_id = pi.pregnancy_id
		mother->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		mother->details[cnt].client_id = trim(ea.alias, 3)
		mother->details[cnt].action_type = "I"
	foot report
		mother->cnt = cnt
		stat = alterlist(mother->details, cnt)
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetQualifyingBabies
params: 	n/a
Returns:
Purpose:	Find out which babies qualify for the extract
**************************************************************/
subroutine GetQualifyingBabies(null)
	; Check if birth recorded during extract window
	select into "nl:"
	from pregnancy_instance pi
		,clinical_event ce
		,ce_date_result cdr
	plan pi where pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
	join ce where ce.person_id = pi.person_id
			and ce.event_cd = BIRTHDTTM_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join cdr where cdr.event_id = ce.event_id
			 and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
			 and cdr.result_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
	order by ce.ce_dynamic_label_id
	head report
		cnt = 0
		stat = alterlist(babies->details, cnt + 100)
	head ce.ce_dynamic_label_id
		if(cdr.result_dt_tm > pi.preg_start_dt_tm and cdr.result_dt_tm < pi.preg_end_dt_tm)
			cnt = cnt + 1
			if(mod(cnt, 100) = 1)
				stat = alterlist(babies->details, cnt + 99)
			endif
			babies->details[cnt].pregnancy_id = pi.pregnancy_id
			babies->details[cnt].ced_dynamic_label_id = ce.ce_dynamic_label_id
			babies->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
			babies->details[cnt].action_type = "I"
		endif
	foot report
		babies->cnt = cnt
		stat = alterlist(babies->details, cnt)
	with nocounter

 	;Check if any of the mother level baby values have been modified
	select into "nl:"
	from pregnancy_instance pi
		,encounter e
		,clinical_event ce
	plan pi where not expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
			and pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
			and exists (select 1
						from clinical_event ce1
                			,ce_date_result cdr
						where ce1.event_cd = BIRTHDTTM_CD
						and ce1.person_id = pi.person_id
						and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
            			and cdr.event_id = ce1.event_id
    			  		and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
    			  		and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm)
	join e where e.person_id = pi.person_id
			and nullval(e.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e.encntr_id
			and ce.event_cd in (ONSETOFLAB_CD, ONSETOFLABMETH_CD, MAININDFORDINDUCT_CD, AUGMENTMETH_CD
								,PRESENTATDEL_CD, ANALGINLAB_CD, MAININDCSECTION_CD, ANAEDURBIRTH_CD
								,PLACDELMETH_CD,NEONATEOUT_CD, BIRTHORD_CD, BIRTHWEIGHT_CD, APGARSC1MIN_CD, APGARSC5MIN_CD
								,RESUSATBIRTH_CD, PLACEOFDEL_CD, CONGENABNOR_CD, BIRTHDTTM_CD, MODEOFBIRTH_CD)
			and ce.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	order by ce.ce_dynamic_label_id
	head report
		cnt = babies->cnt
		stat = alterlist(babies->details, cnt + 100)
	head ce.ce_dynamic_label_id
		call echo("Second qualifier")
		call echo(pi.pregnancy_id)
		call echo(ce.ce_dynamic_label_id)
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(babies->details, cnt + 99)
		endif
		babies->details[cnt].pregnancy_id = pi.pregnancy_id
		babies->details[cnt].ced_dynamic_label_id = ce.ce_dynamic_label_id
		babies->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		babies->details[cnt].action_type = "I"
	foot report
		babies->cnt = cnt
		stat = alterlist(babies->details, cnt)
	with nocounter, expand = 1

	;Check if any of the mother values related to all babies have been modified
	select into "nl:"
	from pregnancy_instance pi
		,encounter e
		,clinical_event ce
		,clinical_event ce_mum_birthord
	plan pi where not expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
			and pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
			and exists (select 1
						from clinical_event ce1
                			,ce_date_result cdr
						where ce1.event_cd = BIRTHDTTM_CD
						and ce1.person_id = pi.person_id
						and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
            			and cdr.event_id = ce1.event_id
    			  		and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
    			  		and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm)
	join e where e.person_id = pi.person_id
			and nullval(e.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e.encntr_id
			and ce.event_cd in (PERSTATUSPCM_CD, REPPERINORVAG_CD, MAINMODOFANTCARE_CD ,MAINMODOFCAREBIRTH_CD)
			and ce.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ce_mum_birthord where ce_mum_birthord.encntr_id = e.encntr_id
						and ce_mum_birthord.event_cd = BIRTHORD_CD
						and ce_mum_birthord.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce_mum_birthord.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	order by ce_mum_birthord.ce_dynamic_label_id
	head report
		cnt = babies->cnt
		stat = alterlist(babies->details, cnt + 100)
	head ce_mum_birthord.ce_dynamic_label_id
		call echo("Third qualifier")
		call echo(pi.pregnancy_id)
		call echo(ce.ce_dynamic_label_id)
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(babies->details, cnt + 99)
		endif
		babies->details[cnt].pregnancy_id = pi.pregnancy_id
		babies->details[cnt].ced_dynamic_label_id = ce_mum_birthord.ce_dynamic_label_id
		babies->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		babies->details[cnt].action_type = "I"
	foot report
		babies->cnt = cnt
		stat = alterlist(babies->details, cnt)
	with nocounter, expand = 1

 	;Check if any baby level values have been modified
	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,encounter e
		,clinical_event ce
		,clinical_event ce_baby_birthord
		,encounter e_mum
		,clinical_event ce_mum_birthord
	plan pi where not expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
			and pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 1
			and exists (select 1
						from clinical_event ce1
                			,ce_date_result cdr
						where ce1.event_cd = BIRTHDTTM_CD
						and ce1.person_id = pi.person_id
						and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
            			and cdr.event_id = ce1.event_id
    			  		and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
    			  		and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm)
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join e where e.person_id = ppr.related_person_id
			and nullval(e.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e.encntr_id
			and ce.event_cd in (EGAATBIRTH_CD, FEEDATDISCH_CD, CONGENABNOR_CD
								,POSTHAEMTYPE_CD, BIRTHINGEBL_CD, POSTNATALEBL_CD, BLOODTRANSADMIN_CD)
			and ce.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ce_baby_birthord where ce_baby_birthord.encntr_id = ppr.related_person_id
						and ce_baby_birthord.event_cd = BABYBIRTHORD_CD
						and ce_baby_birthord.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce_baby_birthord.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join e_mum where e_mum.person_id = pi.person_id
			and nullval(e_mum.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e_mum.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce_mum_birthord where ce_mum_birthord.encntr_id = e_mum.encntr_id
						and ce_mum_birthord.event_cd = BIRTHORD_CD
						and ce_mum_birthord.result_val = ce_baby_birthord.result_val
						and ce_mum_birthord.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce_mum_birthord.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	order by ce_mum_birthord.ce_dynamic_label_id
	head report
		cnt = babies->cnt
		stat = alterlist(babies->details, cnt + 100)
	head ce_mum_birthord.ce_dynamic_label_id
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(babies->details, cnt + 99)
		endif
		babies->details[cnt].pregnancy_id = pi.pregnancy_id
		babies->details[cnt].ced_dynamic_label_id = ce_mum_birthord.ce_dynamic_label_id
		babies->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		babies->details[cnt].action_type = "I"
	foot report
		babies->cnt = cnt
		stat = alterlist(babies->details, cnt)
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetQualifyingDeleteData
params: 	n/a
Returns:
Purpose:	Find out which records should be sent as a delete
**************************************************************/
subroutine GetQualifyingDeleteData(null)
	;Check for mother being deleted
	select into "nl:"
	from pregnancy_instance pi
		,problem p
		,clinical_event ce
    	,ce_date_result cdr
		,encntr_alias ea
	plan pi where pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 0
			and pi.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and not exists(select 1
							from pregnancy_instance pi2
							where pi2.pregnancy_id = pi.pregnancy_id
							and pi2.historical_ind = 0
							and pi2.active_ind = 1)
	join p where p.problem_id = pi.problem_id
			and p.active_ind = 1
			and p.life_cycle_status_cd = CANCELLED_PROB_CD
	join ce where ce.person_id = pi.person_id
			and ce.event_cd = BIRTHDTTM_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
  	join cdr where cdr.event_id = ce.event_id
			 and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
			 and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
	join ea where ea.encntr_id = ce.encntr_id
			and ea.active_ind = 1
			and ea.encntr_alias_type_cd = EAMRN_CD
	order by pi.pregnancy_id
	head report
		cnt = mother->cnt
		stat = alterlist(mother->details, cnt + 100)
	head pi.pregnancy_id
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(mother->details, cnt + 99)
		endif
		mother->details[cnt].pregnancy_id = pi.pregnancy_id
		mother->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		mother->details[cnt].client_id = trim(ea.alias, 3)
		mother->details[cnt].action_type = "D"
	foot report
		mother->cnt = cnt
		stat = alterlist(mother->details, cnt)
	with nocounter

	;Check for baby being deleted
	select into "nl:"
	from pregnancy_instance pi
		,problem p
		,clinical_event ce
    	,ce_date_result cdr
	plan pi where pi.pregnancy_id != 0
			and pi.historical_ind = 0
			and pi.active_ind = 0
			and pi.updt_dt_tm between cnvtdatetime(extract_start_dt_tm) and cnvtdatetime(extract_end_dt_tm)
			and not exists(select 1
							from pregnancy_instance pi2
							where pi2.pregnancy_id = pi.pregnancy_id
							and pi2.historical_ind = 0
							and pi2.active_ind = 1)
	join p where p.problem_id = pi.problem_id
			and p.active_ind = 1
			and p.life_cycle_status_cd = CANCELLED_PROB_CD
	join ce where ce.person_id = pi.person_id
			and ce.event_cd = BIRTHDTTM_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
  	join cdr where cdr.event_id = ce.event_id
			 and cdr.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
			 and cdr.result_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
	order by ce.ce_dynamic_label_id
	head report
		cnt = babies->cnt
		stat = alterlist(babies->details, cnt + 100)
	head ce.ce_dynamic_label_id
		call echo("First qualifier")
		call echo(pi.pregnancy_id)
		call echo(ce.ce_dynamic_label_id)
		cnt = cnt + 1
		if(mod(cnt, 100) = 1)
			stat = alterlist(babies->details, cnt + 99)
		endif
		babies->details[cnt].pregnancy_id = pi.pregnancy_id
		babies->details[cnt].ced_dynamic_label_id = ce.ce_dynamic_label_id
		babies->details[cnt].perinatal_preg_record_id = cnvtstring(cnvtint(pi.pregnancy_id))
		babies->details[cnt].action_type = "D"
	foot report
		babies->cnt = cnt
		stat = alterlist(babies->details, cnt)
	with nocounter
end
/**************************************************************
Name:		GetMotherObject
params: 	n/a
Returns:
Purpose:	Get mother details
**************************************************************/
subroutine GetMotherObject(null)
	select into "nl:"
	from pregnancy_instance pi
		,pregnancy_estimate pe
		,encounter e
		,encounter e2
		,clinical_event ce
		,code_value_outbound cvo_fac
		,person p
		,address a
		,encntr_alias ea
		,code_value_outbound cvo_issue
		,encntr_alias ea_visit
		,code_value_outbound cvo_disch
		,service_category_hist svc
		,encntr_info ei
		,code_value_outbound cvo_reffac
		,ce_coded_result ccr
		,nomenclature_outbound nomo
		,code_value_outbound cvo_cob
		,code_value_outbound cvo_adc
		,code_value_outbound cvo_ind
		,code_value_outbound cvo_state
	plan pi where expand(num, 1, mother->cnt, pi.pregnancy_id, mother->details[num].pregnancy_id)
					and pi.active_ind = 1
	join pe where pe.pregnancy_id = pi.pregnancy_id
			and pe.active_ind = 1
			and pe.pregnancy_id > 0
	join e where e.encntr_id = (select ce1.encntr_id
                              from clinical_event ce1
                              where ce1.event_cd = BIRTHDTTM_CD
                              and ce1.person_id = pi.person_id
                              and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
                              and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD))
			and e.encntr_type_cd = INPATIENT_CD
			and nullval(e.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join cvo_fac where cvo_fac.code_value = e.loc_facility_cd
				and cvo_fac.code_set = 220
				and cvo_fac.alias_type_meaning = "FACILITY"
				and cvo_fac.contributor_source_cd = NSWEDW_CS
	join e2 where e2.person_id = pi.person_id
			and nullval(e2.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e2.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e2.encntr_id
			and ce.event_cd in (HEIGHT_CD, WEIGHT_CD, ANTCAREREC_CD, DURPREG1STVISIT_CD,
								NUMOFANTVISITS_CD, HIVFLAG_CD, BOOTADMIN_CD, FLUVAXADMIN_CD, MATDIABTYPE_CD,
								SMOKINGDURPREG_CD, CIGCOUNT1STHFPREG_CD, SMOKINGDUR2NDHFPREG_CD, CIGCOUNT2NDHFPREG_CD,
								QUITSMOKEDURPREG_CD, GESTWEEKQUITSMOKE_CD, PLURALITY_CD, ANTPROBPDC16_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.task_assay_cd != 0
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join p where p.person_id = pi.person_id
	join a where a.parent_entity_id = outerjoin(p.person_id)
			and a.active_ind = outerjoin(1)
			and a.address_type_cd = outerjoin(HOMEADDR_CD)
	join ea where ea.encntr_id = e.encntr_id
			and ea.active_ind = 1
			and ea.encntr_alias_type_cd = EAMRN_CD
	join cvo_issue where cvo_issue.code_value = ea.alias_pool_cd
					and cvo_issue.code_set = 263
					and cvo_issue.contributor_source_cd = NSWEDW_CS
	join ea_visit where ea_visit.encntr_id = e.encntr_id
					and ea_visit.active_ind = 1
					and ea_visit.encntr_alias_type_cd = VISITID_CD
	join cvo_disch where cvo_disch.code_value = outerjoin(e.disch_disposition_cd)
					and cvo_disch.code_set = outerjoin(19)
					and cvo_disch.contributor_source_cd = outerjoin(NSWEDW_CS)
	join svc where svc.encntr_id = e.encntr_id
				and svc.active_ind = 1
	join ei where ei.encntr_id = outerjoin(e.encntr_id)
			and ei.active_ind = outerjoin(1)
			and ei.info_sub_type_cd = outerjoin(HOSPTRANSFERTO_CD)
	join cvo_reffac where cvo_reffac.code_value = outerjoin(ei.value_cd)
					and cvo_reffac.code_set = outerjoin(18889)
					and cvo_reffac.contributor_source_cd = outerjoin(NSWEDW_CS)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
				and ccr.valid_until_dt_tm > outerjoin(cnvtdatetime(curdate,curtime3))
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	join cvo_cob where cvo_cob.code_value = p.nationality_cd
					and cvo_cob.code_set = 14652
					and cvo_cob.contributor_source_cd = NSWEDW_CS
	join cvo_adc where cvo_adc.code_value = outerjoin(a.country_cd)
					and cvo_adc.code_set = outerjoin(15)
					and cvo_adc.contributor_source_cd = outerjoin(NSWEDW_CS)
	join cvo_ind where cvo_ind.code_value = p.race_cd
					and cvo_ind.code_set = 282
					and cvo_ind.contributor_source_cd = NSWEDW_CS
	join cvo_state where cvo_state.code_value = outerjoin(a.state_cd)
					and cvo_state.code_set = outerjoin(62)
					and cvo_state.contributor_source_cd = outerjoin(NSWEDW_CS)
	order by pi.preg_start_dt_tm desc,
			 pi.pregnancy_id,
			 ce.event_cd,
			 ce.event_end_dt_tm desc,
			 pe.pregnancy_estimate_id desc
	head pi.pregnancy_id
		pos = locateval(num, 1, mother->cnt, pi.pregnancy_id, mother->details[num].pregnancy_id)
		if(pos > 0)
			mother->details[pos].person_id = pi.person_id
			mother->details[pos].create_dt_tm = format(e.beg_effective_dt_tm, 'yyyy-mm-dd hh:mm:ss;;q')
			mother->details[pos].modified_dt_tm = format(extract_end_dt_tm, 'yyyy-mm-dd hh:mm:ss;;q')
			mother->details[pos].perinatal_preg_record_id = trim(cnvtstring(cnvtint(pi.pregnancy_id)))
			mother->details[pos].notified_osp_id = substring(1, 7, trim(cvo_fac.alias, 3))
			mother->details[pos].last_birth_cs_indicator = "0"
			mother->details[pos].legal_give_name = p.name_first
			mother->details[pos].legal_middle_names = p.name_middle
			mother->details[pos].legal_family_name = p.name_last
			if(textlen(trim(a.street_addr2, 3)) > 0)
				mother->details[pos].res_orig_address = build2(trim(a.street_addr,3), ", ", trim(a.street_addr2, 3))
			else
				mother->details[pos].res_orig_address = trim(a.street_addr,3)
			endif
			mother->details[pos].res_orig_postcode = a.zipcode
			mother->details[pos].res_orig_state = trim(cvo_state.alias, 3)
			mother->details[pos].res_orig_suburb_local = a.city
			mother->details[pos].res_orig_country = trim(cvo_adc.alias, 3)
			mother->details[pos].dob = format(cnvtdatetime(p.birth_dt_tm), 'yyyymmdd;;q')
			mother->details[pos].country_of_birth = trim(cvo_cob.alias, 3)
			mother->details[pos].indigenous_status_code = trim(cvo_ind.alias, 3)
			mother->details[pos].client_id_issuing_auth = trim(substring(1,10,cvo_issue.alias))
			mother->details[pos].client_id = trim(ea.alias, 3)
			mother->details[pos].service_encntr_rec_id = build2(trim(substring(1,10,cvo_issue.alias)), "-"
															, trim(ea_visit.alias, 3))
			mother->details[pos].formal_discharge_dt_tm = format(e.disch_dt_tm ,"yyyy-mm-dd hh:mm:ss;;q" )
			mother->details[pos].formal_discharge_mode_code = trim(substring(1,2,cvo_disch.alias), 3)
			mother->details[pos].transfer_to_osp_id = trim(cvo_reffac.alias, 3)
			mother->details[pos].service_event_rec_id = cnvtstring(svc.svc_cat_hist_id)
			mother->details[pos].antenatal_est_dob = format(cnvtdatetime(pe.est_delivery_dt_tm), 'YYYYMMDD;;q')

			; Set the below to zero as we will look for values later to set to 1. Must have a value populated
			; Either way.
			mother->details[pos].hypertension_chron_flag = "0"
			mother->details[pos].hypertension_gest_flag = "0"
			mother->details[pos].hypertension_preeclamp_flag = "0"
			mother->details[pos].hypertension_eclamp_flag = "0"
			mother->details[pos].previous_preg_indicator = "0"
			call echo("Person")
			call echo(pi.person_id)
		endif
	head ce.event_cd
		if(pos > 0)
			call echo(ce.event_cd)
			call echo(uar_get_code_display(ce.event_cd))
			result_trim = trim(ce.result_val, 3)
			result_upper = cnvtupper(result_trim)
			nom_alias = trim(nomo.alias, 3)
			;Check whether alias found should be split up or not.
			if(findstring(";", nom_alias) > 0)
				find_pos = findstring(";", nom_alias)
				first_alias = substring(1, find_pos - 1, nom_alias)
				second_alias = substring(find_pos + 1, size(nom_alias), nom_alias)
			else
				first_alias = nom_alias
			endif
	 		call echo(result_upper)
			case(ce.event_cd)
				of HEIGHT_CD:
					mother->details[pos].height = result_trim
				of WEIGHT_CD:
					mother->details[pos].weight = result_trim
				of ANTCAREREC_CD:
					mother->details[pos].antenatal_care_rec_indicator = first_alias
				of HIVFLAG_CD:
					mother->details[pos].test_for_hiv_flag = first_alias
				of SMOKINGDURPREG_CD:
					mother->details[pos].smoke_first_half_preg_flag = first_alias
				of SMOKINGDUR2NDHFPREG_CD:
					mother->details[pos].smoke_second_half_preg_flag = first_alias
				of QUITSMOKEDURPREG_CD:
					mother->details[pos].quit_smoke_in_preg_flag = first_alias
				of BOOTADMIN_CD:
					mother->details[pos].pertussis_immun_flag = first_alias
				of FLUVAXADMIN_CD:
					mother->details[pos].influenza_immun_flag = first_alias
				of MATDIABTYPE_CD:
					mother->details[pos].diabetes_mell_type_code = first_alias
				of DURPREG1STVISIT_CD:
					mother->details[pos].first_ass_preg_dur_week_cnt = result_trim
				of NUMOFANTVISITS_CD:
					if(cnvtint(result_trim) > 0)
						mother->details[pos].antenatal_ser_contact_cnt = result_trim
					endif
				of CIGCOUNT1STHFPREG_CD:
					mother->details[pos].first_half_preg_cig_count = result_trim
				of CIGCOUNT2NDHFPREG_CD:
					mother->details[pos].second_half_preg_cig_count = result_trim
				of GESTWEEKQUITSMOKE_CD:
					mother->details[pos].quit_smoke_gest_week_cnt = result_trim
				of PLURALITY_CD:
					mother->details[pos].birth_plural_code = first_alias
				of ANTPROBPDC16_CD:
					if(findstring(HDPCHRONHYP_TXT, result_upper) > 0)
						mother->details[pos].hypertension_chron_flag = "1"
					endif
					if(findstring(HDPGESTHYP_TXT, result_upper) > 0)
						mother->details[pos].hypertension_gest_flag = "1"
					endif
					if(findstring(HDPPREECLHYP_TXT, result_upper) > 0)
						mother->details[pos].hypertension_preeclamp_flag = "1"
					endif
					if(findstring(HDPECLHYP_TXT, result_upper) > 0)
						mother->details[pos].hypertension_eclamp_flag = "1"
					endif
			endcase
		endif
	with nocounter
end

/**************************************************************
Name:		GetPreviousCaesarianDetails
params: 	n/a
Returns:
Purpose:	Retrieve The C Section details for previous births
**************************************************************/
subroutine GetPreviousCaesarianDetails(null)
	select into "nl:"
	from pregnancy_instance pi
		,pregnancy_child pc
		,problem p
	plan pi where expand(num, 1, mother->cnt, pi.person_id, mother->details[num].person_id)
			and not expand(num2, 1, mother->cnt, pi.pregnancy_id, mother->details[num2].pregnancy_id
							,pi.person_id, mother->details[num2].person_id)
			and pi.active_ind = 1
	join p where p.problem_id = pi.problem_id
			and p.active_ind = 1
			and p.life_cycle_status_cd != CANCELLED_PROB_CD
	join pc where pc.pregnancy_id = pi.pregnancy_id
			and pc.active_ind = 1
	order by pi.person_id, pc.delivery_dt_tm desc
	head pi.person_id
		pos = locateval(num, 1, mother->cnt, pi.person_id, mother->details[num].person_id)
		if(pos > 0)
			call echo("Previous CSection:")
			call echo(pi.person_id)
			call echo(pc.delivery_method_cd)
			if(pc.delivery_method_cd in (CSECTION_CD, CSECTION_CLASS_CD, CSECTION_LOWTRANS_CD, CSECTION_OTH_CD, CSECTIONJ_CD))
				mother->details[pos].last_birth_cs_indicator = "1"
			elseif(pc.delivery_method_cd = UNKNOWN_CD)
				mother->details[pos].last_birth_cs_indicator = "9"
			endif

			cs_count = 0
		endif
	detail
		if(pos > 0 and pc.delivery_method_cd in (CSECTION_CD, CSECTION_CLASS_CD, CSECTION_LOWTRANS_CD, CSECTION_OTH_CD, CSECTIONJ_CD))
			cs_count = cs_count + 1
		endif
	foot pc.person_id
		if(pos > 0 and cs_count > 0)
			mother->details[pos].previous_cs_count = cnvtstring(cs_count)
		endif
	with expand = 1
end

/**************************************************************
Name:		GetHypertensionDetails
params: 	n/a
Returns:
Purpose:	Retrieve mothers hypertension details
**************************************************************/
subroutine GetHypertensionDetails(null)
	select into "nl:"
	from pregnancy_instance pi
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan pi where expand(num, 1, mother->cnt, pi.pregnancy_id, mother->details[num].pregnancy_id)
						and pi.active_ind = 1
	join ce where ce.person_id = pi.person_id
			and ce.event_end_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
			and ce.event_cd in (EXTRHPBRES_CD, HEPBSURFANT_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.task_assay_cd != 0
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by pi.pregnancy_id, ce.person_id, ce.event_end_dt_tm desc
	head pi.pregnancy_id
		pos = locateval(num, 1, mother->cnt, pi.pregnancy_id, mother->details[num].pregnancy_id)
	head ce.person_id
		call echo("HEP Stuff")
		call echo(pi.pregnancy_id)
		call echo(nomo.alias)
		call echo(pos)
		if(pos > 0)
			mother->details[pos].hbv_surf_ant_pos_flag = trim(nomo.alias, 3)
		endif
	with nocounter, expand = 1

end

/**************************************************************
Name:		GetPreviousPregnancyCount
params: 	n/a
Returns:
Purpose:	Get the Mothers previous pregnancy count
**************************************************************/
subroutine GetPreviousPregnancyCount(null)
	select into "nl:"
	from pregnancy_instance pi
		,pregnancy_child pc
		,problem p
	plan pi where expand(num, 1, mother->cnt, pi.person_id, mother->details[num].person_id)
			and not expand(num2, 1, mother->cnt, pi.pregnancy_id, mother->details[num2].pregnancy_id
							,pi.person_id, mother->details[num2].person_id)
			and pi.active_ind = 1
	join p where p.problem_id = pi.problem_id
			and p.active_ind = 1
			and p.life_cycle_status_cd != CANCELLED_PROB_CD
	join pc where pc.pregnancy_id = pi.pregnancy_id
			and pc.neonate_outcome_cd in (LIVEBIRTH_CD, NEONDEATH_CD, FETALDEMSTILL_CD)
			and pc.active_ind = 1
	order by pi.person_id, pi.pregnancy_id
	head pi.person_id
		pos = locateval(num, 1, mother->cnt, pi.person_id, mother->details[num].person_id)
	head pi.pregnancy_id
		call echo("Found Patient")
	detail
		if(pos > 0)
			call echo(pi.pregnancy_id)
			call echo(build2("pos: ", pos))
			if((pc.neonate_outcome_cd = FETALDEMSTILL_CD and (pc.gestation_age >= 140 or pc.weight_amt > 400))
			or pc.neonate_outcome_cd in (LIVEBIRTH_CD, NEONDEATH_CD))
				mother->details[pos].previous_preg_indicator = "1"
				mother->details[pos].previous_preg_count = cnvtstring(cnvtint(mother->details[pos].previous_preg_count) + 1)
			endif
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetBabyObject
params: 	n/a
Returns:
Purpose:	Get the Babys details
**************************************************************/
subroutine GetBabyObject(null)
	select into "nl:"
	from pregnancy_instance pi
		,encounter e_mum
		,encounter e2
		,ce_dynamic_label ced
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
		,ce_date_result cdr
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
					and pi.active_ind = 1
	join e_mum where e_mum.encntr_id = (select ce1.encntr_id
                              from clinical_event ce1
                              where ce1.event_cd = BIRTHDTTM_CD
                              and ce1.person_id = pi.person_id
                              and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
                              and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD))
			and e_mum.encntr_type_cd = INPATIENT_CD
			and nullval(e_mum.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e_mum.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join e2 where e2.person_id = pi.person_id
			and nullval(e2.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
			and nullval(e2.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e2.encntr_id
			and ce.event_cd in (ONSETOFLAB_CD, ONSETOFLABMETH_CD, MAININDFORDINDUCT_CD, AUGMENTMETH_CD
								,PRESENTATDEL_CD, ANALGINLAB_CD, MAININDCSECTION_CD, ANAEDURBIRTH_CD
								,PLACDELMETH_CD,NEONATEOUT_CD, BIRTHORD_CD, BIRTHWEIGHT_CD, APGARSC1MIN_CD, APGARSC5MIN_CD
								,RESUSATBIRTH_CD, PLACEOFDEL_CD, CONGENABNOR_CD, BIRTHDTTM_CD, MODEOFBIRTH_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.task_assay_cd != 0
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ced where ced.ce_dynamic_label_id = ce.ce_dynamic_label_id
			and ced.ce_dynamic_label_id > 0
			and ced.valid_until_dt_tm > cnvtdatetime(curdate, curtime3)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
			 and ccr.valid_until_dt_tm > outerjoin(cnvtdatetime(curdate,curtime3))
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	join cdr where cdr.event_id = outerjoin(ce.event_id)
				and cdr.valid_until_dt_tm > outerjoin(cnvtdatetime(curdate, curtime3))
	order by ced.ce_dynamic_label_id,
			 ce.event_cd,
			 ce.event_end_dt_tm desc,
			 ccr.sequence_nbr
	head ced.ce_dynamic_label_id
		pos = locateval(num, 1, babies->cnt, ced.ce_dynamic_label_id, babies->details[num].ced_dynamic_label_id)
		if(pos > 0)
			;Set values to 0 before looking as they will be 0 always unless value exists
			babies->details[pos].postp_haem_flag = "0"
			babies->details[pos].disch_feed_breast_flag = "0"
			babies->details[pos].disch_feed_exp_breast_milk_flag = "0"
			babies->details[pos].disch_feed_inf_form_flag = "0"
			babies->details[pos].disch_feed_not_app_flag = "1"
			babies->details[pos].cong_cond_flag = "0"
			babies->details[pos].labour_ind_oxy_flag = "0"
			babies->details[pos].labour_ind_arm_flag = "0"
			babies->details[pos].labour_ind_pros_flag = "0"
			babies->details[pos].labour_ind_oth_flag = "0"
			babies->details[pos].labour_analg_none_flag = "0"
			babies->details[pos].labour_analg_nito_flag = "0"
			babies->details[pos].labour_analg_syso_flag = "0"
			babies->details[pos].labour_analg_spin_flag = "0"
			babies->details[pos].labour_analg_epidc_flag = "0"
			babies->details[pos].labour_analg_cse_flag = "0"
			babies->details[pos].labour_analg_oth_flag = "0"
			babies->details[pos].labour_aug_oxy_flag = "0"
			babies->details[pos].labour_aug_arm_flag = "0"
			babies->details[pos].del_anaes_none_flag = "0"
			babies->details[pos].del_anaes_combse_flag = "0"
			babies->details[pos].del_anaes_epidc_flag = "0"
			babies->details[pos].del_anaes_gen_flag = "0"
			babies->details[pos].del_anaes_locp_flag = "0"
			babies->details[pos].del_anaes_oth_flag = "0"
			babies->details[pos].del_anaes_pud_flag = "0"
			babies->details[pos].del_anaes_spin_flag = "0"
			babies->details[pos].perineal_epis_ind = "0"
			babies->details[pos].blood_tran_pph_flag = "0"
		endif
	head ce.event_cd
		call echo(ce.event_cd)
	head ccr.sequence_nbr
		if(pos > 0)
			call echo("Coded Result")
			call echo(ce.person_id)
			call echo(ccr.sequence_nbr)
			result_trim = trim(ce.result_val, 3)
			result_upper = cnvtupper(result_trim)
			nom_alias = trim(nomo.alias, 3)
			ccr_string_upper = cnvtupper(trim(ccr.descriptor, 3))
			;Check whether alias found should be split up or not.
			if(findstring(";", nom_alias) > 0)
				find_pos = findstring(";", nom_alias)
				first_alias = substring(1, find_pos - 1, nom_alias)
				second_alias = substring(find_pos + 1, size(nom_alias), nom_alias)
			else
				first_alias = nom_alias
			endif

			call echo(first_alias)
			call echo(second_alias)
			case (ce.event_cd)
				of ONSETOFLAB_CD:
					babies->details[pos].labour_onset_type_code = first_alias
				of AUGMENTMETH_CD:
					if(findstring(IVOXYTOCIN_TXT, result_upper) > 0)
						babies->details[pos].labour_aug_oxy_flag = "1"
					endif
					if(findstring(ARTRUPTMEM_TXT, result_upper) > 0)
						babies->details[pos].labour_aug_arm_flag = "1"
					endif
				of ANAEDURBIRTH_CD:
					if(ccr_string_upper = NONE_TXT)
						babies->details[pos].del_anaes_none_flag = "1"
					endif
					if(ccr_string_upper = LOCANAESTOPER_TXT)
						babies->details[pos].del_anaes_locp_flag = first_alias
					endif
					if(ccr_string_upper = PUDENDAL_TXT)
						babies->details[pos].del_anaes_pud_flag = first_alias
					endif
					if(ccr_string_upper = GENERAL_TXT)
						babies->details[pos].del_anaes_gen_flag = first_alias
					endif
					if(ccr_string_upper = SPINAL_TXT)
						babies->details[pos].del_anaes_spin_flag = first_alias
					endif
					if(ccr_string_upper in (EPIDURAL_TXT, CAUDAL_TXT))
						babies->details[pos].del_anaes_epidc_flag = first_alias
					endif
					if(ccr_string_upper = COMBSPEPD_TXT)
						babies->details[pos].del_anaes_combse_flag = "1"
					endif
					if(findstring(OTHER_TXT, result_upper) > 0)
						babies->details[pos].del_anaes_oth_flag = "1"
					endif
				of MAININDFORDINDUCT_CD:
					if(findstring(OTHER_TXT, result_upper) > 0)
						babies->details[pos].labour_ind_main_code = "10"
					else
						babies->details[pos].labour_ind_main_code = first_alias
					endif
				of PRESENTATDEL_CD:
					babies->details[pos].presentation_at_birth_code = first_alias
				of MAININDCSECTION_CD:
					babies->details[pos].main_ind_csect_code = second_alias
				of PLACDELMETH_CD:
					babies->details[pos].perineal_third_stmt_code = first_alias
				of NEONATEOUT_CD:
					babies->details[pos].neonate_outcome_txt = result_upper
					babies->details[pos].birth_stat_code = first_alias
					if(findstring(STILLBORN_TXT, result_upper) > 0)
						babies->details[pos].apgar_onemin_score = "00"
						babies->details[pos].apgar_fivemin_score = "00"
					endif
				of BIRTHORD_CD:
					babies->details[pos].birth_ord_code = result_trim
					babies->details[pos].birth_order = cnvtint(result_trim)
				of BIRTHWEIGHT_CD:
					babies->details[pos].birth_weight = result_trim
				of APGARSC1MIN_CD:
					if(textlen(trim(result_trim,3)) < 2)
						babies->details[pos].apgar_onemin_score = build2("0",result_trim)
					else
						babies->details[pos].apgar_onemin_score = result_trim
					endif
				of APGARSC5MIN_CD:
					if(textlen(trim(result_trim, 3)) < 2)
						babies->details[pos].apgar_fivemin_score = build2("0",result_trim)
					else
						babies->details[pos].apgar_fivemin_score = result_trim
					endif
				of RESUSATBIRTH_CD:
					babies->details[pos].resus_type_code = first_alias
				of PLACEOFDEL_CD:
					babies->details[pos].place_of_birth = second_alias
				of BIRTHDTTM_CD:
					babies->details[pos].birthdttm_event = cdr.result_dt_tm
				of MODEOFBIRTH_CD:
					babies->details[pos].newborn_birth_type_code = first_alias
				of ONSETOFLABMETH_CD:
					if(ccr_string_upper = IVOXYTOCIN_TXT)
						babies->details[pos].labour_ind_oxy_flag = first_alias
					endif
					if(ccr_string_upper = ARTRUPTMEM_TXT)
						babies->details[pos].labour_ind_arm_flag = first_alias
					endif
					if(ccr_string_upper = VAGPROST_TXT)
						babies->details[pos].labour_ind_pros_flag = first_alias
					endif
					if(ccr_string_upper = CERVRIPENDEV_TXT
					or findstring(OTHER_TXT, result_upper) > 0)
						babies->details[pos].labour_ind_oth_flag = "1"
					endif
				of ANALGINLAB_CD:
					if(ccr_string_upper = NONE_TXT)
						babies->details[pos].labour_analg_none_flag = "1"
					endif
					if(ccr_string_upper = NITOXID_TXT)
						babies->details[pos].labour_analg_nito_flag = first_alias
					endif
					if(ccr_string_upper = SYSOPI_TXT)
						babies->details[pos].labour_analg_syso_flag = first_alias
					endif
					if(ccr_string_upper = SPINAL_TXT)
						babies->details[pos].labour_analg_spin_flag = first_alias
					endif
					if(ccr_string_upper in (EPIDURAL_TXT, CAUDAL_TXT))
						babies->details[pos].labour_analg_epidc_flag = first_alias
					endif
					if(ccr_string_upper = COMBSPEPD_TXT)
						babies->details[pos].labour_analg_cse_flag = first_alias
					endif
					if(findstring(OTHER_TXT, result_upper) > 0)
						babies->details[pos].labour_analg_oth_flag = "1"
					endif
			endcase
		endif
	foot ced.ce_dynamic_label_id
		if(pos > 0)
			presentatdelint = cnvtint(babies->details[pos].presentation_at_birth_code)
			deltypeint = cnvtint(babies->details[pos].newborn_birth_type_code)

			if(presentatdelint = 2 and deltypeint = 2)
				babies->details[pos].newborn_birth_type_code = "4"
			elseif(presentatdelint = 2 and deltypeint in(1, 3))
				babies->details[pos].newborn_birth_type_code = "5"
			endif
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetBabyNameAddrDetails
params: 	n/a
Returns:
Purpose:	Get name and address amongst other details from baby record
**************************************************************/
subroutine GetBabyNameAddrDetails(null)
	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,person p
		,encounter e_baby
		,clinical_event ce
		,encntr_alias ea
		,code_value_outbound cvo_issue
		,encntr_alias ea_visit
		,service_category_hist svc
		,encntr_info ei
		,code_value_outbound cvo_reffac
		,code_value_outbound cvo_disch
		,code_value_outbound cvo_ind
		,code_value_outbound cvo_gen
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
					and pi.active_ind = 1
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join p where p.person_id = ppr.related_person_id
			and p.active_ind = 1
	join e_baby where e_baby.person_id = p.person_id
				and exists(select 1
						from clinical_event ce1
						where ce1.encntr_id = e_baby.encntr_id
						and ce1.event_cd = BABYBIRTHDTTM_CD
						and ce1.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
						and ce1.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD))
				and e_baby.encntr_type_cd in (INPATIENT_CD, REGISTRATION_CD)
				and nullval(e_baby.reg_dt_tm, cnvtdatetime(curdate,curtime3)) < pi.preg_end_dt_tm
				and nullval(e_baby.disch_dt_tm, cnvtdatetime(curdate,curtime3)) > pi.preg_start_dt_tm
	join ce where ce.encntr_id = e_baby.encntr_id
			and ce.event_cd = BABYBIRTHORD_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.event_class_cd = NUMEVT_CLASS_CD
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ea where ea.encntr_id = e_baby.encntr_id
			and ea.active_ind = 1
			and ea.encntr_alias_type_cd = EAMRN_CD
	join cvo_issue where cvo_issue.code_value = ea.alias_pool_cd
					and cvo_issue.code_set = 263
					and cvo_issue.contributor_source_cd = NSWEDW_CS
	join ea_visit where ea_visit.encntr_id = e_baby.encntr_id
					and ea_visit.active_ind = 1
					and ea_visit.encntr_alias_type_cd = VISITID_CD
	join cvo_disch where cvo_disch.code_value = outerjoin(e_baby.disch_disposition_cd)
					and cvo_disch.code_set = outerjoin(19)
					and cvo_disch.contributor_source_cd = outerjoin(NSWEDW_CS)
	join svc where svc.encntr_id = e_baby.encntr_id
				and svc.active_ind = 1
	join ei where ei.encntr_id = outerjoin(e_baby.encntr_id)
			and ei.active_ind = outerjoin(1)
			and ei.info_sub_type_cd = outerjoin(HOSPTRANSFERTO_CD)
	join cvo_reffac where cvo_reffac.code_value = outerjoin(ei.value_cd)
					and cvo_reffac.code_set = outerjoin(18889)
					and cvo_reffac.contributor_source_cd = outerjoin(NSWEDW_CS)
	join cvo_ind where cvo_ind.code_value = p.race_cd
					and cvo_ind.code_set = 282
					and cvo_ind.contributor_source_cd = NSWEDW_CS
	join cvo_gen where cvo_gen.code_value = p.sex_cd
					and cvo_gen.code_set = 57
					and cvo_gen.contributor_source_cd = NSWEDW_CS
	order by p.person_id, ce.event_end_dt_tm desc
	head p.person_id
		call echo("Baby Starting:")
		call echo(pi.pregnancy_id)
		call echo(ce.result_val)

		pos = locateval(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id
								,cnvtint(ce.result_val), babies->details[num].birth_order)
		call echo(pos)
		call echo("End Baby")
		if(pos > 0)
			babies->details[pos].person_id = p.person_id
			babies->details[pos].create_dt_tm = format(e_baby.beg_effective_dt_tm, 'yyyy-mm-dd hh:mm:ss;;q')
			babies->details[pos].modified_dt_tm = format(extract_end_dt_tm, 'yyyy-mm-dd hh:mm:ss;;q')
			babies->details[pos].given_name = p.name_first
			babies->details[pos].middle_names = p.name_middle
			babies->details[pos].family_name = p.name_last
			babies->details[pos].gender = trim(cvo_gen.alias, 3)
			babies->details[pos].dob = format(p.birth_dt_tm, 'yyyymmdd;;q')
			babies->details[pos].client_id_issue_auth = trim(cvo_issue.alias, 3)
			babies->details[pos].client_id = trim(ea.alias, 3)
			babies->details[pos].service_encntr_rec_id = build2(trim(substring(1,10,cvo_issue.alias)), "-"
															, trim(ea_visit.alias, 3))

			if(findstring(NEONATEDEATH_TXT, babies->details[pos].neonate_outcome_txt) > 0)
				babies->details[pos].formal_discharge_dt_tm = format(p.deceased_dt_tm ,"yyyy-mm-dd hh:mm:ss;;q" )
			elseif(findstring(STILLBORN_TXT, babies->details[pos].neonate_outcome_txt) = 0)
				babies->details[pos].formal_discharge_dt_tm = format(e_baby.disch_dt_tm ,"yyyy-mm-dd hh:mm:ss;;q" )
			endif
			babies->details[pos].formal_discharge_mode_code = trim(substring(1,2,cvo_disch.alias), 3)
			babies->details[pos].transfer_to_osp_id = trim(cvo_reffac.alias, 3)
			babies->details[pos].service_event_rec_id = cnvtstring(svc.svc_cat_hist_id)
			babies->details[pos].birth_record_id = trim(ea.alias, 3)
			babies->details[pos].ind_stat_code = trim(cvo_ind.alias, 3)
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetBabyRecordDetails
params: 	n/a
Returns:
Purpose:	Get results stored on babies chart
**************************************************************/
subroutine GetBabyRecordDetails(null)
	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,person p
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
					and pi.active_ind = 1
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join p where p.person_id = ppr.related_person_id
			and p.active_ind = 1
	join ce where ce.person_id = pi.person_id
			and ce.event_end_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
			and ce.event_cd in (PERSTATUSPCM_CD, REPPERINORVAG_CD, MAINMODOFANTCARE_CD ,MAINMODOFCAREBIRTH_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
			and ce.task_assay_cd != 0
	join ccr where ccr.event_id = outerjoin(ce.event_id)
			 and ccr.valid_until_dt_tm > outerjoin(cnvtdatetime(curdate,curtime3))
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by p.person_id,
			 ce.event_cd,
			 ce.event_end_dt_tm desc,
			 ccr.sequence_nbr
	head p.person_id
		pos = locateval(num, 1, babies->cnt, p.person_id, babies->details[num].person_id)
		call echo("Baby of:")
		call echo(p.person_id)
		call echo(pos)
	head ce.event_cd
		call echo(ce.event_cd)
	head ccr.sequence_nbr
		if(pos > 0)
			result_trim = trim(ce.result_val, 3)
			result_upper = cnvtupper(result_trim)
			nom_alias = trim(nomo.alias, 3)
			ccr_string_upper = cnvtupper(trim(ccr.descriptor, 3))
			;Check whether alias found should be split up or not.
			if(findstring(";", nom_alias) > 0)
				find_pos = findstring(";", nom_alias)
				first_alias = substring(1, find_pos - 1, nom_alias)
				second_alias = substring(find_pos + 1, size(nom_alias), nom_alias)
			else
				first_alias = nom_alias
			endif
			case (ce.event_cd)
				of PERSTATUSPCM_CD:
					if(cnvtint(babies->details[pos].perineal_status_code) > cnvtint(first_alias)
					or cnvtint(babies->details[pos].perineal_status_code) = 0)
						call echo("Set value")
						babies->details[pos].perineal_status_code = first_alias
					endif

					if(findstring(EPISIOTOMY_TXT, result_upper) > 0)
						babies->details[pos].perineal_epis_ind = "1"
					endif
				of REPPERINORVAG_CD:
					babies->details[pos].perineal_surg_rep_ind = first_alias
				of MAINMODOFANTCARE_CD:
				call echo("Model of Care")
					babies->details[pos].main_mat_moc_ant_code = first_alias
				of MAINMODOFCAREBIRTH_CD:
					babies->details[pos].main_mat_moc_birth_code = first_alias
			endcase
		endif
	with nocounter, expand = 1

	select into "nl:"
	from clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan ce where expand(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
			and ce.event_cd in (FEEDATDISCH_CD, CONGENABNOR_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
			and ce.task_assay_cd != 0
	join ccr where ccr.event_id = outerjoin(ce.event_id)
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by ce.person_id, ce.event_end_dt_tm desc
	head ce.person_id
		pos = locateval(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
	detail
		if(pos > 0)
			result_trim = trim(ce.result_val, 3)
			result_upper = cnvtupper(result_trim)
			nom_alias = trim(nomo.alias, 3)
			;Check whether alias found should be split up or not.
			if(findstring(";", nom_alias) > 0)
				find_pos = findstring(";", nom_alias)
				first_alias = substring(1, find_pos - 1, nom_alias)
				second_alias = substring(find_pos + 1, size(nom_alias), nom_alias)
			else
				first_alias = nom_alias
			endif

			case (ce.event_cd)
				of FEEDATDISCH_CD:
					if(result_upper in (BFONLY_TXT, BFEXPBM_TXT, BFEXPBMFM_TXT, BFFORM_TXT))
						babies->details[pos].disch_feed_breast_flag = "1"
						babies->details[pos].disch_feed_not_app_flag = "0"
					endif
					if (result_upper in (BFEXPBM_TXT, BFEXPBMFM_TXT, EXPBM_TXT, EXPBMFORM_TXT, HUMDNMK_TXT))
						babies->details[pos].disch_feed_exp_breast_milk_flag = "1"
						babies->details[pos].disch_feed_not_app_flag = "0"
					endif
					if(result_upper in (BFEXPBMFM_TXT, BFFORM_TXT, EXPBMFORM_TXT, FORMONLY_TXT))
						babies->details[pos].disch_feed_inf_form_flag = "1"
						babies->details[pos].disch_feed_not_app_flag = "0"
					endif
					if(result_upper in (NIL_TXT, NOTKNOWN_TXT, NOTAPP_TXT))
						babies->details[pos].disch_feed_not_app_flag = "1"
					endif
				of CONGENABNOR_CD:
					call echo(result_trim)
					babies->details[pos].cong_cond_flag = "1"
					if(textlen(trim(babies->details[pos].cong_cond_desc_1, 3)) = 0)
						babies->details[pos].cong_cond_desc_1 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_2, 3)) = 0)
						babies->details[pos].cong_cond_desc_2 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_3, 3)) = 0)
						babies->details[pos].cong_cond_desc_3 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_4, 3)) = 0)
						babies->details[pos].cong_cond_desc_4 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_5, 3)) = 0)
						babies->details[pos].cong_cond_desc_5 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_6, 3)) = 0)
						babies->details[pos].cong_cond_desc_6 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_7, 3)) = 0)
						babies->details[pos].cong_cond_desc_7 = result_trim
					elseif(textlen(trim(babies->details[pos].cong_cond_desc_8, 3)) = 0)
						babies->details[pos].cong_cond_desc_8 = result_trim
					endif
			endcase
		endif
	with nocounter, expand = 1

	select into "nl:"
	from clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan ce where expand(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
			and ce.event_cd = EGAATBIRTH_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by ce.person_id, ce.event_end_dt_tm desc
	head ce.person_id
		pos = locateval(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
	detail
		if(pos > 0)
			result_trim = trim(ce.result_val, 3)
			babies->details[pos].est_gest_age_week_cnt = substring(1, 2, result_trim)
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetBloodLossValuesofMother
params: 	n/a
Returns:
Purpose:	Get blood loss values from the mothers chart for the baby object
**************************************************************/
subroutine GetBloodLossValuesofMother(null)
	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,person p
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
					and pi.active_ind = 1
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join p where p.person_id = ppr.related_person_id
			and p.active_ind = 1
	join ce where ce.person_id = pi.person_id
			and ce.event_end_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
			and ce.event_cd in (POSTHAEMTYPE_CD, BIRTHINGEBL_CD, POSTNATALEBL_CD, BLOODTRANSADMIN_CD)
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.task_assay_cd != 0
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
			 and ccr.valid_until_dt_tm > outerjoin(cnvtdatetime(curdate,curtime3))
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by p.person_id,
			 ce.event_cd,
			 ce.event_end_dt_tm desc,
			 ce.event_id,
			 ccr.sequence_nbr
	head p.person_id
		pos = locateval(num, 1, babies->cnt, p.person_id, babies->details[num].person_id)
		call echo("Baby of:")
		call echo(p.person_id)
		call echo(pos)
		bloodloss = 0
	head ce.event_id
		if(pos > 0)
			result_trim = trim(ce.result_val, 3)
			result_upper = cnvtupper(result_trim)
			nom_alias = trim(nomo.alias, 3)
			ccr_string_upper = cnvtupper(trim(ccr.descriptor, 3))
			;Check whether alias found should be split up or not.
			if(findstring(";", nom_alias) > 0)
				find_pos = findstring(";", nom_alias)
				first_alias = substring(1, find_pos - 1, nom_alias)
				second_alias = substring(find_pos + 1, size(nom_alias), nom_alias)
			else
				first_alias = nom_alias
			endif
			call echo(uar_get_code_display(ce.event_cd))
			case (ce.event_cd)
				of POSTHAEMTYPE_CD:
					if(result_upper = PRIMARY_TXT)
						babies->details[pos].postp_haem_flag = "1"
					endif
				of BLOODTRANSADMIN_CD:
					call echo(build2("Setting first alias on blood: ", first_alias))
					babies->details[pos].blood_tran_pph_flag = first_alias
				of POSTNATALEBL_CD:
					bloodloss = bloodloss + cnvtreal(result_trim)
				of BIRTHINGEBL_CD:
					if(datetimediff(cnvtdatetime(babies->details[pos].birthdttm_event), cnvtdatetime(ce.event_end_dt_tm), 3) <= 24)
						bloodloss = bloodloss + cnvtreal(result_trim)
					endif
			endcase
		endif
	foot p.person_id
		if(pos > 0)
			call echo("End of baby")
			if(babies->details[pos].postp_haem_flag != "1")
				call echo("setting to 0")
				call echo(babies->details[pos].postp_haem_flag)
				babies->details[pos].blood_tran_pph_flag = "0"
			else
				if(bloodloss < 500)
					babies->details[pos].blood_loss_vol_ext_code = "9"
				elseif(bloodloss >= 500 and bloodloss <= 999)
					babies->details[pos].blood_loss_vol_ext_code = "1"
				elseif(bloodloss >= 1000 and bloodloss <= 1499)
					babies->details[pos].blood_loss_vol_ext_code = "2"
				elseif(bloodloss >= 1500)
					babies->details[pos].blood_loss_vol_ext_code = "3"
				endif
			endif
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		GetHepBDoseFlag
params: 	n/a
Returns:
Purpose:	Get hepb dosing values
**************************************************************/
subroutine GetHepBDoseFlag(null)
	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id)
					and pi.active_ind = 1
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join ce where ce.person_id = ppr.related_person_id
			and ce.event_end_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
			and cnvtupper(ce.event_title_text) = HEPBPAEDVAC_TXT
			and ce.task_assay_cd != 0
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by ce.person_id, ce.event_end_dt_tm desc
	head ce.person_id
		pos = locateval(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
		if (pos > 0 and cnvtupper(ce.event_title_text) = HEPBPAEDVAC_TXT
		and ce.event_end_dt_tm >= cnvtlookahead('7,D', babies->details[pos].birthdttm_event))
			babies->details[pos].hepb_birth_dose_flag = "1"
		endif
	with nocounter, expand = 1

	select into "nl:"
	from pregnancy_instance pi
		,person_person_reltn ppr
		,clinical_event ce
		,ce_coded_result ccr
		,nomenclature_outbound nomo
	plan pi where expand(num, 1, babies->cnt, pi.pregnancy_id, babies->details[num].pregnancy_id,
							0, textlen(babies->details[num].hepb_birth_dose_flag))
					and pi.active_ind = 1
	join ppr where ppr.person_id = pi.person_id
			and ppr.active_ind = 1
			and ppr.person_reltn_cd = RELTNCHILD_CD
			and ppr.end_effective_dt_tm >= cnvtdatetime(curdate, curtime3)
	join ce where ce.person_id = ppr.related_person_id
			and ce.event_end_dt_tm between pi.preg_start_dt_tm and pi.preg_end_dt_tm
			and ce.event_cd = HEPBVACGIVEN_CD
			and ce.valid_until_dt_tm > cnvtdatetime(curdate,curtime3)
			and ce.result_status_cd not in (INERROR_CD, INERROR2_CD,INERROR3_CD,INERROR4_CD , NOT_DONE_CD)
	join ccr where ccr.event_id = outerjoin(ce.event_id)
	join nomo where nomo.nomenclature_id = outerjoin(ccr.nomenclature_id)
				and nomo.source_vocabulary_cd = outerjoin(NSWEDW_SV)
	order by ce.person_id, ce.event_end_dt_tm desc
	head ce.person_id
		pos = locateval(num, 1, babies->cnt, ce.person_id, babies->details[num].person_id)
	    if(pos > 0)
	    	babies->details[pos].hepb_birth_dose_flag = trim(nomo.alias, 3)
		endif
	with nocounter, expand = 1
end

/**************************************************************
Name:		WriteObjToFile
params: 	n/a
Returns:
Purpose:	Write outputs to the relevant file
**************************************************************/
subroutine WriteObjToFile(null)
	call ftp_initialise(null)

	record mum(
       1 file_desc = i4
       1 file_offset = i4
       1 file_dir = i4
       1 file_name = vc
       1 file_buf = vc
   )

   set batch_seq = cnvtstring(get_next_stream_seq("PDC"))

   set ext_filename = build2(opts->source_system_id
   							,"_36_", trim(cnvtstring(batch_seq))
   							,"_203_", format(cnvtdatetime(extract_start_dt_tm), "yyyy-mm-dd;;d"), "T"
   							,"_", format(cnvtdatetime(extract_start_dt_tm), "hhXmmXss;;q")
   							,".txt")
   set mum->file_name = ext_filename
   set mum->file_buf = "wb+" ;file open mode
   set stat = cclio("OPEN",mum)



   select into "nl:"
   from (dummyt d1 with seq = value(mother->cnt))
   plan d1
    head report
	  outstring = build2("RECORD_SOURCE_SYSTEM_CODE",del
                           ,"CONTAINER_SEQUENCE_NUMBER",del
                           ,"SOURCE_CREATE_DATETIME",del
                           ,"SOURCE_MODIFIED_DATETIME",del
                           ,"ACTION_TYPE",del
                           ,"PERINATAL_RECORD_SOURCE_ID",del
							,"PERINATAL_PREGNANCY_RECORD_ID",del
							,"PERINATAL_RECORD_STATUS_CODE",del
							,"PERINATAL_NOTIFIER_TYPE_CODE",del
							,"PERINATAL_NOTIFIER_OSP_ID",del
							,"PREVIOUS_PREGNANCY_INDICATOR",del
							,"PREVIOUS_PREGNANCY_COUNT",del
							,"LAST_BIRTH_CAESAREAN_SECTION_INDICATOR",del
							,"PREVIOUS_CAESAREAN_SECTION_COUNT",del
							,"MOTHER_HEIGHT_CENTIMETERS",del
							,"MOTHER_WEIGHT_KILOGRAMS",del
							,"ANTENATAL_ESTIMATED_DATE_OF_BIRTH",del
							,"ANTENATAL_CARE_RECEIVED_INDICATOR",del
							,"FIRST_ASSESS_PREG_DURATION_WEEK_COUNT",del
							,"ANTENATAL_SERVICE_CONTACT_COUNT",del
							,"MOTHER_TESTED_FOR_HIV_FLAG",del
							,"MOTHER_PERTUSSIS_IMMUNISED_FLAG",del
							,"MOTHER_INFLUENZA_IMMUNISED_FLAG",del
							,"MOTHER_DIABETES_MELLITUS_TYPE_CODE",del
							,"MOTHER_HYPERTENSION_CHRONIC_FLAG",del
							,"MOTHER_HYPERTENSION_GESTATIONAL_FLAG",del
							,"MOTHER_HYPERTENSION_PREECLAMPSIA_FLAG",del
							,"MOTHER_HYPERTENSION_ECLAMPSIA_FLAG",del
							,"MOTHER_HBV_SURFACE_ANTIGEN_POSITIVE_FLAG",del
							,"MOTHER_SMOKED_IN_1ST_HALF_PREG_FLAG",del
							,"MOTHER_1ST_HALF_PREG_CIGARETTE_COUNT",del
							,"MOTHER_SMOKED_IN_2ND_HALF_PREG_FLAG",del
							,"MOTHER_2ND_HALF_PREG_CIGARETTE_COUNT",del
							,"MOTHER_QUIT_SMOKING_IN_PREG_FLAG",del
							,"MOTHER_QUIT_SMOKING_GESTATION_WEEK_COUNT",del
							,"BIRTH_PLURALITY_CODE",del
							,"MOTHER_LEGAL_GIVEN_NAME",del
							,"MOTHER_LEGAL_MIDDLE_NAMES",del
							,"MOTHER_LEGAL_FAMILY_NAME",del
							,"MOTHER_RES_ORIGINAL_ADDRESS",del
							,"MOTHER_RES_ORIGINAL_SUBURB_LOCALITY",del
							,"MOTHER_RES_ORIGINAL_POSTCODE",del
							,"MOTHER_RES_ORIGINAL_STATE_TER_ABBREV",del
							,"MOTHER_RES_ORIGINAL_ADDRESS_COUNTRY_CODE",del
							,"MOTHER_DATE_OF_BIRTH",del
							,"MOTHER_COUNTRY_OF_BIRTH_CODE",del
							,"MOTHER_INDIGENOUS_STATUS_CODE",del
							,"MOTHER_CLIENT_ID_TYPE_CODE",del
							,"MOTHER_CLIENT_ID_ISSUING_AUTHORITY",del
							,"MOTHER_CLIENT_ID",del
							,"MOTHER_SERVICE_EVENT_SOURCE_ID",del
							,"MOTHER_SERVICE_ENCOUNTER_RECORD_ID",del
							,"MOTHER_SERVICE_EVENT_RECORD_ID",del
							,"MOTHER_FORMAL_DISCHARGE_MODE_CODE",del
							,"MOTHER_FORMAL_DISCHARGE_DATETIME",del
							,"MOTHER_TRANSFER_TO_OSP_ID"
                           )
 	call echo(outstring)
	mum->file_buf = outstring
	stat = cclio("PUTS", mum)

      detail
      if (mother->cnt > 0)
		 outstring = build2(trim(substring(1,12,opts->source_system_id)),del_tmp
                              ,trim(substring(1,12,cnvtstring(batch_seq))),del_tmp
                              ,trim(mother->details[d1.seq].create_dt_tm),del_tmp
                              ,trim(mother->details[d1.seq].modified_dt_tm),del_tmp
                              ,trim(mother->details[d1.seq].action_type),del_tmp
                              ,trim(substring(1,12,opts->source_system_id)),del_tmp
                              ,trim(mother->details[d1.seq].perinatal_preg_record_id),del_tmp
                              ,trim("1"),del_tmp
                              ,trim("1"),del_tmp
                              ,trim(mother->details[d1.seq].notified_osp_id),del_tmp
                              ,trim(mother->details[d1.seq].previous_preg_indicator), del_tmp
                              ,trim(mother->details[d1.seq].previous_preg_count), del_tmp
                              ,trim(mother->details[d1.seq].last_birth_cs_indicator), del_tmp
                              ,trim(mother->details[d1.seq].previous_cs_count), del_tmp
                              ,trim(mother->details[d1.seq].height), del_tmp
                              ,trim(mother->details[d1.seq].weight), del_tmp
                              ,trim(mother->details[d1.seq].antenatal_est_dob), del_tmp
                              ,trim(mother->details[d1.seq].antenatal_care_rec_indicator), del_tmp
                              ,trim(mother->details[d1.seq].first_ass_preg_dur_week_cnt), del_tmp
                              ,trim(mother->details[d1.seq].antenatal_ser_contact_cnt), del_tmp
                              ,trim(mother->details[d1.seq].test_for_hiv_flag), del_tmp
                              ,trim(mother->details[d1.seq].pertussis_immun_flag), del_tmp
                              ,trim(mother->details[d1.seq].influenza_immun_flag), del_tmp
                              ,trim(mother->details[d1.seq].diabetes_mell_type_code), del_tmp
                              ,trim(mother->details[d1.seq].hypertension_chron_flag), del_tmp
                              ,trim(mother->details[d1.seq].hypertension_gest_flag), del_tmp
                              ,trim(mother->details[d1.seq].hypertension_preeclamp_flag), del_tmp
                              ,trim(mother->details[d1.seq].hypertension_eclamp_flag), del_tmp
                              ,trim(mother->details[d1.seq].hbv_surf_ant_pos_flag), del_tmp
                              ,trim(mother->details[d1.seq].smoke_first_half_preg_flag), del_tmp
                              ,trim(mother->details[d1.seq].first_half_preg_cig_count), del_tmp
                              ,trim(mother->details[d1.seq].smoke_second_half_preg_flag), del_tmp
                              ,trim(mother->details[d1.seq].second_half_preg_cig_count), del_tmp
                              ,trim(mother->details[d1.seq].quit_smoke_in_preg_flag), del_tmp
                              ,trim(mother->details[d1.seq].quit_smoke_gest_week_cnt), del_tmp
                              ,trim(mother->details[d1.seq].birth_plural_code), del_tmp
                              ,trim(mother->details[d1.seq].legal_give_name), del_tmp
                              ,trim(mother->details[d1.seq].legal_middle_names), del_tmp
                              ,trim(mother->details[d1.seq].legal_family_name), del_tmp
                              ,trim(mother->details[d1.seq].res_orig_address), del_tmp
                              ,trim(mother->details[d1.seq].res_orig_suburb_local), del_tmp
                              ,trim(mother->details[d1.seq].res_orig_postcode), del_tmp
                              ,trim(mother->details[d1.seq].res_orig_state), del_tmp
                              ,trim(mother->details[d1.seq].res_orig_country), del_tmp
                              ,trim(mother->details[d1.seq].dob), del_tmp
                              ,trim(mother->details[d1.seq].country_of_birth), del_tmp
                              ,trim(mother->details[d1.seq].indigenous_status_code), del_tmp
                              ,trim("016"), del_tmp
                              ,trim(mother->details[d1.seq].client_id_issuing_auth), del_tmp
                              ,trim(mother->details[d1.seq].client_id), del_tmp
                              ,trim(substring(1,12,opts->source_system_id)), del_tmp
                              ,trim(mother->details[d1.seq].service_encntr_rec_id), del_tmp
                              ,trim(mother->details[d1.seq].service_event_rec_id), del_tmp
                              ,trim(mother->details[d1.seq].formal_discharge_mode_code), del_tmp
                              ,trim(mother->details[d1.seq].formal_discharge_dt_tm), del_tmp
                              ,trim(mother->details[d1.seq].transfer_to_osp_id)
                              )
			call clean_string(outstring)
			outstring = concat(crlf, outstring)

			mum->file_buf = outstring
			stat = cclio("PUTS", mum)
        endif

		with format=stream, maxcol = 5000,  noformfeed, maxrow=1

   set stat = cclio("CLOSE", mum)
   free record mum

   call header_add_obj_info("NSWEDW203",ext_filename,mother->cnt)
   call ftp_add_file(ext_filename,1)

   record baby(
       1 file_desc = i4
       1 file_offset = i4
       1 file_dir = i4
       1 file_name = vc
       1 file_buf = vc
   )
   set ext_filename = build2(opts->source_system_id
   							,"_36_", trim(cnvtstring(batch_seq))
   							,"_207_", format(cnvtdatetime(extract_start_dt_tm), "yyyy-mm-dd;;d"), "T"
   							,"_", format(cnvtdatetime(extract_start_dt_tm), "hhXmmXss;;q")
   							,".txt")
   set baby->file_name = ext_filename
   set baby->file_buf = "wb+" ;file open mode
   set stat = cclio("OPEN",baby)

   select into "nl:"
   from (dummyt d1 with seq = value(babies->cnt))
   plan d1
    head report
	  outstring = build2("RECORD_SOURCE_SYSTEM_CODE",del
						,"CONTAINER_SEQUENCE_NUMBER",del
						,"SOURCE_CREATE_DATETIME",del
						,"SOURCE_MODIFIED_DATETIME",del
						,"ACTION_TYPE",del
						,"PERINATAL_RECORD_SOURCE_ID",del
						,"PERINATAL_PREGNANCY_RECORD_ID",del
						,"PERINATAL_BIRTH_RECORD_ID",del
						,"PERINATAL_NOTIFIER_TYPE_CODE",del
						,"LABOUR_ONSET_TYPE_CODE",del
						,"LABOUR_INDUCED_OXYTOCINS_FLAG",del
						,"LABOUR_INDUCED_ARM_FLAG",del
						,"LABOUR_INDUCED_PROSTAGLANDINS_FLAG",del
						,"LABOUR_INDUCED_OTHER_FLAG",del
						,"LABOUR_INDUCED_MAIN_INDICATION_CODE",del
						,"LABOUR_AUGMENTED_OXYTOCINS_FLAG",del
						,"LABOUR_AUGMENTED_ARM_FLAG",del
						,"PRESENTATION_AT_BIRTH_CODE",del
						,"LABOUR_ANALG_NONE_FLAG",del
						,"LABOUR_ANALG_NITROUS_OXIDE_FLAG",del
						,"LABOUR_ANALG_SYSTEMIC_OPIOIDS_FLAG",del
						,"LABOUR_ANALG_SPINAL_FLAG",del
						,"LABOUR_ANALG_EPIDURAL_CAUDAL_FLAG",del
						,"LABOUR_ANALG_COMB_SPINAL_EPIDURAL_FLAG",del
						,"LABOUR_ANALG_OTHER_FLAG",del
						,"NEWBORN_BIRTH_TYPE_CODE",del
						,"MAIN_INDICATION_FOR_C_SECTION_CODE",del
						,"DELIVERY_ANAES_NONE_FLAG",del
						,"DELIVERY_ANAES_LOCAL_PERINEUM_FLAG",del
						,"DELIVERY_ANAES_PUDENDAL_FLAG",del
						,"DELIVERY_ANAES_SPINAL_FLAG",del
						,"DELIVERY_ANAES_EPIDURAL_CAUDAL_FLAG",del
						,"DELIVERY_ANAES_COMB_SPINAL_EPIDURAL_FLAG",del
						,"DELIVERY_ANAES_GENERAL_FLAG",del
						,"DELIVERY_ANAES_OTHER_FLAG",del
						,"PERINEAL_STATUS_CODE",del
						,"PERINEAL_EPISIOTOMY_INDICATOR",del
						,"PERINEAL_SURGICAL_REPAIR_INDICATOR",del
						,"PERINEAL_3RD_STAGE_MANAGEMENT_TYPE_CODE",del
						,"MAIN_MATERNITY_MOC_ANTENATAL_CODE",del
						,"MAIN_MATERNITY_MOC_BIRTH_CODE",del
						,"POSTPARTUM_HAEMORRHAGE_FLAG",del
						,"BLOOD_TRANSFUSION_PPH_FLAG",del
						,"BLOOD_LOSS_VOLUME_ESTIMATE_CODE",del
						,"NEWBORN_GIVEN_NAME",del
						,"NEWBORN_MIDDLE_NAMES",del
						,"NEWBORN_FAMILY_NAME",del
						,"NEWBORN_SEX_CODE",del
						,"NEWBORN_DATE_OF_BIRTH",del
						,"NEWBORN_INDIGENOUS_STATUS_CODE",del
						,"NEWBORN_BIRTH_STATUS_CODE",del
						,"NEWBORN_BIRTH_ORDER_CODE",del
						,"NEWBORN_BIRTH_WEIGHT_GRAMS",del
						,"NEWBORN_EST_GESTATIONAL_AGE_WEEK_COUNT",del
						,"NEWBORN_APGAR_1_MINUTE_SCORE",del
						,"NEWBORN_APGAR_5_MINUTES_SCORE",del
						,"NEWBORN_RESUSCITATION_TYPE_CODE",del
						,"NEWBORN_PLACE_OF_BIRTH_CODE",del
						,"NEWBORN_DISCH_FEED_BREAST_FLAG",del
						,"NEWBORN_DISCH_FEED_EXP_BREAST_MILK_FLAG",del
						,"NEWBORN_DISCH_FEED_INFANT_FORMULAE_FLAG",del
						,"NEWBORN_DISCH_FEED_NOT_APPLICABLE_FLAG",del
						,"NEWBORN_CONGENITAL_CONDITION_FLAG",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_1",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_2",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_3",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_4",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_5",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_6",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_7",del
						,"NEWBORN_CONGENITAL_CONDITION_DESC_8",del
						,"NEWBORN_HEP_B_BIRTH_DOSE_FLAG",del
						,"NEWBORN_CLIENT_ID_TYPE_CODE",del
						,"NEWBORN_CLIENT_ID_ISSUING_AUTHORITY",del
						,"NEWBORN_CLIENT_ID",del
						,"NEWBORN_SERVICE_EVENT_SOURCE_ID",del
						,"NEWBORN_SERVICE_ENCOUNTER_RECORD_ID",del
						,"NEWBORN_SERVICE_EVENT_RECORD_ID",del
						,"NEWBORN_FORMAL_DISCHARGE_MODE_CODE",del
						,"NEWBORN_FORMAL_DISCHARGE_DATETIME",del
						,"NEWBORN_TRANSFER_TO_OSP_ID"
                           )

	baby->file_buf = outstring
	stat = cclio("PUTS", baby)

      detail
      if (babies->cnt > 0)
		 outstring = build2(trim(substring(1,12,opts->source_system_id)),del_tmp
                            ,trim(substring(1,12,cnvtstring(batch_seq))),del_tmp
                            ,trim(babies->details[d1.seq].create_dt_tm),del_tmp
                            ,trim(babies->details[d1.seq].modified_dt_tm),del_tmp
                            ,trim(babies->details[d1.seq].action_type),del_tmp
                            ,trim(substring(1,12,opts->source_system_id)),del_tmp
							,trim(babies->details[d1.seq].perinatal_preg_record_id),del_tmp
							,trim(babies->details[d1.seq].birth_record_id),del_tmp
							,"1",del_tmp
							,trim(babies->details[d1.seq].labour_onset_type_code),del_tmp
							,trim(babies->details[d1.seq].labour_ind_oxy_flag),del_tmp
							,trim(babies->details[d1.seq].labour_ind_arm_flag),del_tmp
							,trim(babies->details[d1.seq].labour_ind_pros_flag),del_tmp
							,trim(babies->details[d1.seq].labour_ind_oth_flag),del_tmp
							,trim(babies->details[d1.seq].labour_ind_main_code),del_tmp
							,trim(babies->details[d1.seq].labour_aug_oxy_flag),del_tmp
							,trim(babies->details[d1.seq].labour_aug_arm_flag),del_tmp
							,trim(babies->details[d1.seq].presentation_at_birth_code),del_tmp
							,trim(babies->details[d1.seq].labour_analg_none_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_nito_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_syso_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_spin_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_epidc_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_cse_flag),del_tmp
							,trim(babies->details[d1.seq].labour_analg_oth_flag),del_tmp
							,trim(babies->details[d1.seq].newborn_birth_type_code),del_tmp
							,trim(babies->details[d1.seq].main_ind_csect_code),del_tmp
							,trim(babies->details[d1.seq].del_anaes_none_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_locp_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_pud_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_spin_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_epidc_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_combse_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_gen_flag),del_tmp
							,trim(babies->details[d1.seq].del_anaes_oth_flag),del_tmp
							,trim(babies->details[d1.seq].perineal_status_code),del_tmp
							,trim(babies->details[d1.seq].perineal_epis_ind),del_tmp
							,trim(babies->details[d1.seq].perineal_surg_rep_ind),del_tmp
							,trim(babies->details[d1.seq].perineal_third_stmt_code),del_tmp
							,trim(babies->details[d1.seq].main_mat_moc_ant_code),del_tmp
							,trim(babies->details[d1.seq].main_mat_moc_birth_code),del_tmp
							,trim(babies->details[d1.seq].postp_haem_flag),del_tmp
							,trim(babies->details[d1.seq].blood_tran_pph_flag),del_tmp
							,trim(babies->details[d1.seq].blood_loss_vol_ext_code),del_tmp
							,trim(babies->details[d1.seq].given_name),del_tmp
							,trim(babies->details[d1.seq].middle_names),del_tmp
							,trim(babies->details[d1.seq].family_name),del_tmp
							,trim(babies->details[d1.seq].gender),del_tmp
							,trim(babies->details[d1.seq].dob),del_tmp
							,trim(babies->details[d1.seq].ind_stat_code),del_tmp
							,trim(babies->details[d1.seq].birth_stat_code),del_tmp
							,trim(babies->details[d1.seq].birth_ord_code),del_tmp
							,trim(babies->details[d1.seq].birth_weight),del_tmp
							,trim(babies->details[d1.seq].est_gest_age_week_cnt),del_tmp
							,trim(babies->details[d1.seq].apgar_onemin_score),del_tmp
							,trim(babies->details[d1.seq].apgar_fivemin_score),del_tmp
							,trim(babies->details[d1.seq].resus_type_code),del_tmp
							,trim(babies->details[d1.seq].place_of_birth),del_tmp
							,trim(babies->details[d1.seq].disch_feed_breast_flag),del_tmp
							,trim(babies->details[d1.seq].disch_feed_exp_breast_milk_flag),del_tmp
							,trim(babies->details[d1.seq].disch_feed_inf_form_flag),del_tmp
							,trim(babies->details[d1.seq].disch_feed_not_app_flag),del_tmp
							,trim(babies->details[d1.seq].cong_cond_flag),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_1),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_2),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_3),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_4),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_5),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_6),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_7),del_tmp
							,trim(babies->details[d1.seq].cong_cond_desc_8),del_tmp
							,trim(babies->details[d1.seq].hepb_birth_dose_flag),del_tmp
							,"016",del_tmp
							,trim(babies->details[d1.seq].client_id_issue_auth),del_tmp
							,trim(babies->details[d1.seq].client_id),del_tmp
							,trim(substring(1,12,opts->source_system_id)),del_tmp
							,trim(babies->details[d1.seq].service_encntr_rec_id),del_tmp
							,trim(babies->details[d1.seq].service_event_rec_id),del_tmp
							,trim(babies->details[d1.seq].formal_discharge_mode_code),del_tmp
							,trim(babies->details[d1.seq].formal_discharge_dt_tm),del_tmp
							,trim(babies->details[d1.seq].transfer_to_osp_id))
			call clean_string(outstring)
			outstring = concat(crlf, outstring)

			baby->file_buf = outstring
			stat = cclio("PUTS", baby)
        endif

		with format=stream, maxcol = 5000,  noformfeed, maxrow=1

   set stat = cclio("CLOSE", baby)
   free record baby

   call update_seq("PDC")
   call header_add_obj_info("NSWEDW207",ext_filename,babies->cnt)
   call write_header(cnvtreal(PDC_CONTAINER),cnvtreal(0))
   call ftp_add_file(ext_filename,1)
   call edwftp_send(null)
end

end
go
