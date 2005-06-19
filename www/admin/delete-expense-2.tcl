ad_page_contract {
	Delete a list of expenses

	@author Hamilton Chua (hamilton.chua@gmail.com)
	@creation-date 2005-05-14
	@cvs-id $Id$
} {
	exp_id:notnull
	{return_url ""}
} -errors {
	exp_id:notnull "At least one expense id is required"
}

foreach id $exp_id {
	exptrack::delete_expense -exp_id $id
}

if { [empty_string_p $return_url] } {
	ad_returnredirect "index"
} else {
	ad_returnredirect $return_url
}
