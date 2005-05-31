ad_page_contract {
	Delete a list of expenses

	@author Hamilton Chua (hamilton.chua@gmail.com)
	@creation-date 2005-05-14
	@cvs-id $Id$
} {
	exp_id:notnull
} -errors {
	exp_id:notnull "At least one expense id is required"
}

foreach id $exp_id {
	exptrack::delete_expense -exp_id $id
}

ad_returnredirect "index"
