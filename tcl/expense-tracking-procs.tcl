ad_library {

    Expense Tracking procs.

	@author Hamilton Chua (hamilton.chua@gmail.com)
	@creation-date 2005-05-14
	@cvs-id $Id$
}

namespace eval exptrack {

ad_proc delete_expense {
	{-exp_id:required }
} {
	HAM (hamilton.chua@gmail.com)
	Delete an expense item.
} {
	db_transaction { db_exec_plsql delete_q {} }
}

ad_proc add_expense {
	{-id:required}
	{-expense:required}
	{-date }
	{-amount }
	{-class_key }
	{-user_id }
	{-community_id }
} {
	HAM (hamilton.chua@gmail.com)
	Add expense item
} {
	set package_id [ad_conn package_id]
	set creation_ip [ns_conn peeraddr]	
	
	db_transaction {
		set exp_id [db_exec_plsql add_q {}]
	}

	# db_dml "add_expense" "insert into expenses (exp_id, exp_expense, exp_date, exp_amount, user_id, class_key, community_id, package_id) values (:id,:expense,:date,:amount,:user_id, :class_key,:community_id, :package_id)"
}

ad_proc update_expense {
	{-id:required}
	{-expense:required}
	{-date }
	{-amount }
	{-class_key }
	{-user_id }
	{-community_id }
} {
	HAM (hamilton.chua@gmail.com)
	Add expense item
} {

	db_transaction {
		set exp_id [db_exec_plsql update_q {}]
	}

	# db_dml "update_expense" "update expenses set exp_expense = :expense, exp_date = :date, exp_amount = :amount, class_key = :class_key, user_id = :user_id, community_id = :community_id where exp_id = :id"
}

ad_proc get_expense {
	{-id:required }
} {
	HAM (hamilton.chua@gmail.com)
	Retrieve expense record and put it into an array
} {
	if { [db_0or1row "get_expense" "select exp_id, exp_expense, to_char(exp_date,'YYYY-MM-DD') as exp_date, exp_amount, user_id, class_key, community_id, exp_exported from expenses where exp_id = :id" -column_array exp_item] } {
		return [array get exp_item]
	} else {
		return {}
	}
}

}