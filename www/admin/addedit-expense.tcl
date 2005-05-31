ad_page_contract {
	Add new expense

	@author Hamilton Chua (hamilton.chua@gmail.com)
	@creation-date 2005-05-14
	@cvs-id $Id$

}  {
	{ exp_id:integer,optional }
}

# initial vars
set package_id [ad_conn package_id]
set package_url [apm_package_url_from_id $package_id]
set user_id [auth::get_user_id]
set return_url "$package_url/admin"
set title "Add Expense"
set expenses_package_id [expenses::get_package_id]

# HAM : FIXME
# do we still need to detect class_key ?
set class_key ""
set community_id [dotlrn_community::get_community_id]

# determine if we're editing or adding
if {[ad_form_new_p -key exp_id]} {
        # new entry		
        set cancel_url $return_url
}  else {
	set title "Edit Expense"
	set cancel_url $return_url
}

# generate the form

ad_form -name new_expense  \
-export { return_url } \
-form {
	exp_id:key(acs_object_id_seq)
	{ expense:text
		{ label "Expense" } }
    	{ exp_date:text(text)
        	{label "Date"}
        	{html {id sel1}}
        	{after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('sel1', 'y-m-d');\"> \[<b>y-m-d </b>\]} } }
	{ exp_amount:currency,to_sql(sql_number)
		{ label "Amount" } }
} 

# add support for categories
category::ad_form::add_widgets \
    -container_object_id $expenses_package_id \
    -categorized_object_id [value_if_exists exp_id] \
    -form_name new_expense

ad_form -extend -name new_expense -new_request {
	set exp_amount [template::util::currency::create "$" "0" "." "00" ]
} -edit_request {
	array set exp_item [exptrack::get_expense -id $exp_id]
	set expense $exp_item(exp_expense)
	set exp_date $exp_item(exp_date)
	set amount_split [split $exp_item(exp_amount) .]
	set exp_amount [template::util::currency::create "$" [lindex $amount_split 0] "." [lindex $amount_split 1] ]
} -validate {
	{exp_amount
	 { ![template::util::negative [template::util::currency::get_property whole_part $exp_amount]] }
 	 "Amount can not be negative"
	}
	{exp_amount 
	 { !"[template::util::currency::get_property whole_part $exp_amount].[template::util::currency::get_property fractional_part $exp_amount]" == "0.00" }
	 "Amount can not be zero"
	}
} -on_submit {
        set category_ids [category::ad_form::get_categories -container_object_id $expenses_package_id]
} -new_data {
	exptrack::add_expense -id $exp_id -date $exp_date -expense $expense -amount $exp_amount -class_key $class_key -user_id $user_id -community_id $community_id
	category::map_object -remove_old -object_id $exp_id $category_ids
} -edit_data {
	exptrack::update_expense -id $exp_id -date $exp_date -expense $expense -amount $exp_amount -class_key $class_key -user_id $user_id -community_id $community_id
	category::map_object -remove_old -object_id $exp_id $category_ids
} -after_submit {
	ad_returnredirect "$package_url/admin"
	ad_script_abort
}

